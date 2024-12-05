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

    public List<Reservation> getReservations(String search, String dateFrom, String dateTo, Integer status, int page, int pageSize) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.ReservationId, r.ReservationDate, r.Status, "
                + "p.PersonId, p.PersonName AS CustomerName, "
                + "s.ServiceId, s.ServiceName, s.Price AS TotalCost "
                + "FROM Reservation r "
                + "JOIN Person p ON r.CustomerId = p.PersonId "
                + "JOIN Services_Reservations sr ON r.ReservationId = sr.ReservationId "
                + "JOIN Service s ON sr.ServiceId = s.ServiceId "
                + "WHERE 1=1 ";

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

        sql += "ORDER BY r.ReservationId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

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
            stm.setInt(index++, (page - 1) * pageSize);
            stm.setInt(index++, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                // Tạo đối tượng Reservation
                Reservation reservation = new Reservation();
                reservation.setReservationId(rs.getInt("ReservationId"));
                reservation.setReservationDate(rs.getDate("ReservationDate"));
                reservation.setStatus(rs.getInt("Status"));

                // Tạo đối tượng Person
                Person customer = new Person();
                customer.setPersonId(rs.getInt("PersonId"));
                customer.setPersonName(rs.getString("CustomerName"));
                reservation.setCustomer(customer);

                // Tạo đối tượng Service
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

    public static void main(String[] args) {
        ReservationDAO dao = new ReservationDAO();
        List<Reservation> reservations = dao.getReservations("", "2024-01-01", "2024-12-31", null, 1, 10);

        for (Reservation reservation : reservations) {
            System.out.println("Reservation ID: " + reservation.getReservationId());
            System.out.println("Reservation Date: " + reservation.getReservationDate());
            System.out.println("Status: " + reservation.getStatus());
            System.out.println("Customer Name: " + reservation.getCustomer().getPersonName());
            System.out.println("Service Name: " + reservation.getService().getServiceName());
            System.out.println("Total Cost: " + reservation.getService().getPrice());
            System.out.println("--------------------------------------------");
        }
    }

}
