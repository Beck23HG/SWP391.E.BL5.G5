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
}
