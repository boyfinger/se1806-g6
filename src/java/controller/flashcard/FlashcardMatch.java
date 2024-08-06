package controller.flashcard;

import dal.FlashcardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.flashcard.FlashcardAnswer;
import model.flashcard.FlashcardQuestions;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class FlashcardMatch extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            FlashcardDAO flashcardDAO = new FlashcardDAO();
            int flashcardSetId = Integer.parseInt(request.getParameter("flashcardSetId"));
            List<FlashcardQuestions> flashcards = flashcardDAO.getFlashcardQuestions(flashcardSetId);

            Collections.shuffle(flashcards); // Randomize flashcards
            request.setAttribute("flashcards", flashcards);
            RequestDispatcher dispatcher = request.getRequestDispatcher("flashcard-match.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException | ServletException | IOException | SQLException e) {
            throw new RuntimeException(e);
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
        return "Flashcard Match Servlet";
    }
}
