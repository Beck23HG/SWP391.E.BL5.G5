/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import model.Person;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AccountDAO extends DBContext {

    public Account getAccountByEmailAndPassword(String email, String password) {
        try {
            String sql = "select * from Account a join Person p on a.PersonId = p.PersonId"
                    + " WHERE a.Email = ? AND Password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setAccountId(rs.getInt("AccountId"));
                acc.setEmail(rs.getString("Email"));
                acc.setPassword(rs.getString("Password"));
                acc.setRoleId(rs.getInt("RoleId"));
                acc.setPersonId(rs.getInt("PersonId"));
                acc.setStatus(rs.getInt("Status"));

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

                acc.setPerson(person);
                return acc;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void createAccount(String email, String password, int roleID,
            int status, String personName, java.util.Date DOB, boolean gender, String phone) {
        String sqlAccount = """
                            INSERT INTO [Account] ([Email] ,[Password] ,[RoleId] ,[PersonId] ,[Status])
                                 VALUES (? ,? ,? ,? ,?)""";

        String sqlPerson = """
                           INSERT INTO [Person] ([PersonName] ,[DateOfBirth] ,[Gender] ,[Phone] ,[Email])
                           VALUES (? ,? ,? ,? ,?)""";
        try {
            PreparedStatement psPerson = connection.prepareStatement(sqlPerson);
            psPerson.setString(1, personName);
            psPerson.setDate(2, new java.sql.Date(DOB.getTime()));
            psPerson.setBoolean(3, gender);
            psPerson.setString(4, phone);
            psPerson.setString(5, email);
            psPerson.executeUpdate();

            int personId = getPersonIdByMail(email);

            PreparedStatement psAcc = connection.prepareStatement(sqlAccount);
            psAcc.setString(1, email);
            psAcc.setString(2, password);
            psAcc.setInt(3, roleID);
            psAcc.setInt(4, personId);
            psAcc.setInt(5, status);
            psAcc.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để kiểm tra nguyên nhân
        }
    }

    public int getPersonIdByMail(String email) {
        try {
            String sql = """
                         SELECT PersonId FROM Person
                         WHERE email = ?""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("PersonId");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public boolean checkExistedEmail(String email) {
        String sql = "SELECT * FROM Account WHERE Email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {

        }
        return false;
    }

    
    public boolean checkExistedPhone(String phone) {
        String sql = """
                     SELECT * FROM Account a join Person p on a.PersonId = p.PersonId
                     where Phone = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            
        }
        return false;
    }
    
    public void updatePassword(String password, int id) {
        try {
            String sql = """
                         UPDATE [Account]
                            SET [Password] = ?
                          WHERE AccountId = ?""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, password);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void resetPassword(String password, String email) {
        try {
            String sql = """
                         UPDATE [Account]
                            SET [Password] = ?
                          WHERE Email = ?""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, password);
            statement.setString(2, email);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void updateImage(String image, int id) {
        try {
            String sql = """
                         UPDATE [Person]
                            SET [Image] = ?
                          WHERE PersonId = ?""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, image);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updateProfile(String fullname, String phone, boolean gender, java.util.Date DOB, String address, int id) {
        try {
            String sql = """
                         UPDATE [Person]
                         SET [PersonName] = ?
                               ,[DateOfBirth] = ?
                               ,[Gender] = ?
                               ,[Phone] = ?
                               ,[Address] = ?
                          WHERE PersonId = ?""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fullname);
            statement.setDate(2, new java.sql.Date(DOB.getTime()));
            statement.setBoolean(3, gender);
            statement.setString(4, phone);
            statement.setString(5, address);
            statement.setInt(6, id);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void createAccountStaff(String email, String password, int roleID,
            int status, String personName, java.util.Date DOB,
            boolean gender, String phone, String address, String image) {
        String sqlPerson = """
                       INSERT INTO [Person] ([PersonName], [DateOfBirth], [Gender], 
                                             [Phone], [Email], [Address], [Image])
                       VALUES (?, ?, ?, ?, ?, ?, ?);
                       """;

        String sqlAccount = """
                       INSERT INTO [Account] ([Email], [Password], [RoleId], [PersonId], [Status])
                       VALUES (?, ?, ?, ?, ?);
                       """;

        try {
            // Chèn thông tin vào bảng Person
            PreparedStatement psPerson = connection.prepareStatement(sqlPerson);
            psPerson.setString(1, personName);
            psPerson.setDate(2, new java.sql.Date(DOB.getTime()));
            psPerson.setBoolean(3, gender);
            psPerson.setString(4, phone);
            psPerson.setString(5, email);
            psPerson.setString(6, address);
            psPerson.setString(7, image);
            psPerson.executeUpdate();

            // Lấy PersonId vừa thêm vào
            int personId = getPersonIdByMail(email);

            // Chèn thông tin vào bảng Account
            PreparedStatement psAcc = connection.prepareStatement(sqlAccount);
            psAcc.setString(1, email);
            psAcc.setString(2, password);
            psAcc.setInt(3, roleID);
            psAcc.setInt(4, personId);
            psAcc.setInt(5, status);
            psAcc.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để kiểm tra nguyên nhân
        }
    }
}
