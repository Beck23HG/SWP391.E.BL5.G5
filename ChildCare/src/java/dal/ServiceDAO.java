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
import model.Service;

/**
 *
 * @author Admin
 */
public class ServiceDAO extends DBContext {

    public List<Service> getAllServicesActive() {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Service where Status = 1";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    public List<Service> getThreeServicesActive() {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT top 3 * FROM Service where Status = 1";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    public List<Service> getServicesByName(String name, int index) {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Service where ServiceName like '%" + name + "%' and Status = 1 "
                    + "order by ServiceId OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (index - 1) * 3);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    public int getTotalServiceWithName(String name) {
        try {
            String sql = "SELECT count(*) FROM Service "
                    + "where ServiceName like '%" + name + "%' and Status = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public List<Service> getServicesByPrice(int p1, int p2, int index) {
        List<Service> services = new ArrayList<>();
        try {
            String sql = """
                         SELECT * FROM Service where Price between ? and ? and Status = 1
                         order by ServiceId OFFSET ? ROWS FETCH NEXT 2 ROWS ONLY""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, p1);
            statement.setInt(2, p2);
            statement.setInt(3, (index - 1) * 2);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    public int getTotalServiceWithPrice(int p1, int p2) {
        try {
            String sql = "SELECT count(*) FROM Service where Price between ? and ? and Status = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public List<Service> getServices(int index) {
        List<Service> services = new ArrayList<>();
        try {
            String sql = """
                         SELECT * FROM Service where Status = 1
                         order by ServiceId OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (index - 1) * 3);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    public int getTotalService() {
        try {
            String sql = "SELECT count(*) FROM Service where Status = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public static void main(String[] args) {
        ServiceDAO serviceDAO = new ServiceDAO();
        int totalService = serviceDAO.getTotalServiceWithName("a");
        System.out.println(totalService);
        int endPage = totalService / 3;
        if (totalService % 3 != 0) {
            endPage++;
        }
        System.out.println(endPage);
        String indexP = "1";
        if (indexP == null) {
            indexP = "1";
        }
        int index = Integer.parseInt(indexP);
        List<Service> services = serviceDAO.getServices(index);
    }
}
