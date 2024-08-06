package controller.signup;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mail.GenerateVerifyCode;
import mail.SendMail;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "SignUpServlet", urlPatterns = {"/signup"})
public class SignUpServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String avt = "assets/img/default_avt.jpg";
        int role = 3;
        int status = 0;
        HttpSession session = request.getSession();
        UserDAO dao = new UserDAO();
        if (fullName == null || email == null || password == null || repassword == null) {
            session.setAttribute("message", "Please fill in all fields.");
            response.sendRedirect("signup.jsp");
        } else if (dao.checkEmailExist(email)) {
            session.setAttribute("message", "Email already exists.");
            response.sendRedirect("signup.jsp");
        } else if (!password.equals(repassword)) {
            session.setAttribute("message", "Passwords do not match.");
            response.sendRedirect("signup.jsp");
        } else {
            User user = new User();
            user.setName(fullName);
            user.setEmail(email);
            user.setRole(role);
            user.setAvatar(avt);
            user.setStatus(status);
            String verificationCode = GenerateVerifyCode.GenerateCode();
            String subject = "Verify Email";
            String body = "Hello, " + fullName + "! Your verification code for KMS is: " + verificationCode;
            SendMail.sendMail(email, subject, body);
            session.setAttribute("user", user);
            session.setAttribute("password", password);
            session.setAttribute("verificationCode", verificationCode);
            response.sendRedirect("verificate-email.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
