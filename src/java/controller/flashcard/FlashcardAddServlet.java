package controller.flashcard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import dal.FlashcardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.flashcard.FlashcardQuestions;
import model.User;

public class FlashcardAddServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(FlashcardAddServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String subjectIdStr = request.getParameter("subjectId");
        String[] terms = request.getParameterValues("term[]");
        String[] definitions = request.getParameterValues("definition[]");

        // Server-side validation
        if (title == null || title.trim().isEmpty() || subjectIdStr == null || subjectIdStr.trim().isEmpty()
                || terms == null || definitions == null || terms.length == 0 || definitions.length == 0
                || terms.length != definitions.length) {
            request.setAttribute("error", "Invalid input data. Please check all fields.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("create-flashcard.jsp");
            dispatcher.forward(request, response);
            return;
        }

        int subjectId;
        try {
            subjectId = Integer.parseInt(subjectIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid subject ID.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("create-flashcard.jsp");
            dispatcher.forward(request, response);
            return;
        }

        String userEmail = user.getEmail();

        FlashcardDAO dao = new FlashcardDAO();
        try {
            int userId = dao.getUserId(userEmail);
            if (userId == -1) {
                request.setAttribute("error", "User not found. Please log in again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
                return;
            }

            boolean setAdded = dao.addFlashcardSet(title, subjectId, userId);

            if (setAdded) {
                int flashcardSetId = dao.getFlashcardSetId(title);
                ArrayList<FlashcardQuestions> questions = new ArrayList<>();

                for (int i = 0; i < terms.length; i++) {
                    FlashcardQuestions question = new FlashcardQuestions();
                    question.setTerm(terms[i]);
                    question.setDefinition(definitions[i]);
                    question.setFlashcardSetId(flashcardSetId);
                    questions.add(question);
                }

                dao.addFlashcardQuestions(questions, flashcardSetId);
                response.sendRedirect(request.getContextPath() + "/flashcard");
            } else {
                request.setAttribute("error", "Failed to add flashcard set. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("create-flashcard.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding flashcard set", e);
            request.setAttribute("error", "An error occurred while adding the flashcard set. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("create-flashcard.jsp");
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