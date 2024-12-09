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
import model.Blog;
import model.Category;
import model.Person;
import model.Reservation;
import model.Service;

/**
 *
 * @author admin
 */
public class ReservationViewDAO extends DBContext {

    public List<Service> getAllService() {
        List<Service> services = new ArrayList<>();

        try {
            String sql = "select * from service";

            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
//    private int serviceId, status, staffId, managerId;
//    private String serviceName, description, image;
//    private float price;

    while (rs.next () 
        ) {
                Service service = new Service();
        service.setServiceId(rs.getInt("ServiceId"));
        service.setStatus(rs.getInt("Status"));
        service.setStaffId(rs.getInt("StaffId"));
        service.setManagerId(rs.getInt("ManagerId"));
        service.setServiceName(rs.getString("ServiceName"));
        service.setDescription(rs.getString("Description"));
        service.setPrice(rs.getFloat("price"));
        service.setImage(rs.getString("image"));

        services.add(service);
    }
}
catch (SQLException e) {
            e.printStackTrace();
        }
        return  services;
    }
    public List<Service> searchServices(String keyword) {
    List<Service> services = new ArrayList<>();
    try {
        String sql = "SELECT * FROM service WHERE ServiceName LIKE ? OR Description LIKE ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, "%" + keyword + "%");
        statement.setString(2, "%" + keyword + "%");
        
        ResultSet rs = statement.executeQuery();
        
        while (rs.next()) {
            Service service = new Service();
            service.setServiceId(rs.getInt("ServiceId"));
            service.setStatus(rs.getInt("Status"));
            service.setStaffId(rs.getInt("StaffId"));
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
     public int createPerson(Person person) {
        String sql = "INSERT INTO Person (PersonName, Phone,DateOfBirth, Email, Address, Gender, StaffStatus) "
                  + "VALUES (?, ?,'1985-08-22', ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setString(1, person.getPersonName());
            st.setString(2, person.getPhone());
            st.setString(3, person.getEmail());
            st.setString(4, person.getAddress());
            st.setBoolean(5, person.isGender());
            st.setInt(6, 0);
            
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
    
    public int createReservation(Reservation reservation) {
        String sql = "INSERT INTO Reservation (CustomerId, Status, Note, Created_Date, ReservationDate,StaffId) "
                  + "VALUES (?, ?, ?, ?, ?, 1)";
        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, reservation.getCustomerId());
            st.setInt(2, 1);
            st.setString(3, reservation.getNote());
            st.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis()));
            st.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
            
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
        String sql = "INSERT INTO Service_Reservation (ServiceId, ReservationId) VALUES (?, ?)";
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
    public static void main(String[] args) {
        ReservationViewDAO x = new ReservationViewDAO();
        System.out.println(x.getAllService());
    }
}


