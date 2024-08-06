package controller.flashcard;

import dal.FlashcardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.flashcard.Flashcard;
import model.subject.Subject;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FlashcardServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            FlashcardDAO flashcardDAO = new FlashcardDAO();

            // Retrieve flashcards
            List<Flashcard> flashcards = flashcardDAO.getAllFlashcards();

            // Retrieve subjects
            ArrayList<Subject> allSubjects = flashcardDAO.getAllSubjects();
            session.setAttribute("subjects", allSubjects);

            // Calculate number of questions for each flashcard
            for (Flashcard flashcard : flashcards) {
                int numQuestions = flashcardDAO.getNumQuestions(flashcard.getFlashcardSetId());
                String subjectName = flashcardDAO.getSubjectName(flashcard.getSubjectId());
                String subjectCode = flashcardDAO.getSubjectCode(flashcard.getSubjectId());
                flashcard.setSubjectCode(subjectCode);
                flashcard.setSubjectName(subjectName);
                flashcard.setNumQuestions(numQuestions);
            }
            session.setAttribute("flashcards", flashcards);


            // Forward the request to flashcard.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("flashcard.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
