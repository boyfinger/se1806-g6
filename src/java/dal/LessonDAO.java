package dal;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Lesson;

public class LessonDAO extends DBContext implements Serializable {

    SubjectDAO subjectDAO = new SubjectDAO();

    private Lesson getLessonInfo(ResultSet rs) throws SQLException {
        Lesson l = new Lesson();
        l.setId(rs.getInt("id"));
        l.setName(rs.getString("name"));
        int subjectId = rs.getInt("subject_id");
        l.setSubjectId(rs.getInt("subject_id"));
        l.setSubject(subjectDAO.getSubjectMatchId(subjectId));
        l.setStatus(rs.getBoolean("status"));
        l.setOrder(rs.getInt("order"));
        return l;
    }

    public ArrayList<Lesson> getAllLessons() {
        String sql = "select * from lesson;";
        ArrayList<Lesson> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Lesson l = getLessonInfo(rs);
                list.add(l);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Lesson getLessonMatchId(int lessonId) {
        String sql = "select * from lesson where id = ?;";
        Lesson l = null;

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lessonId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                l = getLessonInfo(rs);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return l;
    }

    public int getLatestOrder(int subjectId) {
        ArrayList<Lesson> list = getAllLessonsOfASubject(subjectId);
        int max = 0;
        for (Lesson lesson : list) {
            int order = lesson.getOrder();
            if (order > max) {
                max = order;
            }
        }
        return max;
    }

    public void addLesson(String name, int subjectId) throws SQLException {
        String sql = "insert into lesson(name, subject_id, `order`) values (?,?,?);";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, name);
        st.setInt(2, subjectId);
        st.setInt(3, getLatestOrder(subjectId) + 1);
        st.execute();
    }

    public void updateLesson(Lesson lesson) throws SQLException {

        String sql = "update lesson set name = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, lesson.getName());
        st.setInt(2, lesson.getId());
        st.execute();

    }

    public void changeStatus(int lessonId) throws SQLException {
        boolean newStatus = !getLessonMatchId(lessonId).isStatus();
        String sql = "update lesson set status = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setBoolean(1, newStatus);
        st.setInt(2, lessonId);
        st.execute();
    }

    private Lesson getLessonByOrder(int order, int subjectId) {
        String sql = "select * from lesson where `order` = ? and subject_id = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, order);
            st.setInt(2, subjectId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return getLessonInfo(rs);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private void updateOrder(int lessonId, int order) throws SQLException {
        String sql = "update lesson set `order` = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, order);
        st.setInt(2, lessonId);
        st.execute();
    }

    public void changeOrder(int lessonId, String action) throws SQLException {
        Lesson lesson = getLessonMatchId(lessonId);
        int thisOrder = lesson.getOrder();
        int newOrder = 0;
        switch (action) {
            case "up":
                newOrder = thisOrder - 1;
                break;
            case "down":
                newOrder = thisOrder + 1;
                break;
        }
        int subjectId = lesson.getSubjectId();
        if (newOrder >= 1 && newOrder <= getLatestOrder(subjectId)) {
            Lesson secondLesson = getLessonByOrder(newOrder, subjectId);
            if (secondLesson != null) {
                updateOrder(lessonId, newOrder);
                updateOrder(secondLesson.getId(), thisOrder);
            }
        }

    }

    public ArrayList<Lesson> getAllLessonsOfASubject(int subjectId) {
        String sql = "select * from lesson where subject_id = ?;";
        ArrayList<Lesson> list = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, subjectId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Lesson l = getLessonInfo(rs);
                list.add(l);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean isLessonExist(String name, int subjectId) {
        ArrayList<Lesson> list = getAllLessonsOfASubject(subjectId);
        for (Lesson lesson : list) {
            if (lesson.getName().equals(name)) {
                return true;
            }
        }
        return false;
    }

}
