/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.flashcard;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dal.FlashcardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.flashcard.FlashcardQuestions;
import model.User;

/**
 * @author PC
 */
public class FlashcardUpdate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
        } else {
            try {
                int flashcardSetId = Integer.parseInt(request.getParameter("flashcardSetId"));
                String title = request.getParameter("title");
                int subjectId = Integer.parseInt(request.getParameter("subjectId"));

                List<FlashcardQuestions> questions = new ArrayList<>();
                String[] terms = request.getParameterValues("term");
                String[] definitions = request.getParameterValues("definition");
                for (int i = 0; i < terms.length; i++) {
                    FlashcardQuestions question = new FlashcardQuestions();
                    question.setTerm(terms[i]);
                    question.setDefinition(definitions[i]);
                    questions.add(question);
                }

                FlashcardDAO flashcardDAO = new FlashcardDAO();
                flashcardDAO.updateFlashcardSet(flashcardSetId, title, subjectId);
                flashcardDAO.updateFlashcardQuestions(flashcardSetId, questions);

                session.setAttribute("flashcardSetId", flashcardSetId);
                session.setAttribute("flashcardQuestions", questions);
                session.setAttribute("flashcard", title); // Ensure the flashcard name is updated

                response.sendRedirect(request.getContextPath() + "/flashcard-question?flashcardSetId=" + flashcardSetId);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/flashcard");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
