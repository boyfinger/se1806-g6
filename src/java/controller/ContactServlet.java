/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import common.EmailValidator;
import dal.ContactDAO;
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

/**
 *
 * @author DELL
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ContactServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ContactServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    private void goToPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/contact/contactadmin.jsp")
                .forward(request, response);
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
                ContactDAO contactDAO = new ContactDAO();
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
        request.getRequestDispatcher("/WEB-INF/contact/contactadmin.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (request.getParameter("action")) {
                case "enterInfo":

                default:
                    goToPage(request, response);
                    break;
            }
        } else {
            goToPage(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
