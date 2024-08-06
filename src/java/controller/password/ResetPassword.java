package controller.password;

import controller.encrypt.BCrypt;
import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet for resetting the user's password.
 */
public class ResetPassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");
        if (action != null && action.equals("setNewPassword")) {
            boolean successful = true;

            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            int userId = Integer.parseInt(request.getParameter("userId"));
            if (newPassword.isEmpty()) {
                successful = false;
                request.setAttribute("newPasswordErr", "Password is blank!");
            }
            if (newPassword.length() > 60) {
                successful = false;
                request.setAttribute("newPasswordErr", "Password can not exceed 60 characters!");
            }

            if (successful) {
                if (!confirmPassword.equals(newPassword)) {
                    successful = false;
                    request.setAttribute("confirmPasswordErr", "Password does not match!");
                } else {
                    try {
                        userDAO.setNewPassword(userId, newPassword);
                    } catch (SQLException e) {
                        successful = false;
                        request.setAttribute("err", "Failed to set new password, please try again later!");
                    }
                }
            }

            if (successful) {
                session.invalidate();   // Invalidate the session
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("newPassword", newPassword);
                request.setAttribute("confirmPassword", confirmPassword);
                request.setAttribute("user", userDAO.getUserById(userId));
                request.getRequestDispatcher("setnewpassword.jsp").forward(request, response);
            }
        } else {
            User user = (User) session.getAttribute("user");
            UserDAO userdao = new UserDAO();

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String oldpassword = request.getParameter("oldpassword");
            String newpassword = request.getParameter("newpassword");
            String confirmpassword = request.getParameter("confirmpassword");

            if (oldpassword == null || newpassword == null || confirmpassword == null) {
                session.setAttribute("message", "Please fill in all fields.");
                response.sendRedirect("change-password.jsp");
            } // Check if the old password is correct
            else if (!BCrypt.checkpw(oldpassword, userdao.getPasswordByEmail(user.getEmail()))) {
                session.setAttribute("message", "Incorrect password.");
                response.sendRedirect("change-password.jsp");
            } else if (!newpassword.equals(confirmpassword)) {
                session.setAttribute("message", "New passwords do not match.");
                response.sendRedirect("change-password.jsp");
            } else {

                UserDAO dao = new UserDAO();

                try {
                    session.invalidate();   // Invalidate the session
                    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                    dispatcher.forward(request, response);
                } catch (Exception e) {
                    session.setAttribute("message", "Password reset failed: " + e.getMessage());
                    response.sendRedirect("change-password.jsp");
                }
            }
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
        return "Handles password reset requests";
    }
}
