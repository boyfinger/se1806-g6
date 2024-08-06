package controller.classes;

import dal.ClassDAO;
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
import model.classes.Classes;
import model.User;

@WebServlet(name = "ClassDetailsServlet", urlPatterns = {"/classdetails"})
public class ClassDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ClassDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClassDetailsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    ClassDAO classDAO = new ClassDAO();
    SubjectDAO subjectDAO = new SubjectDAO();

    void refreshSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("user", session.getAttribute("user"));
    }

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
                case "viewclassdetails":
                    viewClassDetails(request, response);
            }
        }
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
                case "updateclass":
                    updateClass(request, response);
            }
        }
    }

    void viewClassDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        request.setAttribute("classes", classDAO.getClassMatchId(id));
        request.setAttribute("list", classDAO.getAllClasses());
        request.setAttribute("action", "viewclassdetails");
        request.setAttribute("subjectlist", subjectDAO.getAllSubjectNotAssigned(id));
        request.getRequestDispatcher("classdetails.jsp").forward(request, response);
    }

    void updateClass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        String err = "";
        Classes c = new Classes();

        if (code.isEmpty()) {
            err = "Code cannot be blank!";
        } else {
            c = new Classes(id, code);
            try {
                classDAO.updateClass(c);
            } catch (SQLException e) {
                err = "Code already exist!";
            }
        }

        if (err.isEmpty()) {
            response.sendRedirect("classlist");
        } else {
            request.setAttribute("classes", c);
            request.setAttribute("err", err);
            request.setAttribute("subjectlist", subjectDAO.getAllSubjectNotAssigned(id));
            request.getRequestDispatcher("classdetails.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
