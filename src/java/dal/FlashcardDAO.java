package dal;

import model.flashcard.Flashcard;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.flashcard.FlashcardAnswer;
import model.flashcard.FlashcardQuestions;
import model.subject.Subject;

public class FlashcardDAO extends DBContext {

    public ArrayList<Flashcard> getAllFlashcards() throws SQLException {
        String sql = "select * from flashcard_set";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        ArrayList<Flashcard> list = new ArrayList<>();
        while (rs.next()) {
            Flashcard f = new Flashcard();
            f.setFlashcardSetId(rs.getInt("id"));
            f.setName(rs.getString("name"));
            f.setSubjectId(rs.getInt("subject_id"));
            list.add(f);
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

    public ArrayList<FlashcardQuestions> getFlashcardQuestions(int flashcardSetId) throws SQLException {
        String sql = "SELECT * FROM flashcard_question WHERE flashcard_set_id = ?";
        ArrayList<FlashcardQuestions> questions = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, flashcardSetId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                FlashcardQuestions question = new FlashcardQuestions();
                question.setQuestionId(resultSet.getInt("id"));
                question.setTerm(resultSet.getString("term"));
                question.setDefinition(resultSet.getString("definition"));
                question.setFlashcardSetId(resultSet.getInt("flashcard_set_id"));

                questions.add(question);
            }
        }
        return questions;
    }

    public boolean addFlashcardSet(String name, int subjectId, int userId) {
        String sql = "INSERT INTO flashcard_set (name, subject_id, created_by) VALUES (?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setInt(2, subjectId);
            st.setInt(3, userId);
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public void addFlashcardQuestions(ArrayList<FlashcardQuestions> questions, int flashcardSetId) {
        String sql = "INSERT INTO flashcard_question (term, definition, flashcard_set_id) VALUES (?, ?, ?)";
        try {
            connection.setAutoCommit(false);
            PreparedStatement st = connection.prepareStatement(sql);
            for (FlashcardQuestions question : questions) {
                st.setString(1, question.getTerm());
                st.setString(2, question.getDefinition());
                st.setInt(3, flashcardSetId);
                st.addBatch();
            }
            st.executeBatch();  // Add this line to execute the batch
            connection.commit();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            try {
                connection.rollback();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
    }


    public int getFlashcardSetId(String name) {
        String sql = "SELECT id FROM flashcard_set WHERE name = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return -1; // Return -1 if not found
    }

    public int getUserId(String email) {
        String sql = "SELECT id FROM user WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return -1; // Return -1 if not found
    }

    //retrieve all possible flashcard answers for the flashcard learn page
    public ArrayList<FlashcardAnswer> getFlashcardAnswers() {
        String sql = "SELECT * FROM flashcard_question";
        ArrayList<FlashcardAnswer> answers = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                FlashcardAnswer answer = new FlashcardAnswer();
                answer.setQuestionId(rs.getInt("id"));
                answer.setAnswer(rs.getString("definition"));
                answers.add(answer);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return answers;
    }

    public ArrayList<FlashcardAnswer> getSetAnswers(int setId) {
        String sql = "SELECT * FROM flashcard_question WHERE flashcard_set_id = ?";
        ArrayList<FlashcardAnswer> answers = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, setId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                FlashcardAnswer answer = new FlashcardAnswer();
                answer.setQuestionId(rs.getInt("id"));
                answer.setAnswer(rs.getString("definition"));
                answers.add(answer);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return answers;
    }


    public boolean isOwner(String email, int flashcardSetId) {
        String sql = "SELECT * FROM flashcard_set WHERE id = ? AND created_by = (SELECT id FROM user WHERE email = ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, flashcardSetId);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public Flashcard getFlashcardSetById(int flashcardSetId) {
        String sql = "SELECT * FROM flashcard_set WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, flashcardSetId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Flashcard flashcardSet = new Flashcard();
                flashcardSet.setFlashcardSetId(flashcardSetId);
                flashcardSet.setName(rs.getString("name"));
                flashcardSet.setSubjectId(rs.getInt("subject_id"));
                return flashcardSet;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void updateFlashcardSet(int flashcardSetId, String title, int subjectId) throws SQLException {
        String query = "UPDATE flashcard_set SET name = ?, subject_id = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, title);
            ps.setInt(2, subjectId);
            ps.setInt(3, flashcardSetId);
            ps.executeUpdate();
        }
    }

    public void updateFlashcardQuestions(int flashcardSetId, List<FlashcardQuestions> questions) throws SQLException {
        String deleteQuery = "DELETE FROM flashcard_question WHERE flashcard_set_id = ?";
        try (PreparedStatement deletePs = connection.prepareStatement(deleteQuery)) {
            deletePs.setInt(1, flashcardSetId);
            deletePs.executeUpdate();
        }

        String insertQuery = "INSERT INTO flashcard_question (flashcard_set_id, term, definition) VALUES (?, ?, ?)";
        try (PreparedStatement insertPs = connection.prepareStatement(insertQuery)) {
            for (FlashcardQuestions question : questions) {
                insertPs.setInt(1, flashcardSetId);
                insertPs.setString(2, question.getTerm());
                insertPs.setString(3, question.getDefinition());
                insertPs.addBatch();
            }
            insertPs.executeBatch();
        }
    }

    public boolean deleteFlashcardSet(int flashcardSetId) {
        String deleteQuestionsSQL = "DELETE FROM flashcard_question WHERE flashcard_set_id = ?";
        String deleteFlashcardSetSQL = "DELETE FROM flashcard_set WHERE id = ?";

        try {
            // Disable auto-commit
            connection.setAutoCommit(false);

            // Delete flashcard questions
            try (PreparedStatement deleteQuestionsPs = connection.prepareStatement(deleteQuestionsSQL)) {
                deleteQuestionsPs.setInt(1, flashcardSetId);
                deleteQuestionsPs.executeUpdate();
            }

            // Delete flashcard set
            try (PreparedStatement deleteFlashcardSetPs = connection.prepareStatement(deleteFlashcardSetSQL)) {
                deleteFlashcardSetPs.setInt(1, flashcardSetId);
                int rowsAffected = deleteFlashcardSetPs.executeUpdate();

                if (rowsAffected > 0) {
                    // Commit transaction if deletion was successful
                    connection.commit();
                    return true;
                }
            }
        } catch (SQLException e) {
            // Rollback transaction on error
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                System.out.println("Rollback failed: " + rollbackEx.getMessage());
            }
            System.out.println("Error deleting flashcard set: " + e.getMessage());
        } finally {
            // Restore auto-commit
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Failed to restore auto-commit: " + e.getMessage());
            }
        }
        return false;
    }

    public String getFlashcardName(int flashcardSetId) {
        String flashcardSetName = "";
        String sql = "SELECT name FROM flashcard_set WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, flashcardSetId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                flashcardSetName = rs.getString("name");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return flashcardSetName;
    }
}
