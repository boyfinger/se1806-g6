package controller;

import model.User;
import model.Role;
import common.AvatarHandler;
import common.EmailValidator;
import common.PasswordGenerator;
import common.StringFormatter;
import dal.SubjectDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import mail.SendMail;
import model.subject.Subject;

@MultipartConfig
@WebServlet(name = "UserServlet", urlPatterns = {"/user", "/user/update", "/user/details", "/user/new"})
public class UserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    UserDAO userDAO = new UserDAO();
    SubjectDAO subjectDAO = new SubjectDAO();
    AvatarHandler avatarHandler = new AvatarHandler();
    private final int rowPerPage = 6;

    private String getWorkingDir() {
        String directory = getServletContext().getRealPath("") + "";
        return directory.replace("\\build\\web\\", "\\web\\");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String contextPath = request.getServletContext().getContextPath();
        String loginPage = contextPath + "/login.jsp";
        String homePage = contextPath + "/home";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(loginPage);
        } else {
            User u = userDAO.getUserById(user.getId());
            if (u != null && u.getEmail() != null) {
                session.setAttribute("user", u);
                if (user.getRole() != 0) {
                    response.sendRedirect(homePage);
                } else {
                    String action = request.getServletPath();
                    switch (action) {
                        case "/user":
                            viewUserList(request, response);
                            break;
                        case "/user/update":
                            updateUser(request, response);
                            break;
                        case "/user/details":
                            viewUserDetails(request, response);
                            break;
                        case "/user/new":
                            newUser(request, response);
                            break;
                    }
                }
            } else {
                response.sendRedirect(loginPage);
            }
        }

    }

    private ArrayList<String> allSortOptions() {
        ArrayList<String> list = new ArrayList<>();
        list.add("Name");
        list.add("Email");
        list.add("Role");
        list.add("Status");
        return list;
    }

    private ArrayList<User> getUsersMatchRole(int roleId, ArrayList<User> list) {
        ArrayList<User> ret = new ArrayList<>();
        for (User user : list) {
            if (user.getRole() == roleId) {
                ret.add(user);
            }
        }
        return ret;
    }

    private ArrayList<User> getUsersContainKeyWord(String keyWord, ArrayList<User> list) {
        ArrayList<User> ret = new ArrayList<>();
        for (User user : list) {
            if (user.getName().contains(keyWord) || user.getEmail().contains(keyWord)) {
                ret.add(user);
            }
        }
        return ret;
    }

    private int getNoOfPages(ArrayList<User> list) {
        int length = list.size();
        if (length == 0) {
            return 1;
        }
        int noOfPages = length / rowPerPage;
        if (length % rowPerPage == 0) {
            return noOfPages;
        }
        return noOfPages + 1;
    }

    private int getPage(HttpServletRequest request, int noOfPages) {
        String cur = request.getParameter("currentPage");
        if ((cur == null) || (cur.isEmpty())) {
            return 1;
        }

        int currentPage = Integer.parseInt(cur);
        switch (request.getParameter("pageAction")) {
            case "firstPage":
                return 1;
            case "prevPage": {
                currentPage--;
                if (currentPage < 1) {
                    return 1;
                } else {
                    return currentPage;
                }
            }
            case "nextPage": {
                currentPage++;
                if (currentPage > noOfPages) {
                    return noOfPages;
                } else {
                    return currentPage;
                }
            }
            case "lastPage":
                return noOfPages;
        }

        String newpage = request.getParameter("newPage");
        if ((newpage != null) && (!newpage.isEmpty())) {
            int newPage = Integer.parseInt(newpage);
            return newPage;
        }
        return currentPage;

    }

    private int getAdminIndex(ArrayList<Role> roleList) {
        int index = 0;
        for (Role role : roleList) {
            if (role.getName().equals("Admin")) {
                return index;
            }
            index++;
        }
        return -1;
    }

    private ArrayList<Role> getRoleList() {
        ArrayList<Role> roleList = userDAO.getAllRoles();
        int index = getAdminIndex(roleList);
        if (index != -1) {
            roleList.remove(getAdminIndex(roleList));
        }
        return roleList;
    }

    private ArrayList<User> getAllUsersOfPage(int page, ArrayList<User> list) {
        ArrayList<User> ret = new ArrayList<>();
        int start = rowPerPage * (page - 1) + 1;
        int end = rowPerPage * page;
        if (start < 1) {
            start = 1;
        }
        if (end > list.size()) {
            end = list.size();
        }

        for (int i = start - 1; i < end; i++) {
            ret.add(list.get(i));
        }
        return ret;
    }

    private void viewUserList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<User> list = userDAO.getAllUsers();

        String rid = request.getParameter("roleId");
        if (rid != null && !rid.isEmpty()) {
            int roleId = Integer.parseInt(rid);
            request.setAttribute("roleId", roleId);
            if (roleId != 0) {
                list = getUsersMatchRole(roleId, list);
            }
        }

        String keyWord = request.getParameter("keyWord");
        if (keyWord != null && !keyWord.isEmpty()) {
            list = getUsersContainKeyWord(keyWord, list);
        }

        String sortBy = request.getParameter("sortBy");
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "Name":
                    Collections.sort(list, new User.SortByName());
                    break;
                case "Email":
                    Collections.sort(list, new User.SortByEmail());
                    break;
                case "Role":
                    Collections.sort(list, new User.SortByRole());
                    break;
                case "Status":
                    Collections.sort(list, new User.SortByStatus());
                    break;
            }
        }

        int noOfPages = getNoOfPages(list);
        int currentPage = getPage(request, noOfPages);
        list = getAllUsersOfPage(currentPage, list);

        HttpSession session = request.getSession();
        if (session.getAttribute("successful") != null) {
            request.setAttribute("successful", session.getAttribute("successful"));
            session.removeAttribute("successful");
        } else if (session.getAttribute("err") != null) {
            request.setAttribute("err", session.getAttribute("err"));
            session.removeAttribute("err");
        }

        request.setAttribute("list", list);
        request.setAttribute("roleList", getRoleList());
        request.setAttribute("keyWord", keyWord);
        request.setAttribute("sortOptions", allSortOptions());
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("noOfPages", noOfPages);
        request.getRequestDispatcher("/WEB-INF/views/user/userlist.jsp").forward(request, response);
    }

    private void changeUserStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        int userId = Integer.parseInt(request.getParameter("userId"));
        String action;
        User user = userDAO.getUserById(userId);
        if (user.getStatus() == 0) {
            action = "Activated";
        } else {
            action = "Deactivated";
        }
        try {
            userDAO.changeUserStatus(userId);
            session.setAttribute("successful", action + " account "
                    + user.getEmail() + " successfully!");
        } catch (SQLException e) {
            session.setAttribute("err", action + " account "
                    + user.getEmail() + " failed!");
        }
        response.sendRedirect("../user");
    }

    private void saveChanges(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean successful = true;
        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = userDAO.getUserById(userId);
        String name = StringFormatter.removeDoubleSpaces(request.getParameter("name").trim());
        if (name == null || name.isEmpty()) {
            request.setAttribute("nameErr", "Name is blank!");
            successful = false;
        } else {
            if (name.length() > 50) {
                successful = false;
                request.setAttribute("nameErr", "Name can not exceed 50 characters!");
            }
        }
        Part filePart = request.getPart("newAvatar");
        if (filePart != null && filePart.getSize() != 0) {
            String workingDir = getWorkingDir();
            String workingFolder = "assets\\img";
            try {
                avatarHandler.changeAvatar(userId, workingFolder, workingDir, filePart);
            } catch (SQLException | IOException e) {
                successful = false;
                request.setAttribute("avtErr", "Upload image failed!");
            }
        }

        user.setName(name);
        user.setRole(Integer.parseInt(request.getParameter("roleId")));
        if (successful) {
            try {
                userDAO.updateUser(user);
            } catch (SQLException e) {
                request.setAttribute("updateErr", "Update failed! Please try again later!");
                successful = false;
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("successful", "Updated account " + user.getEmail() + " successfully!");
            response.sendRedirect("../user");
        } else {
            request.setAttribute("user", user);
            request.setAttribute("roleList", getRoleList());
            request.getRequestDispatcher("/WEB-INF/views/user/userdetails.jsp").forward(request, response);
        }
    }

    private void assignSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean successful = true;
        int userId = Integer.parseInt(request.getParameter("userId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));

        try {
            userDAO.assignSubject(userId, subjectId);
        } catch (SQLException e) {
            successful = false;
            request.setAttribute("err", "Assign subject failed!");
        }

        if (successful) {
            String contextPath = request.getServletContext().getContextPath();
            String redirectPage = contextPath + "/user/details";
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("currentPage", "assignSubject");
            session.setAttribute("successful", "Assign subject "
                    + subjectDAO.getSubjectMatchId(subjectId).getCode()
                    + " successfully!");
            response.sendRedirect(redirectPage);
        } else {
            request.setAttribute("user", userDAO.getUserById(userId));
            request.setAttribute("roleList", getRoleList());
            ArrayList<Subject> subjectList = userDAO.getAllSubjectsInCharged(userId);
            request.setAttribute("subjectList", subjectList);
            request.setAttribute("unassignedSubjectList", getAllSubjectsNotInCharged(subjectList));
            request.setAttribute("currentPage", "assignSubject");
            request.getRequestDispatcher("/WEB-INF/views/user/userdetails.jsp").forward(request, response);
        }
    }

    private void removeSubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean successful = true;
        int userId = Integer.parseInt(request.getParameter("userId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));

        try {
            userDAO.removeAssignedSubject(userId, subjectId);
        } catch (SQLException e) {
            successful = false;
            request.setAttribute("err", "Remove subject failed!");
        }

        if (successful) {
            String contextPath = request.getServletContext().getContextPath();
            String redirectPage = contextPath + "/user/details";
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("currentPage", "assignSubject");
            session.setAttribute("successful", "Deleted subject "
                    + subjectDAO.getSubjectMatchId(subjectId).getCode()
                    + " successfully!");
            response.sendRedirect(redirectPage);
        } else {
            request.setAttribute("user", userDAO.getUserById(userId));
            request.setAttribute("roleList", getRoleList());
            ArrayList<Subject> subjectList = userDAO.getAllSubjectsInCharged(userId);
            request.setAttribute("subjectList", subjectList);
            request.setAttribute("unassignedSubjectList", getAllSubjectsNotInCharged(subjectList));
            request.setAttribute("currentPage", "assignSubject");
            request.getRequestDispatcher("/WEB-INF/views/user/userdetails.jsp").forward(request, response);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        switch (request.getParameter("action")) {
            case "changeStatus":
                changeUserStatus(request, response);
                break;
            case "saveChanges":
                saveChanges(request, response);
                break;
            case "assignSubject":
                assignSubject(request, response);
                break;
            case "removeSubject":
                removeSubject(request, response);
                break;
        }
    }

    private boolean isSubjectAssigned(ArrayList<Subject> subjectList, Subject s) {
        for (Subject subject : subjectList) {
            if (subject.getId() == s.getId()) {
                return true;
            }
        }
        return false;
    }

    private ArrayList<Subject> getAllSubjectsNotInCharged(ArrayList<Subject> subjectList) {
        SubjectDAO subjectDAO = new SubjectDAO();
        ArrayList<Subject> allSubject = subjectDAO.getAllSubject();
        ArrayList<Subject> ret = new ArrayList<>();
        for (Subject s : allSubject) {
            if (!isSubjectAssigned(subjectList, s)) {
                ret.add(s);
            }
        }
        return ret;
    }

    private void viewUserDetails(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int userId;
        HttpSession session = request.getSession();
        if (session.getAttribute("userId") != null) {
            userId = (int) session.getAttribute("userId");
            session.removeAttribute("userId");
        } else {
            userId = Integer.parseInt(request.getParameter("userId"));
        }
        User user = userDAO.getUserById(userId);

        request.setAttribute("successful", session.getAttribute("successful"));
        session.removeAttribute("successful");

        request.setAttribute("currentPage", session.getAttribute("currentPage"));
        session.removeAttribute("currentPage");

        request.setAttribute("user", user);
        request.setAttribute("roleList", getRoleList());

        if (user.getRole() < 3) {
            ArrayList<Subject> subjectList = userDAO.getAllSubjectsInCharged(userId);
            request.setAttribute("subjectList", subjectList);
            request.setAttribute("unassignedSubjectList", getAllSubjectsNotInCharged(subjectList));
        }

        request.getRequestDispatcher("/WEB-INF/views/user/userdetails.jsp").forward(request, response);
    }

    private void goToPage(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setAttribute("roleList", getRoleList());
        request.getRequestDispatcher("/WEB-INF/views/user/newuser.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        boolean successful = true;
        User user = new User();
        String name = StringFormatter.removeDoubleSpaces(request.getParameter("name").trim());
        if (name == null || name.isEmpty()) {
            request.setAttribute("nameErr", "Name is blank!");
            successful = false;
        } else {
            if (name.length() > 50) {
                successful = false;
                request.setAttribute("nameErr", "Name can not exceed 50 characters!");
            }
        }
        user.setName(name);
        user.setRole(Integer.parseInt(request.getParameter("roleId")));
        String avt = request.getParameter("avt");
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            if (avt == null || avt.isEmpty()) {
                user.setAvatar("assets/img/default_avt.jpg");
            } else {
                user.setAvatar(avt);
            }
        } else {
            String workingDir = getWorkingDir();
            String workingFolder = "assets\\img";
            user.setAvatar(avatarHandler.uploadAvatar(workingFolder, workingDir, filePart, avt));
        }
        String email = request.getParameter("email").trim();
        user.setEmail(email);
        if (email == null || email.isEmpty()) {
            successful = false;
            request.setAttribute("emailErr", "Email is blank!");
        } else {
            if (email.length() > 35) {
                successful = false;
                request.setAttribute("emailErr", "Email can not exceed 35 characters!");
            } else {
                if (!EmailValidator.validate(email)) {
                    successful = false;
                    request.setAttribute("emailErr", "Please enter a valid email!");
                } else {
                    if (userDAO.checkEmailExist(email)) {
                        successful = false;
                        request.setAttribute("emailErr", "Email has already been registered, please head to login!");
                    } else {
                        try {
                            user.setStatus(2);
                            String password = PasswordGenerator.generateRandomPassword();
                            userDAO.addUser(user, password);
                            String receiver = user.getEmail();
                            String subject = "Password for Knowledge Revising System";
                            String content = "Hi, you have been invited to join our Knowledge Revising System website \n\n";
                            content += "Please login by your email with password " + password + " to access our system.";
                            SendMail.sendMail(receiver, subject, content);
                        } catch (SQLException e) {
                            successful = false;
                            request.setAttribute("err", "Failed to add user, please try again later!");
                        }
                    }
                }
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("successful", "Added account " + email + " successfully!");
            response.sendRedirect("../user");
        } else {
            request.setAttribute("user", user);
            request.setAttribute("roleList", getRoleList());
            request.getRequestDispatcher("/WEB-INF/views/user/newuser.jsp").forward(request, response);
        }
    }

    private void newUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (request.getParameter("action")) {
                case "addUser":
                    addUser(request, response);
                    break;
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
