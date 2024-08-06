/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.flashcard;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import dal.FlashcardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.flashcard.FlashcardAnswer;
import model.flashcard.FlashcardQuestions;

/**
 * @author PC
 */
public class FlashcardTest extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FlashcardDAO flashcardDAO = new FlashcardDAO();
            int flashcardSetId = Integer.parseInt(request.getParameter("flashcardSetId"));
            List<FlashcardQuestions> flashcardQuestions = flashcardDAO.getFlashcardQuestions(flashcardSetId);
            List<FlashcardAnswer> allAnswers = flashcardDAO.getSetAnswers(flashcardSetId);
            request.setAttribute("flashcardQuestions", flashcardQuestions);
            request.setAttribute("allAnswers", allAnswers);
            request.getRequestDispatcher("/flashcard-test.jsp").forward(request, response);
        } catch (SQLException e) {
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
        return "Short description";
    }// </editor-fold>

}
