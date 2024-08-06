package dal;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Answer;

public class AnswerDAO extends DBContext implements Serializable {

    QuestionDAO questionDAO = new QuestionDAO();

    public ArrayList<Answer> getAllAnswersOfAQuestion(int questionId) {
        ArrayList<Answer> list = new ArrayList<>();

        String sql = "select * from answer where question_id = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Answer a = new Answer(rs.getInt("id"), rs.getString("content"),
                        rs.getBoolean("is_correct"), questionDAO.getQuestionMatchId(questionId));
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void deleteAllAnswersOfAQuestion(int questionId) throws SQLException {
        String sql = "delete from answer where question_id = ?;";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, questionId);
        st.execute();
    }

    public void insertAnswer(Answer a) throws SQLException {
        String sql = "insert into answer(content,is_correct,question_id) values (?,?,"
                + "(select id from question where content = ? and lesson_id = ?));";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, a.getContent());
        st.setBoolean(2, a.isIsCorrect());
        st.setString(3, a.getQuestion().getContent());
        st.setInt(4, a.getQuestion().getLesson().getId());
        st.execute();
    }

}
