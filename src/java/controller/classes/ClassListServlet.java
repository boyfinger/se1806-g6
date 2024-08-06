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

@WebServlet(name = "ClassListServlet", urlPatterns = {"/classlist"})
public class ClassListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ClassServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClassServlet at " + request.getContextPath() + "</h1>");
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
            request.setAttribute("list", classDAO.getAllClasses());
            request.getRequestDispatcher("classlist.jsp").forward(request, response);
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
                case "addnewclass":
                    addNewClass(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    void addNewClass(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String err = "";

        if (code.isEmpty()) {
            err = "Code cannot be empty!";
        } else {
            try {
                classDAO.addNewClass(code);
            } catch (SQLException e) {
                err = e.getMessage();
            }
        }

        if (!err.isEmpty()) {
            request.setAttribute("err", err);
            request.setAttribute("code", code);
        }

        request.setAttribute("list", classDAO.getAllClasses());
        request.getRequestDispatcher("classlist.jsp").forward(request, response);
    }

}
