/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.course;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import dal.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.course.*;

/**
 * @author PC
 */
public class MyCourseServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int classId = Integer.parseInt(request.getParameter("classId"));
            HttpSession session = request.getSession();
            CourseDAO courseDAO = new CourseDAO();
            CourseDetail courseDetail = courseDAO.getCourseDetailById(classId);
            ArrayList<CourseAnnouncement> announcements = courseDAO.getAnnouncementsByGroupId(classId);
            ArrayList<CourseLesson> lessons = courseDAO.getLessonsBySubjectId(courseDetail.getSubjectId());
            ArrayList<CourseTest> tests = courseDAO.getTestsByGroupId(classId);
            ArrayList<CourseFlashcardSet> flashcardSets = courseDAO.getFlashcardSetsBySubjectId(courseDetail.getSubjectId());
            MyCourse myCourse = new MyCourse(courseDetail, announcements, lessons, tests, flashcardSets);
            session.setAttribute("myCourse", myCourse);
            request.getRequestDispatcher("my-course.jsp").forward(request, response);
        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
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
