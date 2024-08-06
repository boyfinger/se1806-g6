package dal;

import controller.encrypt.BCrypt;
import model.User;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.subject.Subject;
import model.Role;

public class UserDAO extends DBContext implements Serializable {

    public void userSignUp(User user, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = connection;

            // SQL query to insert a new user, including the status column
            String query = "INSERT INTO `user` (name, email, avt, password, role, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            // Create a prepared statement with auto-generated keys
            ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getAvatar());
            String hashedpw = BCrypt.hashpw(password, BCrypt.gensalt(12));
            ps.setString(4, hashedpw);
            ps.setInt(5, user.getRole());
            ps.setInt(6, user.getStatus());

            // Execute the query
            int affectedRows = ps.executeUpdate();

            // Check if any rows were affected (user inserted successfully)
            if (affectedRows == 0) {
                throw new SQLException("User sign-up failed, no rows affected.");
            }

            // Retrieve the auto-generated key (id)
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                user.setId(rs.getInt(1)); // Set the generated id back to the User object
            }
        } finally {
            // Close the ResultSet, PreparedStatement, and Connection
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public User login(String email, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user;

        try {
            conn = connection;

            String query = "SELECT * FROM `user` WHERE email = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, email);

            rs = ps.executeQuery();
            user = new User();

            if (rs.next() && checkEmailExist(email)) {
                if ((BCrypt.checkpw(password, rs.getString("password")))) {
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setAvatar(rs.getString("avt"));
                    int role = rs.getInt("role");
                    user.setRole(role);
                    user.setR(getRole(role));
                    user.setStatus(rs.getInt("status")); // Set status from DB
                }
            } else if (!checkEmailExist(email)) {
                user = null;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return user;
    }

    public User loginGoogle(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = connection;

            String query = "SELECT * FROM `user` WHERE email = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, email);

            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setAvatar(rs.getString("avt"));
                user.setRole(rs.getInt("role"));
                user.setStatus(rs.getInt("status")); // Set status from DB
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return user;
    }
//
//    public void updateUserAvatar(int userId, String avatar) throws SQLException {
//        Connection conn = null;
//        PreparedStatement ps = null;
//
//        try {
//            conn = connection;
//            String query = "UPDATE `user` SET avt = ? WHERE id = ?";
//            ps = conn.prepareStatement(query);
//            ps.setString(1, avatar);
//            ps.setInt(2, userId);
//            ps.executeUpdate();
//        } finally {
//            if (ps != null) {
//                ps.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//    }

    private Role getRole(int id) {
        String sql = "select * from role where id = ?;";
        Role r;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                r = new Role();
                r.setId(id);
                r.setName(rs.getString("name"));
                return r;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private User getUserInfo(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setAvatar(rs.getString("avt"));
        u.setStatus(rs.getInt("status"));
        int roleId = rs.getInt("role");
        u.setRole(roleId);
        u.setR(getRole(roleId));
        u.setDateCreated(rs.getDate("date_created"));
        return u;
    }

    public ArrayList<User> getAllUsers() {
        String sql = "select * from user where role > 0;";
        ArrayList<User> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User u = getUserInfo(rs);
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public int getNumberOfStudents() {
        String sql = "SELECT COUNT(*) AS number FROM `user` WHERE role = 3";
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("number");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return count;
    }

    public int getNumberOfTeachers() {
        String sql = "SELECT COUNT(*) AS number FROM `user` WHERE role = 2";
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("number");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return count;
    }

    public ArrayList<User> getAllAccount() {
        ArrayList<User> list = new ArrayList<>();

        String query = "SELECT * FROM user;";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User s = new User();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setRole(rs.getInt("role"));
                s.setAvatar(rs.getString("avt"));
                s.setStatus(rs.getInt("status"));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public User getUserByID(int Id) {

        User user = new User();
        String query = "select * from user where Id= ?";

        try {
            PreparedStatement ps;
            ResultSet rs;
            if (connection != null) {
                ps = connection.prepareStatement(query);
                ps.setInt(1, Id);
                rs = ps.executeQuery();
                while (rs.next()) {
                    user.setId(rs.getInt(1));
                    user.setName(rs.getString(2));
                    user.setEmail(rs.getString(3));
                    int role = rs.getInt(5);
                    user.setRole(role);
                    user.setAvatar(rs.getString(6));
                    user.setR(getRole(role));
                }
            }
        } catch (SQLException ignored) {
        }
        return user;
    }

    public void updatePassword(String email, String currentPassword, String newPassword) throws SQLException {
        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;
        User user;

        try {
            // Assuming `connection` is a valid Connection object
            conn = connection;

            // Step 1: Verify the user's current password
            String selectQuery = "SELECT * FROM `user` WHERE email = ?";
            psSelect = conn.prepareStatement(selectQuery);
            psSelect.setString(1, email);

            rs = psSelect.executeQuery();
            if (rs.next()) {
                if (BCrypt.checkpw(currentPassword, rs.getString("password"))) {
                    // Step 2: Update the user's password
                    String updateQuery = "UPDATE `user` SET password = ? WHERE email = ?";
                    psUpdate = conn.prepareStatement(updateQuery);
                    newPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
                    psUpdate.setString(1, newPassword);
                    psUpdate.setString(2, email);
                    psUpdate.executeUpdate();

                    // Step 3: Retrieve the updated user
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setAvatar(rs.getString("avt"));
                    user.setRole(rs.getInt("role"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            // Close ResultSet
            if (rs != null) {
                rs.close();
            }
            // Close PreparedStatements
            if (psSelect != null) {
                psSelect.close();
            }
            if (psUpdate != null) {
                psUpdate.close();
            }
            // Close Connection
            if (conn != null) {
                conn.close();
            }
        }

    }

    public void resetPassword(String email, String newpassword) {
        String query = "UPDATE user SET password = ? WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            newpassword = BCrypt.hashpw(newpassword, BCrypt.gensalt(12));
            ps.setString(1, newpassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public Boolean checkEmailExist(String email) {
        String query = "SELECT * FROM user WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return false;
    }

    public String getPasswordByEmail(String email) {
        String query = "SELECT password FROM user WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("password");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private int getStatusById(int id) {
        String sql = "select status from `user` where id = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("status");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return -1;
    }

    public void changeUserStatus(int id) throws SQLException {
        int newStatus;
        if (getStatusById(id) == 1) {
            newStatus = 0;
        } else {
            newStatus = 1;
        }
        String sql = "update `user` set status = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, newStatus);
        st.setInt(2, id);
        st.execute();
    }

    public ArrayList<Role> getAllRoles() {
        ArrayList<Role> list = new ArrayList<>();
        String sql = "select * from `role`;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));
                list.add(role);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public User getUserById(int id) {
        String sql = "select * from user where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return getUserInfo(rs);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void updateUser(User u) throws SQLException {
        String sql = "update user set role = ?, name = ? where id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, u.getRole());
        st.setString(2, u.getName());
        st.setInt(3, u.getId());
        st.execute();
    }

    public void updateAvatar(User u) throws SQLException {
        String sql = "update user set avt = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, u.getAvatar());
        st.setInt(2, u.getId());
        st.execute();
    }

    public boolean isAvtExist(String uri) {
        String sql = "select * from user where avt = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, uri);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public void addUser(User user, String password) throws SQLException {
        String sql = "INSERT INTO `user` (name, email, avt, password, role, status)"
                + "VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, user.getName());
        st.setString(2, user.getEmail());
        st.setString(3, user.getAvatar());
        String hashedpw = BCrypt.hashpw(password, BCrypt.gensalt(12));
        st.setString(4, hashedpw);
        st.setInt(5, user.getRole());
        st.setInt(6, user.getStatus());
        st.execute();
    }

    public void setNewPassword(int userId, String newPassword) throws SQLException {
        String sql = "update user set password = ?, status = 1 where id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        String hashedpw = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
        st.setString(1, hashedpw);
        st.setInt(2, userId);
        st.execute();
    }

    public ArrayList<Subject> getAllSubjectsInCharged(int id) {
        SubjectDAO subjectDAO = new SubjectDAO();
        String sql = "select * from subject_in_charged where user_id = ?;";
        ArrayList<Subject> ret = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ret.add(subjectDAO.getSubjectMatchId(rs.getInt("subject_id")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return ret;
    }

    public void assignSubject(int userId, int subjectId) throws SQLException {
        String sql = "insert into subject_in_charged (user_id, subject_id) values (?,?);";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        st.setInt(2, subjectId);
        st.execute();
    }

    public void removeAssignedSubject(int userId, int subjectId) throws SQLException {
        String sql = "delete from subject_in_charged where user_id = ? and subject_id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        st.setInt(2, subjectId);
        st.execute();
    }

    public User getUserByEmail(String email) {
        String sql = "select * from user where email = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return getUserInfo(rs);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public boolean isEmailUnverified(String email) {
        return getUserByEmail(email).getStatus() == 2;
    }

}
