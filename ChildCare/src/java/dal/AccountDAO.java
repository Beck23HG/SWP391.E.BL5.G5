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
import java.util.logging.Level;
import java.util.logging.Logger;

public class AccountDAO extends DBContext {

    public void createNewPerson(String email, String password, int roleID,
            int status, String personName, java.util.Date DOB, boolean gender, String phone) {

        String sqlPerson = """
                            INSERT INTO Person (PersonName, DateOfBirth, Gender, Phone, Email)
                            VALUES (?, ?, ?, ?, ?)""";

        String sqlAccount = """
                            INSERT INTO Account (Email, Password, RoleId, PersonId, Status)
                            VALUES (?, ?, ?, ?, ?)""";

        try {
            // Insert thông tin vào bảng Person
            PreparedStatement psPerson = connection.prepareStatement(sqlPerson);
            psPerson.setString(1, personName);
            psPerson.setDate(2, new java.sql.Date(DOB.getTime())); // Chuyển từ java.util.Date sang java.sql.Date
            psPerson.setBoolean(3, gender);
            psPerson.setString(4, phone);
            psPerson.setString(5, email);
            psPerson.executeUpdate();

            // Lấy PersonId vừa chèn vào
            int personId = getPersonIdByMail(email);

            // Insert thông tin vào bảng Account
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
}
