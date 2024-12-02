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
import model.Account;
import model.Person;
import model.Role;

/**
 *
 * @author admin
 */
public class PersonDAO extends DBContext {

    public List<Person> getAllPersons(int page, Integer gender, Integer role, Integer status, String search) {
        List<Person> persons = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM Person p "
                    + "JOIN Account a ON p.personId = a.personId "
                    + "JOIN Role r ON a.roleId = r.roleId "
                    + "WHERE 1 = 1 ";

            // Thêm các điều kiện cho các tham số lọc
            if (gender != null) {
                sql += "AND p.gender = ? ";
            }
            if (role != null) {
                sql += "AND r.roleId = ? ";
            }
            if (status != null) {
                sql += "AND a.status = ? ";
            }
            if (search != null && !search.isEmpty()) {
                sql += "AND (p.personName LIKE ? OR p.email LIKE ? OR p.phone LIKE ?) ";
            }

            sql += "ORDER BY p.personId "
                    + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

            stm = connection.prepareStatement(sql);

            int index = 1;
            if (gender != null) {
                stm.setInt(index++, gender);
            }
            if (role != null) {
                stm.setInt(index++, role);
            }
            if (status != null) {
                stm.setInt(index++, status);
            }
            if (search != null && !search.isEmpty()) {
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
            }

            // Set tham số cho phân trang (OFFSET)
            stm.setInt(index++, (page - 1) * 10);

            rs = stm.executeQuery();
            while (rs.next()) {
                Person person = new Person();
                person.setPersonId(rs.getInt("personId"));
                person.setPersonName(rs.getString("personName"));
                person.setGender(rs.getBoolean("gender"));
                person.setEmail(rs.getString("email"));
                person.setPhone(rs.getString("phone"));

                // Create and set the role object
                Role roleObj = new Role();
                roleObj.setRoleName(rs.getString("roleName"));
                person.setRole(roleObj);

                // Create and set the account object
                Account account = new Account();
                account.setStatus(rs.getInt("status"));
                person.setAccount(account);

                persons.add(person);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return persons;
    }

    public int getTotalCount(Integer gender, Integer role, Integer status, String search) {
        int totalCount = 0;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM Person p "
                    + "JOIN Account a ON p.personId = a.personId "
                    + "JOIN Role r ON a.roleId = r.roleId "
                    + "WHERE 1 = 1 ";

            if (gender != null) {
                sql += "AND p.gender = ? ";
            }
            if (role != null) {
                sql += "AND r.roleId = ? ";
            }
            if (status != null) {
                sql += "AND a.status = ? ";
            }
            if (search != null && !search.isEmpty()) {
                sql += "AND (p.personName LIKE ? OR p.email LIKE ? OR p.phone LIKE ?) ";
            }

            stm = connection.prepareStatement(sql);

            int index = 1;
            if (gender != null) {
                stm.setInt(index++, gender);
            }
            if (role != null) {
                stm.setInt(index++, role);
            }
            if (status != null) {
                stm.setInt(index++, status);
            }
            if (search != null && !search.isEmpty()) {
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
            }

            rs = stm.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return totalCount;
    }

    public static void main(String[] args) {
        PersonDAO dao = new PersonDAO();

        List<Person> persons = dao.getAllPersons(1, null, null, null, "");

        if (persons != null && !persons.isEmpty()) {
            System.out.println("Found " + persons.size() + " persons:");
            for (Person person : persons) {
                System.out.println(person.getPersonId() + ": " + person.getPersonName() + ", " + person.getEmail());
            }
        } else {
            System.out.println("No persons found.");
        }
    }
}
