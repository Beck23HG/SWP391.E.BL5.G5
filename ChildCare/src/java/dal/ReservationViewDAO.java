/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Blog;
import model.Category;
import model.Person;
import model.Reservation;
import model.Role;
import model.Service;
import org.apache.tomcat.jakartaee.commons.lang3.ObjectUtils.Null;

/**
 *
 * @author admin
 */
public class ReservationViewDAO extends DBContext {

    public List<Service> getAllService() {
        List<Service> services = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Service";

            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
//    private int serviceId, status, staffId, managerId;
//    private String serviceName, description, image;
//    private float price;

            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setStatus(rs.getInt("Status"));
                service.setManagerId(rs.getInt("ManagerId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("price"));
                service.setImage(rs.getString("image"));

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public List<Service> searchServices(String keyword) {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Service WHERE ServiceName LIKE ? OR Description LIKE ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            statement.setString(2, "%" + keyword + "%");

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setStatus(rs.getInt("Status"));
                service.setManagerId(rs.getInt("ManagerId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("price"));
                service.setImage(rs.getString("image"));

                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public List<Person> getDoctorsIsActive() {
        List<Person> doctors = new ArrayList<>();
        String sql = "SELECT * FROM Person p \n"
                + "  JOIN Account a ON p.PersonId = a.PersonId\n"
                + "  JOIN Role r ON r.RoleId = a.RoleId\n"
                + "  WHERE r.RoleId = 2 AND p.StaffStatus = 1;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Person doctor = new Person();
                doctor.setPersonId(rs.getInt("personId"));
                doctor.setPersonName(rs.getString("personName"));
                doctor.setImage(rs.getString("image"));
                doctor.setEmail(rs.getString("email"));
                doctor.setPhone(rs.getString("phone"));
                // Set other properties as needed
                doctors.add(doctor);
            }
        } catch (SQLException e) {
            System.out.println("Error getting doctors: " + e.getMessage());
        }

        return doctors;
    }

    public int createPerson(Person person) {
        String sql = "INSERT INTO Person (PersonName, Phone, Email, Address, Gender) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setString(1, person.getPersonName());
            st.setString(2, person.getPhone());
            st.setString(3, person.getEmail());
            st.setString(4, person.getAddress());
            st.setBoolean(5, person.isGender());

            st.executeUpdate();

            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in createPerson: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int createReservation(Reservation reservation, String reservationDate) {
        String sql = "INSERT INTO Reservation (CustomerId, Status, Note, Created_Date, ReservationDate, StaffId) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, reservation.getCustomerId());
            st.setInt(2, 1); // Initial status
            st.setString(3, reservation.getNote());
            st.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis())); // Created date

            // Convert reservation date string to Timestamp
            st.setString(5, reservationDate);

            st.setInt(6, reservation.getStaffId()); // Selected doctor ID

            st.executeUpdate();

            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in createReservation: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public void createServiceReservation(int serviceId, int reservationId) {
        String sql = "INSERT INTO Services_Reservations (ServiceId, ReservationId) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, serviceId);
            st.setInt(2, reservationId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in createServiceReservation: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public Person getDoctorByReservationId(int reservationId) {
        String sql = "SELECT *\n"
                + "  FROM Person p\n"
                + "  JOIN Reservation r ON p.PersonId = r.StaffId\n"
                + "  WHERE r.ReservationId = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, reservationId);
            
             try (ResultSet rs = st.executeQuery();) {
                if (rs.next()) {
                    Person person = new Person();
                    person.setPersonId(rs.getInt("personId"));
                    person.setPersonName(rs.getString("personName"));
                    person.setDateOfBirth(rs.getDate("dateOfBirth"));
                    person.setGender(rs.getBoolean("gender"));
                    person.setEmail(rs.getString("email"));
                    person.setPhone(rs.getString("phone"));
                    person.setAddress(rs.getString("address"));
                    person.setImage(rs.getString("image"));
  
                    return person;
                }
            }    
        } catch (SQLException e) {
            System.out.println("Error getting doctors: " + e.getMessage());
        }
        return null;
    }

    public List<Service> getListServiceByReservationId(int reservationId) {
        List<Service> serviceList = new ArrayList<>();
        String sql = "select s.ServiceId, s.ServiceName, s.Price, s.Description, s.Image , r.reservationId \n"
                + "  from Service s\n"
                + "  join Services_Reservations sr on sr.ServiceId = s.ServiceId\n"
                + "  join Reservation r on r.ReservationId = sr.ReservationId\n"
                + "  join Person p on p.PersonId = r.StaffId\n"
                + "  where r.ReservationId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, reservationId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("serviceId"));
                service.setServiceName(rs.getString("serviceName"));
                service.setPrice(rs.getFloat("price"));
                service.setDescription(rs.getString("description"));
                service.setImage(rs.getString("image"));
                Reservation rv = new Reservation();
                rv.setReservationId(rs.getInt("reservationId"));
                service.setReservation(rv);
                serviceList.add(service);
            }
            return serviceList;
        } catch (SQLException e) {
            System.out.println("Error getting doctors: " + e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        ReservationViewDAO x = new ReservationViewDAO();
        System.out.println(x.getListServiceByReservationId(39));
    }
}
