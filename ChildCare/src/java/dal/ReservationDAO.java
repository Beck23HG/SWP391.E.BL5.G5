package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Person;
import model.Reservation;
import model.Service;

/**
 *
 * @author fpt
 */
public class ReservationDAO extends DBContext {

    public List<Reservation> getReservations(String search, String dateFrom, String dateTo, Integer status, int staffId, int page, int pageSize) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.ReservationId, r.Created_Date AS ReservationCreationDate, r.Status, "
                + "p.PersonId, p.PersonName AS CustomerName, "
                + "s.ServiceId, s.ServiceName, s.Price AS TotalCost "
                + "FROM Reservation r "
                + "JOIN Person p ON r.CustomerId = p.PersonId "
                + "JOIN Services_Reservations sr ON r.ReservationId = sr.ReservationId "
                + "JOIN Service s ON sr.ServiceId = s.ServiceId "
                + "WHERE r.StaffId = ? "; // Filter by Staff ID

        if (search != null && !search.isEmpty()) {
            sql += "AND (r.ReservationId LIKE ? OR p.PersonName LIKE ?) ";
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql += "AND r.Created_Date >= ? ";
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql += "AND r.Created_Date <= ? ";
        }
        if (status != null) {
            sql += "AND r.Status = ? ";
        }

        sql += "ORDER BY r.ReservationId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int index = 1;
            stm.setInt(index++, staffId); // Bind Staff ID
            if (search != null && !search.isEmpty()) {
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                stm.setString(index++, dateFrom);
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                stm.setString(index++, dateTo);
            }
            if (status != null) {
                stm.setInt(index++, status);
            }
            stm.setInt(index++, (page - 1) * pageSize);
            stm.setInt(index++, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationId(rs.getInt("ReservationId"));
                reservation.setCreated_Date(rs.getDate("ReservationCreationDate")); // Updated field
                reservation.setStatus(rs.getInt("Status"));

                Person customer = new Person();
                customer.setPersonId(rs.getInt("PersonId"));
                customer.setPersonName(rs.getString("CustomerName"));
                reservation.setCustomer(customer);

                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("TotalCost"));
                reservation.setService(service);

