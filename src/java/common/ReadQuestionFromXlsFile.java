package common;

import dal.AnswerDAO;
import dal.QuestionDAO;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Lesson;
import model.Answer;
import model.Question;
import org.apache.poi.ss.usermodel.*;

public class ReadQuestionFromXlsFile {

    QuestionDAO questionDAO = new QuestionDAO();
    AnswerDAO answerDAO = new AnswerDAO();

    private Question readQuestion(Row row) {
        String content = row.getCell(0).toString();
        content = StringFormatter.removeDoubleSpaces(content.trim());
        if (!content.isEmpty() && content.length() <= 255) {
            Question q = new Question();
            q.setContent(content);
            return q;
        }
        return null;
    }

    private ArrayList<Answer> readAnswer(Row row) {
        ArrayList<Answer> ret = new ArrayList<>();

        for (Cell cell : row) {
            String content = StringFormatter.removeDoubleSpaces(cell.toString().trim());
            if (!content.isEmpty() && content.length() <= 255) {
                Answer a = new Answer();
                a.setContent(content);
                ret.add(a);
            }
        }
        return ret;
    }

    private ArrayList<Answer> readCorrectAnswer(Row row, ArrayList<Answer> answerList) {
        int index = 0;
        for (Cell cell : row) {
            Answer a = answerList.get(index);
            a.setIsCorrect(cell.toString().equals("1.0"));
            answerList.set(index, a);
            index++;
            if (index == answerList.size()) {
                return answerList;
            }
        }
        return answerList;
    }

    private boolean insertQuestion(Question q, ArrayList<Answer> answerList, Lesson lesson) {
        if (q == null) {
            return false;
        }
        int correctAnswers = 0;
        int validAnswer = answerList.size();
        for (Answer a : answerList) {
            if (a.isIsCorrect()) {
                correctAnswers++;

            }
        }
        if ((correctAnswers == 0) || (validAnswer < 2)) {
            return false;
        }
        q.setStatus(true);
        q.setLesson(lesson);
        Question question = questionDAO.getQuestionByContent(q);
        if (question == null) {
            try {
                questionDAO.insertQuestion(q);
                for (Answer a : answerList) {
                    if (a.getContent().length() <= 255) {
                        a.setQuestion(q);
                        answerDAO.insertAnswer(a);
                    }
                }
                return true;
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
        return false;
    }

    public int readQuestionFromFile(Part part, Lesson lesson) throws IOException {
        Question q = null;
        ArrayList<Answer> answerList = null;
        int count = 0;

        InputStream fileContent = part.getInputStream();
        Workbook wb = WorkbookFactory.create(fileContent);
        Sheet sheet = wb.getSheetAt(0);
        int rowType = 0;
        for (Row row : sheet) {
            rowType++;
            switch (rowType % 3) {
                case 1:
                    answerList = new ArrayList<>();
                    q = readQuestion(row);
                    break;
                case 2:
                    answerList = readAnswer(row);
                    break;
                case 0:
                    answerList = readCorrectAnswer(row, answerList);
                    if (insertQuestion(q, answerList, lesson)) {
                        count++;
                    }
                    break;
            }
        }
        return count;
    }

}
