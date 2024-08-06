package dal;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.subject.Status;
import model.subject.Subject;

public class SubjectDAO extends DBContext implements Serializable {

    public int getNumberOfSubjects() {
        String sql = "select count(*) as count from subject;";
        int count = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return count;
    }

    public Subject getSubjectMatchId(int id) {
        String sql = "select * from subject where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Subject s = new Subject(rs.getInt("id"), rs.getString("code"),
                        rs.getString("name"), Status.getStringFromInt(rs.getInt("status")));
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<Subject> getAllSubject() {
        ArrayList<Subject> list = new ArrayList<>();
        String sql = "select * from subject;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject s = new Subject(rs.getInt("id"), rs.getString("code"),
                        rs.getString("name"), Status.getStringFromInt(rs.getInt("status")));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void addNewSubject(Subject subject) throws SQLException {
        String sql = "insert into subject(code, name) values(?,?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, subject.getCode());
        st.setString(2, subject.getName());
        st.execute();
    }

    public void updateSubject(Subject s) throws SQLException {
        String sql = "update subject set code = ?, name = ? where id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, s.getCode());
        st.setString(2, s.getName());
        st.setInt(3, s.getId());
        st.execute();
    }

    public void activateOrDeactivateSubject(int id, String status) throws SQLException {
        String sql = "update subject set status = ? where id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        int stat;
        stat = status.equals("Active") ? 0 : 1;
        st.setInt(1, stat);
        st.setInt(2, id);
        st.execute();
    }

    public ArrayList<Subject> getAllSubjectNotAssigned(int classId) {
        String sql = "with tb1 as"
                + "(select id from subject except select subject_id from `group` where class_id = ?)"
                + "select id from tb1;";
        ArrayList<Subject> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, classId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(getSubjectMatchId(rs.getInt("id")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        for (Subject s : list) {
            System.out.println(s.getCode());
        }
        return list;
    }

}
