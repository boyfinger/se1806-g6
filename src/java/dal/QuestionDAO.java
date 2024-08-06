package dal;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Question;

public class QuestionDAO extends DBContext implements Serializable {

    LessonDAO lessonDAO = new LessonDAO();

    public ArrayList<Question> getAllQuestionsOfALesson(int lessonId) {
        ArrayList<Question> ret = new ArrayList<>();

        ArrayList<Question> list = getAllQuestions();
        for (Question q : list) {
            if (q.getLesson().getId() == lessonId) {
                ret.add(q);
            }
        }
        return ret;
    }

    public ArrayList<Question> getAllQuestionsOfASubject(int subjectId) {
        ArrayList<Question> ret = new ArrayList<>();

        ArrayList<Question> list = getAllQuestions();
        for (Question q : list) {
            if (q.getLesson().getSubject().getId() == subjectId) {
                ret.add(q);
            }
        }
        return ret;
    }

    private Question getQuestionInfo(ResultSet rs) throws SQLException {
        Question q = new Question();
        q.setId(rs.getInt("id"));
        q.setContent(rs.getString("content"));
        q.setLesson(lessonDAO.getLessonMatchId(rs.getInt("lesson_id")));
        q.setStatus(rs.getBoolean("status"));
        return q;
    }

    public ArrayList<Question> getAllQuestions() {
        ArrayList<Question> list = new ArrayList<>();

        String sql = "select * from question;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Question q = getQuestionInfo(rs);
                list.add(q);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Question getQuestionMatchId(int questionId) {
        String sql = "select * from question where id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Question q = getQuestionInfo(rs);
                return q;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void changeQuestionStatus(Question q) throws SQLException {
        String sql = "update question set status = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        if (q.isStatus()) {
            st.setBoolean(1, false);
        } else {
            st.setBoolean(1, true);
        }
        st.setInt(2, q.getId());
        st.execute();
    }

    public Question getQuestionByContent(Question question) {
        ArrayList<Question> list = getAllQuestionsOfASubject(question.getLesson().getSubjectId());
        for (Question q : list) {
            if (q.getContent().equals(question.getContent())) {
                return q;
            }
        }
        return null;
    }

    public void insertQuestion(Question q) throws SQLException {
        String sql = "insert into question(content, status, lesson_id) values (?,?,?);";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, q.getContent());
        st.setBoolean(2, q.isStatus());
        st.setInt(3, q.getLesson().getId());
        st.execute();
    }

    public void updateQuestion(Question q) throws SQLException {
        String sql = "update question set content = ? where id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, q.getContent());
        st.setInt(2, q.getId());
        st.execute();
    }

}
