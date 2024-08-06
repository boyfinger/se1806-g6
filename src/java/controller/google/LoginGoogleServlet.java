/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.google;

import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.google.GooglePojo;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import mail.GenerateVerifyCode;
import mail.SendMail;

/**
 * @author PC
 */
@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginGoogleServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
        } else {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
            String email = googlePojo.getEmail();
            UserDAO userDAO = new UserDAO();
            try {
                HttpSession session = request.getSession();
                if (userDAO.checkEmailExist(email)) {
                    // email đã tồn tại trong database
                    User user = new User();
                    user = userDAO.loginGoogle(email);
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
                    // email chưa tồn tại trong database
                    session.setAttribute("email", email);
                    response.sendRedirect("set-password.jsp");
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
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
        return "Handles Google Login";
    }
}
