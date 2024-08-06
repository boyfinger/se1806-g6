package dal;

import model.course.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CourseDAO extends DBContext {

    public ArrayList<Course> getAllCourse() throws SQLException {
        String sql = """
                SELECT
                    g.id AS id,
                    g.class_id AS classId,
                    c.code AS className,
                    g.subject_id AS subjectId,
                    s.code AS subjectCode,
                    s.name AS subjectName,
                    g.instructor_id AS instructorId,
                    u.name AS instructorName
                FROM
                    `group` g
                JOIN
                    class c ON g.class_id = c.id
                JOIN
                    subject s ON g.subject_id = s.id
                JOIN
                    user u ON g.instructor_id = u.id;
                """;
        PreparedStatement st = connection.prepareStatement(sql);
        ArrayList<Course> list = new ArrayList<>();
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Course c = new Course();
            c.setId(rs.getInt("id"));
            c.setClassId(rs.getInt("classId"));
            c.setClassName(rs.getString("className"));
            c.setSubjectId(rs.getInt("subjectId"));
            c.setSubjectCode(rs.getString("subjectCode"));
            c.setSubjectName(rs.getString("subjectName"));
            c.setInstructorId(rs.getInt("instructorId"));
            c.setInstructorName(rs.getString("instructorName"));
            list.add(c);
        }
        return list;
    }

    public ArrayList<Course> myCourses(String email) throws SQLException {
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
                    u.email = ?
                ORDER BY\s
                    g.id;""";
        PreparedStatement ps = connection.prepareStatement(sql);
        ArrayList<Course> list = new ArrayList<>();
        ps.setString(1, email);
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


    public CourseDetail getCourseDetailById(int courseId) throws SQLException {
        String sql = "SELECT\n" +
                "    g.id AS id,\n" +
                "    g.class_id AS classId,\n" +
                "    c.code AS className,\n" +
                "    g.subject_id AS subjectId,\n" +
                "    s.name AS subjectName,\n" +
                "    u.name AS instructorName\n" +
                "FROM\n" +
                "    `group` g\n" +
                "JOIN\n" +
                "    class c ON g.class_id = c.id\n" +
                "JOIN\n" +
                "    subject s ON g.subject_id = s.id\n" +
                "JOIN\n" +
                "    user u ON g.instructor_id = u.id\n" +
                "WHERE\n" +
                "    g.id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, courseId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            CourseDetail courseDetail = new CourseDetail();
            courseDetail.setId(rs.getInt("id"));
            courseDetail.setClassId(rs.getInt("classId"));  // Updated line
            courseDetail.setClassName(rs.getString("className"));
            courseDetail.setSubjectId(rs.getInt("subjectId"));  // Updated line
            courseDetail.setSubjectName(rs.getString("subjectName"));
            courseDetail.setInstructorName(rs.getString("instructorName"));
            return courseDetail;
        }
        return null;
    }

    public boolean isUserEnrolledInCourse(int groupId, String email) throws SQLException {
        String sql = "SELECT 1 FROM student_group sg " +
                "JOIN user u ON sg.student_id = u.id " +
                "WHERE sg.group_id = ? AND u.email = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, groupId);
        ps.setString(2, email);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // Returns true if there is at least one record
    }

    public boolean enrollUserInCourse(String email, int classId, int subjectId) throws SQLException {
        // First, retrieve the user ID based on the email
        String getUserSql = "SELECT id FROM user WHERE email = ?";
        PreparedStatement psUser = connection.prepareStatement(getUserSql);
        psUser.setString(1, email);
        ResultSet rsUser = psUser.executeQuery();
        if (!rsUser.next()) {
            return false; // User not found
        }
        int userId = rsUser.getInt("id");

        // Retrieve the group ID based on classId and subjectId
        String getGroupSql = "SELECT id FROM `group` WHERE class_id = ? AND subject_id = ?";
        PreparedStatement psGroup = connection.prepareStatement(getGroupSql);
        psGroup.setInt(1, classId);
        psGroup.setInt(2, subjectId);
        ResultSet rsGroup = psGroup.executeQuery();
        if (!rsGroup.next()) {
            return false; // Group not found
        }
        int groupId = rsGroup.getInt("id");

        // Check if the user is already enrolled
        if (isUserEnrolledInCourse(groupId, email)) {
            return false; // User is already enrolled
        }

        // Enroll the user in the course
        String enrollSql = "INSERT INTO student_group (student_id, group_id) VALUES (?, ?)";
        PreparedStatement psEnroll = connection.prepareStatement(enrollSql);
        psEnroll.setInt(1, userId);
        psEnroll.setInt(2, groupId);
        psEnroll.executeUpdate();
        return true; // Enrollment successful
    }

    public ArrayList<CourseAnnouncement> getAnnouncementsByGroupId(int groupId) throws SQLException {
        String sql = "SELECT id, group_id, announcement FROM group_announcement WHERE group_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, groupId);
        ResultSet rs = ps.executeQuery();
        ArrayList<CourseAnnouncement> announcements = new ArrayList<>();
        while (rs.next()) {
            CourseAnnouncement announcement = new CourseAnnouncement();
            announcement.setId(rs.getInt("id"));
            announcement.setGroupId(rs.getInt("group_id"));
            announcement.setAnnouncement(rs.getString("announcement"));
            announcements.add(announcement);
        }
        return announcements;
    }

    public ArrayList<CourseFlashcardSet> getFlashcardSetsBySubjectId(int subjectId) throws SQLException {
        String sql = "SELECT * FROM flashcard_set WHERE subject_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, subjectId);
        ResultSet rs = ps.executeQuery();
        ArrayList<CourseFlashcardSet> flashcardSets = new ArrayList<>();
        while (rs.next()) {
            CourseFlashcardSet flashcardSet = new CourseFlashcardSet();
            flashcardSet.setId(rs.getInt("id"));
            flashcardSet.setSubjectId(rs.getInt("subject_id"));
            flashcardSet.setName(rs.getString("name"));
            flashcardSets.add(flashcardSet);
        }
        return flashcardSets;
    }

    public ArrayList<CourseTest> getTestsByGroupId(int groupId) throws SQLException {
        String sql = "SELECT test_id, group_id FROM test_group WHERE group_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, groupId);
        ResultSet rs = ps.executeQuery();
        ArrayList<CourseTest> tests = new ArrayList<>();
        while (rs.next()) {
            CourseTest test = new CourseTest();
            test.setId(rs.getInt("test_id"));
            test.setGroupId(rs.getInt("group_id"));
            tests.add(test);
        }
        return tests;
    }

    public ArrayList<CourseLesson> getLessonsBySubjectId(int subjectId) throws SQLException {
        String sql = "SELECT * FROM lesson WHERE subject_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, subjectId);
        ResultSet rs = ps.executeQuery();
        ArrayList<CourseLesson> lessons = new ArrayList<>();
        while (rs.next()) {
            CourseLesson lesson = new CourseLesson();
            lesson.setId(rs.getInt("id"));
            lesson.setSubjectId(rs.getInt("subject_id"));
            lesson.setName(rs.getString("name"));
            lessons.add(lesson);
        }
        return lessons;
    }

    public boolean newAnnouncement(int groupId, String announcement) throws SQLException {
        String sql = "INSERT INTO group_announcement (group_id, announcement) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, groupId);
            ps.setString(2, announcement);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
