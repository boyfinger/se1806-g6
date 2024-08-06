package controller.course;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dal.CourseDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.course.Course;
import model.course.CourseStudentCount;
import model.User;

public class CourseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
            } else {
                CourseDAO courseDAO = new CourseDAO();
                List<Course> courses = courseDAO.getAllCourse();
                List<Course> myCourses = courseDAO.myCourses(user.getEmail());
                
                List<CourseStudentCount> courseStudentCounts = new ArrayList<>();
                for (Course course : courses) {
                    CourseStudentCount courseStudentCount = courseDAO.getStudentsByGroupId(course.getId());
                    courseStudentCounts.add(courseStudentCount);
                }

                // Get current page number from request
                String pageParam = request.getParameter("page");
                int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;
                int coursesPerPage = 3;

                // Calculate total pages
                int totalCourses = courses.size();
                int totalPages = (int) Math.ceil((double) totalCourses / coursesPerPage);

                // Calculate the start and end index for the courses to display
                int startIndex = (currentPage - 1) * coursesPerPage;
                int endIndex = Math.min(startIndex + coursesPerPage, totalCourses);
                List<Course> coursesToDisplay = courses.subList(startIndex, endIndex);

                // Set attributes for the JSP
                session.setAttribute("courses", courses);
                session.setAttribute("myCourses", myCourses);
                session.setAttribute("courseStudentCounts", courseStudentCounts);
                request.setAttribute("coursesToDisplay", coursesToDisplay);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);

                // Forward the request to course.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("course.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
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
