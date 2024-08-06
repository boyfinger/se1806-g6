package controller;

import common.EmailValidator;
import dal.ClassDAO;
import dal.ContactDAO;
import dal.SubjectDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import model.contact.Contact;
import model.contact.ContactError;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    UserDAO userDAO = new UserDAO();
    SubjectDAO subjectDAO = new SubjectDAO();
    ClassDAO classDAO = new ClassDAO();
    ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("numberOfSubjects", subjectDAO.getNumberOfSubjects());
        request.setAttribute("numberOfStudents", userDAO.getNumberOfStudents());
        request.setAttribute("numberOfTeachers", userDAO.getNumberOfTeachers());
        request.setAttribute("numberOfClasses", classDAO.getNumberOfClasses());
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "contactadmin":
                contactAdmin(request, response);
        }
    }

    private Contact getContactInfo(HttpServletRequest request) {
        Contact c = new Contact();
        c.setName(request.getParameter("name"));
        c.setEmail(request.getParameter("email"));
        c.setSubject(request.getParameter("subject"));
        c.setPhone(request.getParameter("phone"));
        c.setMessage(request.getParameter("message"));
        return c;
    }

    private ContactError getContactErrorInfo(Contact c) {
        boolean error = false;
        ContactError ce = new ContactError();
        if ((c.getName().length() < 2) || (c.getName().length() > 60)) {
            error = true;
            ce.setNameErr("Please input the Name with length in range of 2 to 60!");
        } else {
            if (!c.getName().matches("^[A-Za-z\s]+$")) {
                error = true;
                ce.setNameErr("Name contain invalid characters!");
            }
        }
        if ((c.getEmail().length() < 5) || (c.getEmail().length() > 35)) {
            error = true;
            ce.setEmailErr("Please enter email from 5-35 characters!");
        } else {
            if (!EmailValidator.validate(c.getEmail())) {
                error = true;
                ce.setEmailErr("Please enter a valid email!");
            }
        }
        if ((!c.getPhone().matches("0[0-9]{9}")) || (c.getPhone().equals("0000000000"))) {
            error = true;
            ce.setPhoneErr("Please enter a valid phone number");
        }
        if ((c.getSubject().length() < 5) || (c.getSubject().length() > 50)) {
            error = true;
            ce.setSubjectErr("Please input the subject with length in range of 5 to 50!");
        }
        if ((c.getMessage().length() < 1) || (c.getMessage().length() > 255)) {
            error = true;
            ce.setMessageErr("Please input the message with length in range of 1 to 255!");
        }
        if (error) {
            return ce;
        } else {
            return null;
        }
    }

    public void contactAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean error = false;
        String err = "";
        Contact c = getContactInfo(request);
        ContactError ce = getContactErrorInfo(c);

        if (ce == null) {
            try {
                contactDAO.newContact(c);
            } catch (SQLException e) {
                error = true;
                err = "Failed to send message";
            }
        }

        if ((error) || (ce != null)) {
            request.setAttribute("err", err);
            request.setAttribute("contactErr", ce);
        } else {
            request.setAttribute("success", "Message sent successfully!");
        }

        request.setAttribute("contact", c);
        request.getRequestDispatcher("home.jsp#contact-form").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
