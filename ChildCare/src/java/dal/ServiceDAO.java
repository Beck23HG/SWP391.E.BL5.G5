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
import model.Person;
import model.Service;

/**
 *
 * @author Admin
 */
public class ServiceDAO extends DBContext {

    public List<Service> getAllServices(String name, String personName, String status, int index) {
        List<Service> services = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Service s join Person p on s.ManagerId = p.PersonId "
                    + "where 1=1 ";
            if (name != null && !name.isEmpty()) {
                sql += "AND ServiceName like '%" + name + "%' ";
            }
            if (personName != null) {
                sql += "AND PersonName like '%" + personName + "%' ";
            }
            if (status != null) {
                sql += "AND Status like '%" + status + "%' ";
            }

            sql += "ORDER BY s.ServiceId OFFSET ? ROWS FETCH NEXT 4 ROWS ONLY";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (index - 1) * 4);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));

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

                service.setPerson(person);
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return services;
    }

    public int getNumberOfService(String name, String personName, String status) {
        try {
            String sql = "SELECT count(*) FROM Service s join Person p on s.ManagerId = p.PersonId "
                    + "where 1=1 ";
            if (name != null && !name.isEmpty()) {
                sql += "AND ServiceName like '%" + name + "%' ";
            }
            if (personName != null) {
                sql += "AND PersonName like '%" + personName + "%' ";
            }
            if (status != null) {
                sql += "AND Status like '%" + status + "%' ";
            }
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<String> getAllManagerCreateService() {
        List<String> names = new ArrayList<>();
        try {
            String sql = """
                         SELECT PersonName FROM Service s 
                         join Person p on s.ManagerId = p.PersonId 
                         group by PersonName""";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                names.add(rs.getString("PersonName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return names;
    }

    public List<Person> getAllStaffActive() {
        List<Person> staffs = new ArrayList<>();
        try {
            String sql = """
                         select p.PersonId, p.PersonName from Person p 
                         join Account a on p.PersonId = a.PersonId
                         where a.RoleId = 2 and a.Status = 1""";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Person person = new Person();
                person.setPersonId(rs.getInt("PersonId"));
                person.setPersonName(rs.getString("PersonName"));
                staffs.add(person);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return staffs;
    }

    public void assignStaffForService(int pid, int sid) {
        String sql = """
                     INSERT INTO [dbo].[Persons_Services]
                                ([PersonId]
                                ,[ServiceId])
                          VALUES (? ,?)""";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            stm.setInt(2, sid);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để kiểm tra nguyên nhân
        }
    }
    
    public void removeAllStaffFromService(int sid){
        String sql = """
                     DELETE FROM [dbo].[Persons_Services]
                           WHERE ServiceId = ?""";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sid);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để kiểm tra nguyên nhân
        }
    }

    public Service getLastestService() {
        try {
            String sql = """
                         SELECT * FROM Service
                         WHERE ServiceId = (SELECT MAX(ServiceId) FROM Service);""";
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
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                return service;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

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
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                         order by ServiceId OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, p1);
            statement.setInt(2, p2);
            statement.setInt(3, (index - 1) * 3);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                services.add(service);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public Service getServiceByID(int id) {
        try {
            String sql = "select * from Service where ServiceId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                service.setPrice(rs.getFloat("Price"));
                service.setDescription(rs.getString("Description"));
                service.setStatus(rs.getInt("Status"));
                service.setImage(rs.getString("Image"));
                service.setDuration(rs.getString("Duration"));
                service.setDetail(rs.getString("Detail"));
                service.setManagerId(rs.getInt("ManagerId"));
                return service;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Person> getStaffByServiceID(int id) {
        List<Person> persons = new ArrayList<>();
        try {
            String sql = """
                         select * from Service s 
                         join Persons_Services ps on s.ServiceId = ps.ServiceId 
                         join Person p on ps.PersonId = p.PersonId
                         where ps.ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
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
                persons.add(person);
            }
        } catch (SQLException e) {
        }
        return persons;
    }

    public List<Integer> getTotalStarRatingByServiceId(int id) {
        List<Integer> ratings = new ArrayList<>();
        try {
            String sql = """
                         select StarRating from Service s 
                         join Feedback f on s.ServiceId = f.ServiceId 
                         where s.ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ratings.add(rs.getInt("StarRating"));
            }
        } catch (SQLException e) {
        }
        return ratings;
    }

    public int getNumberRatingByServiceId(int id) {
        try {
            String sql = """
                         select count(*) from Service s 
                         join Feedback f on s.ServiceId = f.ServiceId 
                         where s.ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return (rs.getInt(1));
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public void createService(String name, float price, String description,
            String status, String image, String duration, String detail, int id) {
        String sql = """
                     INSERT INTO [dbo].[Service]
                                ([ServiceName]
                                ,[Price]
                                ,[Description]
                                ,[Status]
                                ,[Image]
                                ,[Duration]
                                ,[Detail]
                                ,[ManagerId]) 
                     VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)""";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setFloat(2, price);
            stm.setString(3, description);
            stm.setString(4, status);
            stm.setString(5, image);
            stm.setString(6, duration);
            stm.setString(7, detail);
            stm.setInt(8, id);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để kiểm tra nguyên nhân
        }
    }

    public void updateService(String name, float price, String description,
            String status, String duration, String detail, int id) {
        try {
            String sql = """
                         UPDATE [dbo].[Service]
                             SET [ServiceName] = ?
                                ,[Price] = ?
                                ,[Description] = ?
                                ,[Status] = ?
                                ,[Duration] = ?
                                ,[Detail] = ? 
                           WHERE ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setFloat(2, price);
            stm.setString(3, description);
            stm.setString(4, status);
            stm.setString(5, duration);
            stm.setString(6, detail);
            stm.setInt(7, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateServiceImage(String image, int id) {
        try {
            String sql = """
                         UPDATE [dbo].[Service]
                              SET [Image] = ?
                            WHERE ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, image);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteService(int id) {
        try {
            String sql = """
                         DELETE FROM [dbo].[Service]
                                  WHERE ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deletePersons_Services(int id) {
        try {
            String sql = """
                         DELETE FROM [dbo].[Persons_Services]
                                  WHERE ServiceId = ?""";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        ServiceDAO serviceDAO = new ServiceDAO();
    }
}
