package controller;

import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import model.classes.Classes;
import model.Question;
import model.subject.Subject;
import model.User;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    UserDAO userDAO = new UserDAO();
    SubjectDAO subjectDAO = new SubjectDAO();
    ClassDAO classDAO = new ClassDAO();
    QuestionDAO questionDAO = new QuestionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private boolean isEqualDate(Date date1, Date date2) {
        return date1.getDay() == date2.getDay() && date1.getMonth() == date2.getMonth()
                && date1.getYear() == date2.getYear();
    }

    private void getUserStatistics(HttpServletRequest request) {
        ArrayList<User> userList = userDAO.getAllUsers();
        int newUsersToday = 0;
        Date today = new Date();
        for (User user : userList) {
            if (isEqualDate(today, user.getDateCreated())) {
                newUsersToday++;
            }
        }
        request.setAttribute("newUsersToday", newUsersToday);
        request.setAttribute("userList", userList);
    }

    private void getClassStastistic(HttpServletRequest request) {
        ArrayList<Classes> classList = classDAO.getAllClasses();
        request.setAttribute("classList", classList);
    }

    private void getSubjectStastistics(HttpServletRequest request) {
        ArrayList<Subject> subjectList = subjectDAO.getAllSubject();
        request.setAttribute("subjectList", subjectList);
    }

    private void getQuestionStastistic(HttpServletRequest request) {
        ArrayList<Question> questionList = questionDAO.getAllQuestions();
        request.setAttribute("questionList", questionList);

    }

    private void getStatistic(HttpServletRequest request) {
        getUserStatistics(request);
        getSubjectStastistics(request);
        getClassStastistic(request);
        getQuestionStastistic(request);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String contextPath = request.getServletContext().getContextPath();
        String loginPage = contextPath + "/login.jsp";
        String homePage = contextPath + "/home";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(loginPage);
        } else {
            User u = userDAO.getUserById(user.getId());
            if (u != null && u.getEmail() != null) {
                session.setAttribute("user", u);
                if (user.getRole() > 1) {
                    response.sendRedirect(homePage);
                } else {
                    getStatistic(request);
                    request.getRequestDispatcher("/WEB-INF/dashboard/dashboard.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(loginPage);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
