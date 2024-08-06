package controller.course;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.CourseDAO;
import model.course.MyCourse;

public class CourseNewAnnouncement extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve announcement text from the form
        String announcement = request.getParameter("announcement");

        // Retrieve myCourse from session
        MyCourse myCourse = (MyCourse) request.getSession().getAttribute("myCourse");
        if (myCourse == null) {
            response.sendRedirect("login.jsp"); // Redirect to error page if myCourse is null
            return;
        }

        // Retrieve classId from myCourse
        int classId = myCourse.getCourseDetail().getId();

        try {
            // Update database with new announcement
            CourseDAO courseDAO = new CourseDAO();
            courseDAO.newAnnouncement(classId, announcement);

            // Update myCourse with latest announcements
            myCourse.setAnnouncements(courseDAO.getAnnouncementsByGroupId(classId));

            // Update session attribute
            HttpSession session = request.getSession();
            session.setAttribute("myCourse", myCourse);

            // Redirect back to my-course.jsp
            response.sendRedirect("my-course.jsp");

        } catch (Exception e) {
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
    }

}
