package dal;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.classes.Classes;

public class ClassDAO extends DBContext implements Serializable {

    public ArrayList<Classes> getAllClasses() {
        String sql = "select * from class;";
        ArrayList<Classes> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Classes c = new Classes(rs.getInt("id"), rs.getString("code"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void addNewClass(String code) throws SQLException {
        String sql = "insert into class(code) values(?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, code);
        st.execute();
    }

    public Classes getClassMatchId(int id) {
        String sql = "select * from class where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Classes c = new Classes(rs.getInt("id"), rs.getString("code"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void updateClass(Classes c) throws SQLException {
        String sql = "update class set code = ? where id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, c.getCode());
        st.setInt(2, c.getId());
        st.execute();
    }

    public int getNumberOfClasses() {
        String sql = "select count(*) as number from class";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("number");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

}
