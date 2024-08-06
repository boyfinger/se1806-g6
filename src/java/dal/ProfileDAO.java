package dal;

import model.User;
import model.course.Course;
import model.course.CourseStudentCount;
import model.flashcard.Flashcard;
import model.subject.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProfileDAO extends DBContext {

    public void updateUserProfile(User user) throws SQLException {
        PreparedStatement ps = null;
        try {
            // SQL query to update user's name and avatar, but not email or role
            String query = "UPDATE `user` SET name = ?, avt = ? WHERE id = ?";

            ps = connection.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getAvatar());
            ps.setInt(3, user.getId());

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Update profile failed, no rows affected.");
            }
        } finally {
            if (ps != null) {
                ps.close();
            }
        }
    }

    public ArrayList<Flashcard> getFlashcardsByUserId(int userId) {
        ArrayList<Flashcard> list = new ArrayList<>();
        String sql = "SELECT * FROM flashcard_set WHERE created_by = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Flashcard f = new Flashcard();
                f.setFlashcardSetId(rs.getInt("id"));
                f.setName(rs.getString("name"));
                f.setSubjectId(rs.getInt("subject_id"));
                list.add(f);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public ArrayList<Subject> getAllSubjects() {
        ArrayList<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subject";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject s = new Subject();
                s.setId(rs.getInt("id"));
                s.setCode(rs.getString("code"));
                s.setName(rs.getString("name"));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public String getSubjectName(int subjectId) {
        String subjectName = "";
        String sql = "SELECT name FROM subject WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, subjectId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                subjectName = rs.getString("name");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return subjectName;
    }

    public String getSubjectCode(int subjectId) {
        String subjectCode = "";
        String sql = "SELECT code FROM subject WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, subjectId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                subjectCode = rs.getString("code");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return subjectCode;
    }

    public int getNumQuestions(int flashcardSetId) {
        String sql = "SELECT COUNT(*) AS num_questions FROM flashcard_question WHERE flashcard_set_id = ?";
        int numQuestions = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, flashcardSetId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                numQuestions = rs.getInt("num_questions");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return numQuestions;
    }

    public ArrayList<Course> myCourses(int userId) throws SQLException {
        String sql = """
                SELECT\s
                    g.id AS courseId,
                    g.class_id AS classId,
                    c.code AS classCode,
                    g.subject_id AS subjectId,
                    s.code AS subjectCode,
                    s.name AS subjectName,
                    g.instructor_id AS instructorId,
                    instr.name AS instructorName
                FROM\s
                    student_group sg
                JOIN\s
                    `user` u ON sg.student_id = u.id
                JOIN\s
                    `group` g ON sg.group_id = g.id
                JOIN\s
                    class c ON g.class_id = c.id
                JOIN\s
                    subject s ON g.subject_id = s.id
                JOIN\s
                    `user` instr ON g.instructor_id = instr.id
                WHERE\s
                    u.id = ?
                ORDER BY\s
                    g.id;""";
        PreparedStatement ps = connection.prepareStatement(sql);
        ArrayList<Course> list = new ArrayList<>();
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Course c = new Course();
            c.setId(rs.getInt("courseId"));
            c.setClassId(rs.getInt("classId"));
            c.setClassName(rs.getString("classCode"));
            c.setSubjectId(rs.getInt("subjectId"));
            c.setSubjectCode(rs.getString("subjectCode"));
            c.setSubjectName(rs.getString("subjectName"));
            c.setInstructorId(rs.getInt("instructorId"));
            c.setInstructorName(rs.getString("instructorName"));
            list.add(c);
        }
        return list;
    }

    public CourseStudentCount getStudentsByGroupId(int groupId) throws SQLException {
        String sql = """
                SELECT
                    COUNT(u.id) AS studentCount
                FROM
                    student_group sg
                JOIN
                    user u ON sg.student_id = u.id
                JOIN
                    `group` g ON sg.group_id = g.id
                WHERE
                    g.id = ? AND u.status = 1;
                """;
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, groupId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int studentCount = rs.getInt("studentCount");
            return new CourseStudentCount(groupId, studentCount);
        }
        return null; // Handle if no results found
    }
}
