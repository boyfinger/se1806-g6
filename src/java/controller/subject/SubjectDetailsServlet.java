package controller.subject;

import dal.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.subject.Subject;
import model.User;

@WebServlet(name = "SubjectDetailsServlet", urlPatterns = {"/subjectdetails"})
public class SubjectDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SubjectDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubjectDetailsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
        } else if (user.getRole() != 0) {
            response.sendRedirect("home");
        } else {
            refreshSession(request);
            switch (request.getParameter("action")) {
                case "viewsubjectdetails": {
                    if (request.getParameter("changestatus") == null) {
                        viewSubjectDetails(request, response);
                    } else {
                        activateOrDeactivate(request, response);
                    }
                }
                break;
            }
        }
    }

    void refreshSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("user", session.getAttribute("user"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
        } else if (user.getRole() != 0) {
            response.sendRedirect("home");
        } else {
            refreshSession(request);
            switch (request.getParameter("action")) {
                case "updatesubject":
                    updateSubject(request, response);
                    break;
            }
        }
    }

    void viewSubjectDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("subject", subjectDAO.getSubjectMatchId(id));
        request.getRequestDispatcher("subjectdetails.jsp").forward(request, response);
    }

    void activateOrDeactivate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        try {
            subjectDAO.activateOrDeactivateSubject(id, status);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        response.sendRedirect("subjectlist");
    }

    void updateSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        int id = Integer.parseInt(request.getParameter("id"));
        String err = "";
        Subject s = new Subject();

        if ((code.isEmpty()) || (name.isEmpty())) {
            err = "Input fields cannot be empty!";
        } else {
            try {
                s = new Subject(id, code, name, status);
                subjectDAO.updateSubject(s);
            } catch (SQLException e) {
                err = "Code existed!";
            }
        }

        if (err.isEmpty()) {
            response.sendRedirect("subjectlist");
        } else {
            request.setAttribute("err", err);
            request.setAttribute("subject", s);
            request.getRequestDispatcher("subjectdetails.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
