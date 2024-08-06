package controller.flashcard;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dal.FlashcardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.flashcard.FlashcardQuestions;
import model.User;

public class FlashcardQuestionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
            } else {
                FlashcardDAO flashcardDAO = new FlashcardDAO();
                int flashcardSetId = Integer.parseInt(request.getParameter("flashcardSetId"));
                List<FlashcardQuestions> flashcardQuestions = flashcardDAO.getFlashcardQuestions(flashcardSetId);
                boolean isOwner = flashcardDAO.isOwner(user.getEmail(), flashcardSetId);
                session.setAttribute("isOwner", isOwner);
                session.setAttribute("flashcardSetId", flashcardSetId);
                session.setAttribute("flashcardQuestions", flashcardQuestions);
                session.setAttribute("flashcardSetName", flashcardDAO.getFlashcardName(flashcardSetId));
                RequestDispatcher dispatcher = request.getRequestDispatcher("flashcard-question.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp");
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
