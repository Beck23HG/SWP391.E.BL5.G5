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
import model.Slider;

/**
 *
 * @author Admin
 */
public class SliderDAO extends DBContext {

    public List<Slider> getAllSliders() {
        List<Slider> sliders = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Slider";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("SliderId"));
                slider.setTitle(rs.getString("Title"));
                slider.setImage(rs.getString("Image"));
                slider.setBacklink(rs.getString("Backlink"));
                slider.setDescription(rs.getString("Description"));
                slider.setStatus(rs.getInt("Status"));
                slider.setPersonId(rs.getInt("PersonId"));
                sliders.add(slider);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sliders;
    }

    public List<Slider> getAllSlidersActive() {
        List<Slider> sliders = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Slider where Status = 1";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("SliderId"));
                slider.setTitle(rs.getString("Title"));
                slider.setImage(rs.getString("Image"));
                slider.setBacklink(rs.getString("Backlink"));
                slider.setDescription(rs.getString("Description"));
                slider.setStatus(rs.getInt("Status"));
                slider.setPersonId(rs.getInt("PersonId"));
                sliders.add(slider);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sliders;
    }
    
    public List<Slider> searchSliders(String title, String status) {
        List<Slider> sliders = new ArrayList<>();
        try {
            String sql = """
                         select * from Slider
                         where Title like '%""" + title + "%' and Status like '%" + status + "%'";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("SliderId"));
                slider.setTitle(rs.getString("Title"));
                slider.setImage(rs.getString("Image"));
                slider.setBacklink(rs.getString("Backlink"));
                slider.setDescription(rs.getString("Description"));
                slider.setStatus(rs.getInt("Status"));
                slider.setPersonId(rs.getInt("PersonId"));
                sliders.add(slider);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sliders;
    }

    public void createSlider(String title, String image, String backlink,
            String description, String status, int personId) {
        String sql = """
                        INSERT INTO [Slider] ([Title] ,[Image] ,[Backlink] ,[Description] ,[Status] ,[PersonId])
                                 VALUES (? ,? ,? ,? ,? ,?)""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, image);
            ps.setString(3, backlink);
            ps.setString(4, description);
            ps.setString(5, status);
            ps.setInt(6, personId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để kiểm tra nguyên nhân
        }
    }

    public Slider getSliderById(int sliderId) {
        try {
            String sql = "SELECT * FROM Slider where SliderId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, sliderId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("SliderId"));
                slider.setTitle(rs.getString("Title"));
                slider.setImage(rs.getString("Image"));
                slider.setBacklink(rs.getString("Backlink"));
                slider.setDescription(rs.getString("Description"));
                slider.setStatus(rs.getInt("Status"));
                slider.setPersonId(rs.getInt("PersonId"));
                return slider;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateSlider(String title, String image, String backlink, String description, String status, int sliderId) {
        try {
            String sql = """
                         UPDATE [Slider]
                         SET [Title] = ? ,[Image] = ? ,[Backlink] = ? ,[Description] = ? ,[Status] = ?
                         WHERE SliderId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, title);
            stm.setString(2, image);
            stm.setString(3, backlink);
            stm.setString(4, description);
            stm.setString(5, status);
            stm.setInt(6, sliderId);
            stm.executeUpdate();
        } catch (SQLException ex) {

        }
    }
//    public static void main(String[] args) {
//        SliderDAO s = new SliderDAO();
//        s.updateSlider("", image, backlink, description, status);
//    }
}
