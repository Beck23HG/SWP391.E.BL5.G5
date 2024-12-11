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

    // Hàm lấy thông tin chi tiết của một người dùng dựa trên personId
    public Person getPersonDetailsById(int personId) {
        String sql = "SELECT p.personId, p.personName, p.dateOfBirth, p.gender, p.email, p.phone, "
                + "p.address, p.image, a.roleId, a.status, r.roleName "
                + "FROM Person p "
                + "JOIN Account a ON p.personId = a.personId "
                + "JOIN Role r ON a.roleId = r.roleId "
                + "WHERE p.personId = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, personId);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    Person person = new Person();
                    person.setPersonId(rs.getInt("personId"));
                    person.setPersonName(rs.getString("personName"));
                    person.setDateOfBirth(rs.getDate("dateOfBirth"));
                    person.setGender(rs.getBoolean("gender"));
                    person.setEmail(rs.getString("email"));
                    person.setPhone(rs.getString("phone"));
                    person.setAddress(rs.getString("address"));
                    person.setImage(rs.getString("image"));

                    Account account = new Account();
                    account.setRoleId(rs.getInt("roleId"));
                    account.setStatus(rs.getInt("status"));

                    Role role = new Role();
                    role.setRoleName(rs.getString("roleName"));

                    person.setAccount(account);
                    person.setRole(role);

                    return person;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    // Hàm cập nhật RoleId và Status của người dùng
    public boolean updateUserRoleAndStatus(int personId, int roleId, int status) {
        String sql = "UPDATE Account SET roleId = ?, status = ? WHERE personId = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, roleId);
            stm.setInt(2, status);
            stm.setInt(3, personId);
            return stm.executeUpdate() > 0; // Trả về true nếu update thành công
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<Person> getCustomers(int page, Integer status, String search) {
        List<Person> customers = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT p.personId, p.personName, p.gender, p.email, p.phone, a.status "
                    + "FROM Person p "
                    + "JOIN Account a ON p.personId = a.personId "
                    + "WHERE a.roleId = 1 "; // Chỉ lấy customer với roleId = 1

            // Thêm điều kiện lọc trạng thái (status)
            if (status != null) {
                sql += "AND a.status = ? ";
            }
            // Thêm điều kiện tìm kiếm theo tên, email, hoặc số điện thoại
            if (search != null && !search.isEmpty()) {
                sql += "AND (p.personName LIKE ? OR p.email LIKE ? OR p.phone LIKE ?) ";
            }

            sql += "ORDER BY p.personId "
                    + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY"; // Phân trang, 5 người mỗi trang

            stm = connection.prepareStatement(sql);
            int index = 1;

            // Gán giá trị cho tham số lọc
            if (status != null) {
                stm.setInt(index++, status);
            }
            if (search != null && !search.isEmpty()) {
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
                stm.setString(index++, "%" + search + "%");
            }
            stm.setInt(index++, (page - 1) * 5); // Gán giá trị cho OFFSET

            rs = stm.executeQuery();

            while (rs.next()) {
                Person customer = new Person();
                customer.setPersonId(rs.getInt("personId"));
                customer.setPersonName(rs.getString("personName"));
                customer.setGender(rs.getBoolean("gender"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));

                Account account = new Account();
                account.setStatus(rs.getInt("status"));
                customer.setAccount(account);

                customers.add(customer);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return customers;
    }

    public int getTotalCustomers(Integer status, String search) {
        int total = 0;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM Person p "
                    + "JOIN Account a ON p.personId = a.personId "
                    + "WHERE a.roleId = 1 "; // Chỉ đếm customer với roleId = 1

            // Thêm điều kiện lọc trạng thái (status)
            if (status != null) {
                sql += "AND a.status = ? ";
            }
            // Thêm điều kiện tìm kiếm theo tên, email, hoặc số điện thoại
            if (search != null && !search.isEmpty()) {
                sql += "AND (p.personName LIKE ? OR p.email LIKE ? OR p.phone LIKE ?) ";
            }

            stm = connection.prepareStatement(sql);
            int index = 1;

            // Gán giá trị cho tham số lọc
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
                total = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return total;
    }

    public boolean toggleCustomerStatus(int personId) {
        PreparedStatement stm = null;
        try {
            // Câu query để đổi trạng thái
            String sql = "UPDATE Account "
                    + "SET status = CASE WHEN status = 1 THEN 0 ELSE 1 END "
                    + "WHERE personId = ? AND roleId = 1";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, personId);
            int updatedRows = stm.executeUpdate();
            return updatedRows > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

}
