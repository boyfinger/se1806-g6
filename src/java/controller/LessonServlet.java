package controller;

import common.MaterialHandler;
import common.StringFormatter;
import dal.LessonDAO;
import dal.MaterialDAO;
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
import model.Lesson;
import model.User;
import model.subject.Subject;

@MultipartConfig
@WebServlet(urlPatterns = {"/lesson", "/lesson/new", "/lesson/insert", "/lesson/details", "/lesson/update"})
public class LessonServlet extends HttpServlet {

    private final int rowPerPage = 6;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LessonListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LessonListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    private String getWorkingDir() {
        String directory = getServletContext().getRealPath("") + "";
        return directory.replace("\\build\\web\\", "\\web\\");
    }

    LessonDAO lessonDAO = new LessonDAO();
    SubjectDAO subjectDAO = new SubjectDAO();
    MaterialDAO materialDAO = new MaterialDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String contextPath = request.getServletContext().getContextPath();
        String loginPage = contextPath + "/login.jsp";
        String homePage = contextPath + "/home";
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(loginPage);
        } else {
            User u = userDAO.getUserById(user.getId());
            if (u != null && u.getEmail() != null) {
                session.setAttribute("user", u);
                if (user.getRole() > 1) {
                    response.sendRedirect(homePage);
                } else {
                    String action = request.getServletPath();
                    switch (action) {
                        case "/lesson":
                            viewLessonList(request, response);
                            break;
                        case "/lesson/new":
                            newLesson(request, response);
                            break;
                        case "/lesson/insert":
                            insertNewLesson(request, response);
                            break;
                        case "/lesson/details":
                            viewLessonDetails(request, response);
                            break;
                        case "/lesson/update":
                            updateLesson(request, response);
                            break;
                    }
                }
            } else {
                response.sendRedirect(loginPage);
            }
        }

    }

    private ArrayList<Lesson> getAllLessonsOfSubject(ArrayList<Lesson> lessonList, int subjectId) {
        ArrayList<Lesson> ret = new ArrayList<>();
        for (Lesson lesson : lessonList) {
            if (lesson.getSubjectId() == subjectId) {
                ret.add(lesson);
            }
        }
        return ret;
    }

    private ArrayList<Lesson> getAllLessonsMatchKeyWord(ArrayList<Lesson> lessonList, String keyWord) {
        keyWord = keyWord.toLowerCase();
        ArrayList<Lesson> ret = new ArrayList<>();
        for (Lesson lesson : lessonList) {
            if (lesson.getName().toLowerCase().contains(keyWord)) {
                ret.add(lesson);
            }
        }
        return ret;
    }

    private int getNoOfPages(ArrayList<Lesson> list) {
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

    private ArrayList<Lesson> getAllLessonsOfPage(int page, ArrayList<Lesson> list) {
        ArrayList<Lesson> ret = new ArrayList<>();
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

    private ArrayList<String> getSortOptions() {
        ArrayList<String> ret = new ArrayList<>();
        ret.add("Order");
        ret.add("Name");
        ret.add("Status");
        return ret;
    }

    private void viewLessonList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Lesson> lessonList = lessonDAO.getAllLessons();

        int subjectId;
        HttpSession session = request.getSession();
        if (session.getAttribute("subjectId") != null) {
            subjectId = (int) session.getAttribute("subjectId");
            session.removeAttribute("subjectId");
        } else {
            String sid = request.getParameter("subjectId");
            if (sid != null && !sid.isEmpty() && !sid.equals("all")) {
                subjectId = Integer.parseInt(sid);
            } else {
                subjectId = subjectDAO.getAllSubject().get(0).getId();
            }
        }
        request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
        lessonList = getAllLessonsOfSubject(lessonList, subjectId);

        String sortBy = request.getParameter("sortBy");
        if (sortBy != null) {
            switch (sortBy) {
                case "Name":
                    Collections.sort(lessonList, new Lesson.SortByName());
                    break;
                case "Status":
                    Collections.sort(lessonList, new Lesson.SortByStatus());
                    break;
                default:
                    Collections.sort(lessonList, new Lesson.SortByOrder());
                    break;
            }
        } else {
            Collections.sort(lessonList, new Lesson.SortByOrder());
            sortBy = "Order";
        }
        request.setAttribute("sortBy", sortBy);

        String keyWord = request.getParameter("keyWord");
        if (keyWord != null && !keyWord.isEmpty()) {
            lessonList = getAllLessonsMatchKeyWord(lessonList, keyWord);
        }
        request.setAttribute("keyWord", keyWord);

        int noOfPages = getNoOfPages(lessonList);
        int currentPage = getPage(request, noOfPages);
        lessonList = getAllLessonsOfPage(currentPage, lessonList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("noOfPages", noOfPages);

        request.setAttribute("successful", session.getAttribute("successful"));
        session.removeAttribute("successful");

        request.setAttribute("err", session.getAttribute("err"));
        session.removeAttribute("err");

        request.setAttribute("latestOrder", lessonDAO.getLatestOrder(subjectId));
        request.setAttribute("subjectList", subjectDAO.getAllSubject());
        request.setAttribute("sortOptions", getSortOptions());
        request.setAttribute("list", lessonList);
        request.getRequestDispatcher("/WEB-INF/views/lesson/lessonlist.jsp").forward(request, response);
    }

    private void goToPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("subjectList", subjectDAO.getAllSubject());
        request.setAttribute("subject",
                subjectDAO.getSubjectMatchId(Integer.parseInt(request.getParameter("subjectId"))));
        request.getRequestDispatcher("/WEB-INF/views/lesson/newlesson.jsp").forward(request, response);
    }

    private void newLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (request.getParameter("action")) {
                case "addNew":
                    insertNewLesson(request, response);
                    break;
                default:
                    goToPage(request, response);
                    break;
            }
        } else {
            goToPage(request, response);
        }
    }

    private void insertNewLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        name = StringFormatter.removeDoubleSpaces(name.trim());
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        boolean successful = true;

        if (name.isEmpty()) {
            successful = false;
            request.setAttribute("err", "Input is empty!");
        } else if (name.length() > 100) {
            successful = false;
            request.setAttribute("err", "Lesson name can not exceed 100 characters!");
        }

        if (successful) {
            if (lessonDAO.isLessonExist(name, subjectId)) {
                successful = false;
                request.setAttribute("err", "Lesson name already exist!");
            } else {
                try {
                    lessonDAO.addLesson(name, subjectId);
                } catch (SQLException e) {
                    successful = false;
                    request.setAttribute("err", "Adding lesson failed!");
                }
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("subjectId", subjectId);
            session.setAttribute("successful", "Added lesson " + name + " successfully!");
            response.sendRedirect("../lesson");
        } else {
            request.setAttribute("name", name);
            request.setAttribute("subjectList", subjectDAO.getAllSubject());
            request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
            request.getRequestDispatcher("/WEB-INF/views/lesson/newlesson.jsp").forward(request, response);
        }

    }

    private void viewLessonDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int lessonId;
        HttpSession session = request.getSession();

        if (session.getAttribute("lessonId") != null) {
            lessonId = (int) session.getAttribute("lessonId");
            session.removeAttribute("lessonId");
        } else {
            lessonId = Integer.parseInt(request.getParameter("lessonId"));
        }
        request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));

        request.setAttribute("fileSuccessful", session.getAttribute("fileSuccessful"));
        session.removeAttribute("fileSuccessful");

        request.setAttribute("currentPage", session.getAttribute("currentPage"));
        session.removeAttribute("currentPage");
        request.setAttribute("materialList", materialDAO.getAllMaterialOfALesson(lessonId));
        request.getRequestDispatcher("/WEB-INF/views/lesson/lessondetails.jsp").forward(request, response);
    }

    private void changeLessonStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        Lesson lesson = lessonDAO.getLessonMatchId(lessonId);
        String action;
        if (lesson.isStatus()) {
            action = "Deactivated";
        } else {
            action = "Activated";
        }
        try {
            lessonDAO.changeStatus(lessonId);
            session.setAttribute("successful", action + " lesson " + lesson.getName() + " successfully!");
        } catch (SQLException e) {
            session.setAttribute("err", action + " lesson " + lesson.getName() + " failed!");
        }
        response.sendRedirect("../lesson");
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean successful = true;
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        Lesson lesson = lessonDAO.getLessonMatchId(lessonId);
        String name = request.getParameter("name");
        name = StringFormatter.removeDoubleSpaces(name.trim());
        if (!name.equals(lesson.getName())) {
            lesson.setName(name);
            if (name.isEmpty()) {
                successful = false;
                request.setAttribute("err", "Input is empty!");
            } else if (name.length() > 100) {
                successful = false;
                request.setAttribute("err", "Lesson name can not exceed 100 characters!");
            }

            if (successful) {
                if (lessonDAO.isLessonExist(name, lesson.getSubjectId())) {
                    successful = false;
                    request.setAttribute("err", "Lesson name already exist!");
                } else {
                    try {
                        lessonDAO.updateLesson(lesson);
                    } catch (SQLException e) {
                        successful = false;
                        request.setAttribute("err", "Update lesson failed!");
                    }
                }
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("successful", "Updated lesson successfully!");
            response.sendRedirect("../lesson");
        } else {
            request.setAttribute("lesson", lesson);
            request.getRequestDispatcher("/WEB-INF/views/lesson/lessondetails.jsp").forward(request, response);
        }
    }

    private void changeOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        String action = request.getParameter("orderAction");
        try {
            lessonDAO.changeOrder(lessonId, action);
            session.setAttribute("successful", "Move lesson "
                    + lessonDAO.getLessonMatchId(lessonId).getName()
                    + " " + action + " successfully!");
        } catch (SQLException e) {
            session.setAttribute("err", "Move lesson "
                    + lessonDAO.getLessonMatchId(lessonId).getName()
                    + " " + action + " failed!");
        }

        session.setAttribute("subjectId",
                lessonDAO.getLessonMatchId(lessonId).getSubjectId());
        response.sendRedirect("../lesson");
    }

    private void insertMaterial(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        boolean successful = true;
        Part filePart = request.getPart("file");
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));

        if (filePart == null || filePart.getSize() == 0) {
            successful = false;
            request.setAttribute("fileErr", "Please choose a file");
        } else {
            String workingDir = getWorkingDir();
            String workingFolder = "assets\\material";
            try {
                MaterialHandler.addMaterial(lessonId, workingFolder, workingDir, filePart);
            } catch (SQLException | IOException e) {
                successful = false;
                request.setAttribute("fileErr", "Import material failed");
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("lessonId", lessonId);
            session.setAttribute("currentPage", "material");
            session.setAttribute("fileSuccessful", "Added material successfully!");
            String contextPath = request.getServletContext().getContextPath();
            String detailsPage = contextPath + "/lesson/details";
            response.sendRedirect(detailsPage);
        } else {
            request.setAttribute("currentPage", "material");
            request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
            request.getRequestDispatcher("/WEB-INF/views/lesson/lessondetails.jsp").forward(request, response);
        }
    }

    private void removeMaterial(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        boolean successful = true;
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        int materialId = Integer.parseInt(request.getParameter("materialId"));
        String workingDir = getWorkingDir();

        try {
            MaterialHandler.removeMaterial(lessonId, materialId, workingDir);
        } catch (SQLException e) {
            successful = false;
            request.setAttribute("fileErr", "Delete file failed!");
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("lessonId", lessonId);
            session.setAttribute("currentPage", "material");
            session.setAttribute("fileSuccessful", "Remove material successfully!");
            String contextPath = request.getServletContext().getContextPath();
            String detailsPage = contextPath + "/lesson/details";
            response.sendRedirect(detailsPage);
        } else {
            request.setAttribute("currentPage", "material");
            request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
            request.getRequestDispatcher("/WEB-INF/views/lesson/lessondetails.jsp").forward(request, response);
        }
    }

    private void updateLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("action")) {
            case "changeStatus":
                changeLessonStatus(request, response);
                break;
            case "changeOrder":
                changeOrder(request, response);
                break;
            case "updateLesson":
                update(request, response);
                break;
            case "insertMaterial":
                insertMaterial(request, response);
                break;
            case "removeMaterial":
                removeMaterial(request, response);
                break;
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
