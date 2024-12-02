/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import model.Person;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountDAO extends DBContext {

    // Phương thức thêm người dùng mới vào database
    public boolean addUser(Person person, Account account) {
        Connection connection = null;
        PreparedStatement stmPerson = null, stmAccount = null, stmRole = null;
        boolean success = false;
        
        try {
            connection = getConnection();
            // Bắt đầu transaction
            connection.setAutoCommit(false);
            
            // Bước 1: Thêm thông tin vào bảng Person
            String sqlPerson = "INSERT INTO Person (personName, phone, email, address, image, dateOfBirth, gender) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmPerson = connection.prepareStatement(sqlPerson);
            stmPerson.setString(1, person.getPersonName());
            stmPerson.setString(2, person.getPhone());
            stmPerson.setString(3, person.getEmail());
            stmPerson.setString(4, person.getAddress());
            stmPerson.setString(5, person.getImage());
            stmPerson.setDate(6, new java.sql.Date(person.getDateOfBirth().getTime()));
            stmPerson.setBoolean(7, person.isGender());

            int personRowsAffected = stmPerson.executeUpdate();

            if (personRowsAffected > 0) {
                // Lấy personId vừa insert
                String sqlGetPersonId = "SELECT LAST_INSERT_ID()"; // Cho SQL Server có thể dùng câu lệnh này
                ResultSet rs = stmPerson.executeQuery(sqlGetPersonId);
                int personId = 0;
                if (rs.next()) {
                    personId = rs.getInt(1);
                }

                // Bước 2: Kiểm tra role trong bảng Role, nếu không tồn tại thì thêm
                int roleId = account.getRoleId();
                String sqlRoleCheck = "SELECT roleId FROM Role WHERE roleId = ?";
                stmRole = connection.prepareStatement(sqlRoleCheck);
                stmRole.setInt(1, roleId);
                ResultSet rsRole = stmRole.executeQuery();

                if (!rsRole.next()) {
                    // Nếu không có roleId trong bảng Role, thì thêm role mới
                    String sqlInsertRole = "INSERT INTO Role (roleId, roleName) VALUES (?, ?)";
                    PreparedStatement stmInsertRole = connection.prepareStatement(sqlInsertRole);
                    stmInsertRole.setInt(1, roleId);
                    stmInsertRole.setString(2, account.getRoleName());  // account.getRoleName() phải có
                    stmInsertRole.executeUpdate();
                }

                // Bước 3: Thêm thông tin vào bảng Account
                String sqlAccount = "INSERT INTO Account (personId, roleId, email, password, status) "
                        + "VALUES (?, ?, ?, ?, ?)";
                stmAccount = connection.prepareStatement(sqlAccount);
                stmAccount.setInt(1, personId);
                stmAccount.setInt(2, roleId); // Gán roleId cho account
                stmAccount.setString(3, account.getEmail());
                stmAccount.setString(4, account.getPassword());
                stmAccount.setInt(5, account.getStatus()); // 1: Active, 0: Inactive

                int accountRowsAffected = stmAccount.executeUpdate();

                if (accountRowsAffected > 0) {
                    // Commit transaction
                    connection.commit();
                    success = true;
                } else {
                    // Rollback nếu insert vào bảng Account không thành công
                    connection.rollback();
                }
            } else {
                // Rollback nếu insert vào bảng Person không thành công
                connection.rollback();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex1) {
                ex1.printStackTrace();
            }
        } finally {
            try {
                if (stmPerson != null) stmPerson.close();
                if (stmAccount != null) stmAccount.close();
                if (stmRole != null) stmRole.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return success;
    }
}
