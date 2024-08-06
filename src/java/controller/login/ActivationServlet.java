package controller.login;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.User;

public class ActivationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ActivationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActivationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        UserDAO userDAO = new UserDAO();
        boolean successful = true;

        String enteredCode = request.getParameter("code");
        String activationCode = request.getParameter("activationCode");

        if (enteredCode == null || enteredCode.isEmpty()) {
            successful = false;
            request.setAttribute("err", "Please enter your code!");
        } else {
            if (!enteredCode.equals(activationCode)) {
                successful = false;
                request.setAttribute("err", "Incorrect code!");
            }
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = userDAO.getUserById(userId);

        try {
            userDAO.changeUserStatus(userId);
        } catch (SQLException e) {
            successful = false;
            request.setAttribute("err", "Fail to activate your account, please try again!");
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("dashboard");
        } else {
            request.setAttribute("code", enteredCode);
            request.setAttribute("activationCode", activationCode);
            request.setAttribute("user", user);
            request.getRequestDispatcher("enteractivationcode.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
