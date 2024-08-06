package controller.login;

import dal.UserDAO;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mail.GenerateVerifyCode;
import mail.SendMail;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        if (u != null) {
            response.sendRedirect("home");
        } else {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            UserDAO userDAO = new UserDAO();
            try {
                User user = userDAO.login(email, password);
                if (user != null || user.getEmail() == null) {
                    switch (user.getStatus()) {
                        case 2:
                            request.setAttribute("user", user);
                            request.getRequestDispatcher("/WEB-INF/account/setnewpassword.jsp").forward(request, response);
                            break;
                        case 0:
                            String receiver = user.getEmail();
                            String subject = "Your activation code";
                            String activationCode = GenerateVerifyCode.GenerateCode();
                            String content = "Your activation code is: " + activationCode;
                            SendMail.sendMail(receiver, subject, content);

                            request.setAttribute("activationCode", activationCode);
                            request.setAttribute("user", user);
                            request.getRequestDispatcher("/WEB-INF/account/enteractivationcode.jsp").forward(request, response);
                            break;
                        default:
                            session.setAttribute("user", user);
                            switch (user.getRole()) {
                                case 0:
                                case 1:
                                    response.sendRedirect("dashboard");
                                    break;
                                default:
                                    response.sendRedirect("home");
                            }
                            break;
                    }
                } else {
                    session.setAttribute("message", "Invalid email or password");
                    response.sendRedirect("login.jsp");
                }
            } catch (SQLException e) {
                throw new ServletException("Login failed", e);
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
}
