package controller.course;

import dal.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.course.CourseDetail;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

public class CourseEnroll extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            CourseDetail courseDetail = new CourseDetail();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                // If no user is logged in, redirect to the login page
                session.setAttribute("message", "Please login");
                response.sendRedirect("login.jsp");
                return;
            }

            CourseDAO courseDAO = new CourseDAO();
            courseDetail = courseDAO.getCourseDetailById(courseId);
            if (courseDAO.isUserEnrolledInCourse(courseDetail.getId(), user.getEmail())) {
                response.sendRedirect(request.getContextPath() + "/my-course?classId=" + courseDetail.getId());
                return;

            }

            boolean enrolled = courseDAO.enrollUserInCourse(user.getEmail(), courseDetail.getClassId(), courseDetail.getSubjectId());

            if (enrolled) {
                response.sendRedirect("course");
            } else {
                // Handle enrollment failure, if needed
                // For example, set an error message and redirect
                session.setAttribute("message", "Enrollment failed. Please try again.");
                response.sendRedirect("course.jsp"); // Redirect to course listing page
            }
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
        return "Handles course enrollment for students";
    }
}
