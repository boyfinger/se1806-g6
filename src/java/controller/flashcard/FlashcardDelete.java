/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.flashcard;

import java.io.IOException;
import java.io.PrintWriter;

import dal.FlashcardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * @author PC
 */
public class FlashcardDelete extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int flashcardSetId = Integer.parseInt(request.getParameter("flashcardSetId"));

        FlashcardDAO flashcardDAO = new FlashcardDAO();
        boolean isDeleted = flashcardDAO.deleteFlashcardSet(flashcardSetId);

        if (isDeleted) {
            response.sendRedirect(request.getContextPath() + "/flashcard");
        } else {
            request.setAttribute("errorMessage", "Failed to delete the flashcard set. Please try again.");
            request.getRequestDispatcher("/flashcard").forward(request, response);
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
