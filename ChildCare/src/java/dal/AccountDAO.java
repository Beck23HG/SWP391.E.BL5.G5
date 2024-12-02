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

    // Phương thức thêm người dùng mới vào database
//    public boolean addUser(Person person, Account account) {
//        Connection connection = null;
//        PreparedStatement stmPerson = null, stmAccount = null, stmRole = null;
//        boolean success = false;
//        
//        try {
//            connection = getConnection();
//            // Bắt đầu transaction
//            connection.setAutoCommit(false);
//            
//            // Bước 1: Thêm thông tin vào bảng Person
//            String sqlPerson = "INSERT INTO Person (personName, phone, email, address, image, dateOfBirth, gender) "
//                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
//            stmPerson = connection.prepareStatement(sqlPerson);
//            stmPerson.setString(1, person.getPersonName());
//            stmPerson.setString(2, person.getPhone());
//            stmPerson.setString(3, person.getEmail());
//            stmPerson.setString(4, person.getAddress());
//            stmPerson.setString(5, person.getImage());
//            stmPerson.setDate(6, new java.sql.Date(person.getDateOfBirth().getTime()));
//            stmPerson.setBoolean(7, person.isGender());
//
//            int personRowsAffected = stmPerson.executeUpdate();
//
//            if (personRowsAffected > 0) {
//                // Lấy personId vừa insert
//                String sqlGetPersonId = "SELECT LAST_INSERT_ID()"; // Cho SQL Server có thể dùng câu lệnh này
//                ResultSet rs = stmPerson.executeQuery(sqlGetPersonId);
//                int personId = 0;
//                if (rs.next()) {
//                    personId = rs.getInt(1);
//                }
//
//                // Bước 2: Kiểm tra role trong bảng Role, nếu không tồn tại thì thêm
//                int roleId = account.getRoleId();
//                String sqlRoleCheck = "SELECT roleId FROM Role WHERE roleId = ?";
//                stmRole = connection.prepareStatement(sqlRoleCheck);
//                stmRole.setInt(1, roleId);
//                ResultSet rsRole = stmRole.executeQuery();
//
//                if (!rsRole.next()) {
//                    // Nếu không có roleId trong bảng Role, thì thêm role mới
//                    String sqlInsertRole = "INSERT INTO Role (roleId, roleName) VALUES (?, ?)";
//                    PreparedStatement stmInsertRole = connection.prepareStatement(sqlInsertRole);
//                    stmInsertRole.setInt(1, roleId);
//                    stmInsertRole.setString(2, account.getRoleName());  // account.getRoleName() phải có
//                    stmInsertRole.executeUpdate();
//                }
//
//                // Bước 3: Thêm thông tin vào bảng Account
//                String sqlAccount = "INSERT INTO Account (personId, roleId, email, password, status) "
//                        + "VALUES (?, ?, ?, ?, ?)";
//                stmAccount = connection.prepareStatement(sqlAccount);
//                stmAccount.setInt(1, personId);
//                stmAccount.setInt(2, roleId); // Gán roleId cho account
//                stmAccount.setString(3, account.getEmail());
//                stmAccount.setString(4, account.getPassword());
//                stmAccount.setInt(5, account.getStatus()); // 1: Active, 0: Inactive
//
//                int accountRowsAffected = stmAccount.executeUpdate();
//
//                if (accountRowsAffected > 0) {
//                    // Commit transaction
//                    connection.commit();
//                    success = true;
//                } else {
//                    // Rollback nếu insert vào bảng Account không thành công
//                    connection.rollback();
//                }
//            } else {
//                // Rollback nếu insert vào bảng Person không thành công
//                connection.rollback();
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//            try {
//                if (connection != null) {
//                    connection.rollback();
//                }
//            } catch (SQLException ex1) {
//                ex1.printStackTrace();
//            }
//        } finally {
//            try {
//                if (stmPerson != null) stmPerson.close();
//                if (stmAccount != null) stmAccount.close();
//                if (stmRole != null) stmRole.close();
//                if (connection != null) connection.close();
//            } catch (SQLException ex) {
//                ex.printStackTrace();
//            }
//        }
//        return success;
//    }
    
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
    public int getPersonIdByMail(String email){
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