                reservations.add(reservation);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return reservations;
    }

    public int getReservationCount(String search, String dateFrom, String dateTo, Integer status) {
        String sql = "SELECT COUNT(*) AS Total FROM Reservation r "
                + "JOIN Person p ON r.CustomerId = p.PersonId "
                + "JOIN Account a ON p.PersonId = a.PersonId "
                + "JOIN Role ro ON a.RoleId = ro.RoleId "
                + "WHERE ro.RoleId = 1 ";

        if (search != null && !search.isEmpty()) {
            sql += "AND (r.ReservationId LIKE ? OR p.PersonName LIKE ?) ";
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql += "AND r.ReservationDate >= ? ";
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql += "AND r.ReservationDate <= ? ";
        }
        if (status != null) {
            sql += "AND r.Status = ? ";
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int index = 1;

            if (search != null && !search.isEmpty()) {
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                stm.setString(index++, dateFrom);
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                stm.setString(index++, dateTo);
            }
            if (status != null) {
                stm.setInt(index++, status);
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Hàm lấy thông tin chi tiết của Reservation, bao gồm Reservation Name
    public Reservation getReservationDetail(int reservationId) {
        Reservation reservation = null;
        String sql = "SELECT r.ReservationId, r.ReservationDate, r.Status, r.Note, "
                + "c.PersonId AS CustomerId, c.PersonName AS CustomerName, c.Email AS CustomerEmail, c.Phone AS CustomerPhone, "
                + "c.Address AS CustomerAddress, c.Gender AS CustomerGender, "
                + "SUM(s.Price) AS TotalCost, "
                + "STRING_AGG(s.ServiceName, ', ') AS ReservationName " // Kết hợp tên dịch vụ
                + "FROM Reservation r "
                + "JOIN Person c ON r.CustomerId = c.PersonId "
                + "JOIN Services_Reservations sr ON r.ReservationId = sr.ReservationId "
                + "JOIN Service s ON sr.ServiceId = s.ServiceId "
                + "WHERE r.ReservationId = ? "
                + "GROUP BY r.ReservationId, r.ReservationDate, r.Status, r.Note, "
                + "c.PersonId, c.PersonName, c.Email, c.Phone, c.Address, c.Gender";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, reservationId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                reservation = new Reservation();
                reservation.setReservationId(rs.getInt("ReservationId"));
                reservation.setReservationDate(rs.getDate("ReservationDate"));
                reservation.setStatus(rs.getInt("Status"));
                reservation.setNote(rs.getString("ReservationName")); // Gán Reservation Name

                Person customer = new Person();
                customer.setPersonId(rs.getInt("CustomerId"));
                customer.setPersonName(rs.getString("CustomerName"));
                customer.setEmail(rs.getString("CustomerEmail"));
                customer.setPhone(rs.getString("CustomerPhone"));
                customer.setAddress(rs.getString("CustomerAddress"));
                customer.setGender(rs.getBoolean("CustomerGender"));
                reservation.setCustomer(customer);

//                reservation.setTotalCost(rs.getFloat("TotalCost")); // Gán Total Cost
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return reservation;
    }

    // Hàm cập nhật trạng thái Reservation
    public boolean updateReservationStatus(int reservationId, int newStatus) {
        String sql = "UPDATE Reservation SET Status = ? WHERE ReservationId = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, newStatus);
            stm.setInt(2, reservationId);
            int rowsUpdated = stm.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Hàm lấy danh sách các dịch vụ của Reservation
    public List<Service> getReservedServices(int reservationId) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT s.ServiceId, s.ServiceName, s.Price, s.Image, s.Description "
                + "FROM Services_Reservations sr "
                + "JOIN Service s ON sr.ServiceId = s.ServiceId "
                + "WHERE sr.ReservationId = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, reservationId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setImage(rs.getString("Image"));
                service.setDescription(rs.getString("Description"));
                services.add(service);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return services;
    }

    // Customer list screen
    public List<Reservation> getCustomerReservations(int customerId, String serviceName, String dateFrom, String dateTo, int page, int pageSize) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.ReservationId, r.ReservationDate, r.Created_Date, r.Status, "
                + "s.ServiceName, s.Price AS TotalCost "
                + "FROM Reservation r "
                + "JOIN Services_Reservations sr ON r.ReservationId = sr.ReservationId "
                + "JOIN Service s ON sr.ServiceId = s.ServiceId "
                + "WHERE r.CustomerId = ? ";

        if (serviceName != null && !serviceName.isEmpty()) {
            sql += "AND s.ServiceName LIKE ? ";
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql += "AND r.Created_Date >= ? ";
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql += "AND r.Created_Date <= ? ";
        }

        sql += "ORDER BY r.ReservationId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int index = 1;
            stm.setInt(index++, customerId);

            if (serviceName != null && !serviceName.isEmpty()) {
                stm.setString(index++, "%" + serviceName + "%");
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                stm.setString(index++, dateFrom);
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                stm.setString(index++, dateTo);
            }

            stm.setInt(index++, (page - 1) * pageSize);
            stm.setInt(index++, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationId(rs.getInt("ReservationId"));
                reservation.setReservationDate(rs.getDate("ReservationDate"));
                reservation.setCreated_Date(rs.getDate("Created_Date"));
                reservation.setStatus(rs.getInt("Status"));

                Service service = new Service();
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("TotalCost"));
                reservation.setService(service);

                reservations.add(reservation);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return reservations;
    }

    //Customer list screen
    public int getCustomerReservationCount(int customerId, String serviceName, String dateFrom, String dateTo) {
        String sql = "SELECT COUNT(*) AS Total FROM Reservation r "
                + "JOIN Services_Reservations sr ON r.ReservationId = sr.ReservationId "
                + "JOIN Service s ON sr.ServiceId = s.ServiceId "
                + "WHERE r.CustomerId = ? ";

        if (serviceName != null && !serviceName.isEmpty()) {
            sql += "AND s.ServiceName LIKE ? ";
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql += "AND r.Created_Date >= ? ";
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql += "AND r.Created_Date <= ? ";
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int index = 1;
            stm.setInt(index++, customerId);

            if (serviceName != null && !serviceName.isEmpty()) {
                stm.setString(index++, "%" + serviceName + "%");
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                stm.setString(index++, dateFrom);
            }
            if (dateTo != null && !dateTo.isEmpty()) {
                stm.setString(index++, dateTo);
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

}
