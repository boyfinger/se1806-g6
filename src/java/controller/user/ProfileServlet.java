package controller.user;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.User;
import model.course.Course;
import model.course.CourseStudentCount;
import model.flashcard.Flashcard;
import dal.ProfileDAO;
import model.subject.Subject;

import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/profile/info", "/profile/update", "/profile/userFlashcard", "/profile/userCourse", "/profile/change-password", "/profile/edit"})
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String action = request.getServletPath();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        ProfileDAO profileDAO = new ProfileDAO();
        updateSessionAttributes(session, profileDAO, user);

        switch (action) {
            case "/profile":
                showProfile(request, response);
                break;
            case "/profile/info":
                showInfo(request, response);
                break;
            case "/profile/change-password":
                changePassword(request, response);
                break;
            case "/profile/edit":
                editProfile(request, response);
                break;
            case "/profile/update":
                updateProfile(request, response);
                break;
            case "/profile/userFlashcard":
                showFlashcards(request, response);
                break;
            case "/profile/userCourse":
                showCourse(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void updateSessionAttributes(HttpSession session, ProfileDAO profileDAO, User user) throws SQLException {
        ArrayList<Flashcard> flashcards = profileDAO.getFlashcardsByUserId(user.getId());
        ArrayList<Subject> subjects = profileDAO.getAllSubjects();
        List<Course> myCourses = profileDAO.myCourses(user.getId());
        List<CourseStudentCount> courseStudentCounts = new ArrayList<>();

        for (Course course : myCourses) {
            CourseStudentCount courseStudentCount = profileDAO.getStudentsByGroupId(course.getId());
            courseStudentCounts.add(courseStudentCount);
        }

        for (Flashcard flashcard : flashcards) {
            int numQuestions = profileDAO.getNumQuestions(flashcard.getFlashcardSetId());
            String subjectName = profileDAO.getSubjectName(flashcard.getSubjectId());
            String subjectCode = profileDAO.getSubjectCode(flashcard.getSubjectId());
            flashcard.setSubjectCode(subjectCode);
            flashcard.setSubjectName(subjectName);
            flashcard.setNumQuestions(numQuestions);
        }

        session.setAttribute("myCourses", myCourses);
        session.setAttribute("courseStudentCounts", courseStudentCounts);
        session.setAttribute("subjects", subjects);
        session.setAttribute("userFlashcards", flashcards);
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/dashboard-user.jsp");
        rd.forward(request, response);
    }

    private void showInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/profile.jsp");
        rd.forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/change-password.jsp");
        rd.forward(request, response);
    }

    private void editProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/edit-profile.jsp");
        rd.forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String name = request.getParameter("name");
        Part filePart = request.getPart("avatar");

        user.setName(name);

        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            if (contentType.startsWith("image/")) {
                String userId = String.valueOf(user.getId());
                String uploadDir = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img" + File.separator + userId;
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                File[] oldFiles = uploadDirFile.listFiles();
                if (oldFiles != null) {
                    for (File file : oldFiles) {
                        file.delete();
                    }
                }

                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                File file = new File(uploadDirFile, fileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }

                String newAvatarPath = "assets/img/" + userId + "/" + fileName;
                user.setAvatar(newAvatarPath);
            } else {
                request.setAttribute("errorMessage", "Invalid file type. Only images are allowed.");
                RequestDispatcher rd = request.getRequestDispatcher("/edit-profile.jsp");
                rd.forward(request, response);
                return;
            }
        }

        try {
            ProfileDAO profileDAO = new ProfileDAO();
            profileDAO.updateUserProfile(user);
            session.setAttribute("user", user);
        } catch (SQLException e) {
            throw new ServletException("Database error while updating profile", e);
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }

    private void showFlashcards(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/userFlashcard.jsp");
        rd.forward(request, response);
    }

    private void showCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/userCourse.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    public String getServletInfo() {
        return "ProfileServlet handles user profile related actions.";
    }
}