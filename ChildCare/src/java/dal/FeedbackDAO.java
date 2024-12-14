/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Person;
import model.Service;

/**
 *
 * @author Admin
 */
public class FeedbackDAO extends DBContext{
    public List<Feedback> getSixFeedbacks() {
        List<Feedback> feedbacks = new ArrayList<>();
        try {
            String sql = "SELECT top 6 * FROM Feedback f join Person p on f.CustomerId = p.PersonId join Service s on f.ServiceId = s.ServiceId";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("FeedbackId"));
                feedback.setContent(rs.getString("Content"));
                feedback.setCustomerId(rs.getInt("CustomerId"));
                feedback.setServiceId(rs.getInt("ServiceId"));
                feedback.setStarRating(rs.getInt("StarRating"));
                feedback.setResponseFeedback(rs.getString("ResponseFeedback"));
                
                Person person = new Person();
                person.setPersonId(rs.getInt("PersonId"));
                person.setPersonName(rs.getString("PersonName"));
                person.setDateOfBirth(rs.getDate("DateOfBirth"));
                person.setGender(rs.getBoolean("Gender"));
                person.setPhone(rs.getString("Phone"));
                person.setEmail(rs.getString("Email"));
                person.setAddress(rs.getString("Address"));
                person.setImage(rs.getString("Image"));
                person.setStaffStatus(rs.getInt("StaffStatus"));
                feedback.setPerson(person);
                
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                feedback.setService(service);
                
                feedbacks.add(feedback);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return feedbacks;
    }
    
    public List<Feedback> getAllFeedbacks(){
        List<Feedback> feedbackList = new ArrayList<>();
        try {
            String sql = "SELECT f.*, p.PersonName, s.ServiceName " +
                        "FROM Feedback f " +
                        "JOIN Person p ON f.CustomerId = p.PersonId " +
                        "JOIN Service s ON f.ServiceId = s.ServiceId";
                        
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while(rs.next()){
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("FeedbackId"));
                fb.setContent(rs.getString("Content"));
                fb.setStarRating(rs.getInt("StarRating"));
                fb.setResponseFeedback(rs.getString("ResponseFeedback"));
                
                Person person = new Person();
                person.setPersonId(rs.getInt("CustomerId"));
                person.setPersonName(rs.getString("PersonName"));
                fb.setPerson(person);
                
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                fb.setService(service);
                
                feedbackList.add(fb);
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
        }
        return feedbackList;
    }
    
    public static void main(String[] args) {
        FeedbackDAO x = new FeedbackDAO();
        List<Feedback> feedbackList = x.getAllFeedbacks();
        for(Feedback feedback : feedbackList){
            System.out.println("Feedback Content: " + feedback.getContent());
        }
    }
    
    // Phương thức lấy tổng số feedback để phân trang
    public int getTotalFeedbacks(String searchQuery, Integer serviceId, Integer rating) {
        int total = 0;
        try {
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) as total FROM Feedback f "
                    + "JOIN Person p ON f.CustomerId = p.PersonId "
                    + "JOIN Service s ON f.ServiceId = s.ServiceId WHERE 1=1");
            
            List<Object> params = new ArrayList<>();
            
            // Thêm điều kiện tìm kiếm
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql.append(" AND (p.PersonName LIKE ? OR f.Content LIKE ?)");
                params.add("%" + searchQuery + "%");
                params.add("%" + searchQuery + "%");
            }
            
            // Lọc theo service
            if (serviceId != null) {
                sql.append(" AND f.ServiceId = ?");
                params.add(serviceId);
            }
            
            // Lọc theo rating
            if (rating != null) {
                sql.append(" AND f.StarRating = ?");
                params.add(rating);
            }
            
            PreparedStatement st = connection.prepareStatement(sql.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
    // Phương thức lấy feedback có phân trang và lọc
    public List<Feedback> getFeedbacksWithPaging(int page, int pageSize, String searchQuery, 
            Integer serviceId, Integer rating, String sortColumn, String sortOrder) {
        List<Feedback> feedbackList = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT f.*, p.PersonName, s.ServiceName "
                    + "FROM Feedback f "
                    + "JOIN Person p ON f.CustomerId = p.PersonId "
                    + "JOIN Service s ON f.ServiceId = s.ServiceId WHERE 1=1");
            
            List<Object> params = new ArrayList<>();
            
            // Thêm điều kiện tìm kiếm
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql.append(" AND (p.PersonName LIKE ? OR f.Content LIKE ?)");
                params.add("%" + searchQuery + "%");
                params.add("%" + searchQuery + "%");
            }
            
            // Lọc theo service
            if (serviceId != null) {
                sql.append(" AND f.ServiceId = ?");
                params.add(serviceId);
            }
            
            // Lọc theo rating
            if (rating != null) {
                sql.append(" AND f.StarRating = ?");
                params.add(rating);
            }
            
            // Thêm sắp xếp
            if (sortColumn != null && !sortColumn.isEmpty()) {
                sql.append(" ORDER BY ").append(sortColumn);
                if ("DESC".equalsIgnoreCase(sortOrder)) {
                    sql.append(" DESC");
                } else {
                    sql.append(" ASC");
                }
            } else {
                sql.append(" ORDER BY f.FeedbackId DESC");
            }
            
            // Thêm phân trang
            sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add((page - 1) * pageSize);
            params.add(pageSize);
            
            PreparedStatement st = connection.prepareStatement(sql.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("FeedbackId"));
                fb.setContent(rs.getString("Content"));
                fb.setStarRating(rs.getInt("StarRating"));
                fb.setResponseFeedback(rs.getString("ResponseFeedback"));
                
                Person person = new Person();
                person.setPersonId(rs.getInt("CustomerId"));
                person.setPersonName(rs.getString("PersonName"));
                fb.setPerson(person);
                
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                fb.setService(service);
                
                feedbackList.add(fb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
    
    // Lấy danh sách services cho dropdown filter
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT ServiceId, ServiceName FROM Service WHERE Status = 1";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }
}
