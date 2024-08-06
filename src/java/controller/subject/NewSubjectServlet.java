package controller.subject;

import dal.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import model.subject.Subject;

public class NewSubjectServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewSubjectServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewSubjectServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    SubjectDAO subjectDAO = new SubjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("newsubject.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String err = "";
        Subject s = new Subject();

        if ((code.isEmpty()) || (name.isEmpty())) {
            err = "Input fields cannot be empty!";
        } else {
            try {
                s.setCode(code);
                s.setName(name);
                subjectDAO.addNewSubject(s);
            } catch (SQLException e) {
                err = "Code existed!";
            }
        }

        if (err.isEmpty()) {
            response.sendRedirect("subjectlist");
        } else {
            request.setAttribute("err", err);
            request.setAttribute("subject", s);
            request.getRequestDispatcher("newsubject.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
