package controller;

import model.Question;
import model.Answer;
import common.ReadQuestionFromXlsFile;
import common.StringFormatter;
import dal.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.net.Authenticator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import model.Lesson;
import model.User;
import model.subject.Subject;

@MultipartConfig
@WebServlet(name = "QuestionServlet", urlPatterns = {"/question", "/question/details", "/question/update", "/question/new"})
public class QuestionServlet extends HttpServlet {

    ArrayList<Answer> answerList;
    int lastAnswerId;
    private final int rowPerPage = 6;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuestionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuestionServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    QuestionDAO questionDAO = new QuestionDAO();
    AnswerDAO answerDAO = new AnswerDAO();
    LessonDAO lessonDAO = new LessonDAO();
    SubjectDAO subjectDAO = new SubjectDAO();
    ReadQuestionFromXlsFile reader = new ReadQuestionFromXlsFile();

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
                        case "/question":
                            viewQuestionList(request, response);
                            break;
                        case "/question/details":
                            viewQuestionDetails(request, response);
                            break;
                        case "/question/update":
                            updateQuestion(request, response);
                            break;
                        case "/question/new":
                            newQuestion(request, response);
                            break;
                    }
                }
            } else {
                response.sendRedirect(loginPage);
            }
        }
    }

    private ArrayList<Question> getAllMatchKeyWord(ArrayList<Question> list, String keyWord) {
        ArrayList<Question> ret = new ArrayList<>();
        keyWord = keyWord.toLowerCase();
        for (Question q : list) {
            if (q.getContent().toLowerCase().contains(keyWord)) {
                ret.add(q);
            }
        }
        return ret;
    }

    private int getNoOfPages(ArrayList<Question> list) {
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

    private ArrayList<Question> getAllQuestionsOfPage(int page, ArrayList<Question> list) {
        ArrayList<Question> ret = new ArrayList<>();
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

    private ArrayList<String> getAllSortOptions() {
        ArrayList<String> ret = new ArrayList<>();
        ret.add("None");
        ret.add("Content");
        ret.add("Subject");
        ret.add("Lesson");
        ret.add("Status");
        return ret;
    }

    private ArrayList<Question> getQuestionsListOfLesson(HttpServletRequest request) {
        ArrayList<Question> list;
        String sid = request.getParameter("subjectId");
        String lid = request.getParameter("lessonId");
        String change = request.getParameter("change");
        System.out.println("'" + change + "'");
        if (change == null || change.isEmpty()) {
            int subjectId = 0;
            if ((sid != null) && (!sid.equals("All subjects")) && (!sid.isEmpty())) {
                subjectId = Integer.parseInt(sid);
                request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
            } else {
                request.setAttribute("lessonList", lessonDAO.getAllLessons());
            }
            if ((lid != null) && (!lid.equals("All lessons")) && (!lid.isEmpty())) {
                int lessonId = Integer.parseInt(lid);
                request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
                list = questionDAO.getAllQuestionsOfALesson(lessonId);
            } else if (subjectId != 0) {
                list = questionDAO.getAllQuestionsOfASubject(subjectId);
            } else {
                list = questionDAO.getAllQuestions();
            }
        } else if (change.equals("subject")) {
            if ((sid != null) && (!sid.equals("All subjects")) && (!sid.isEmpty())) {
                int subjectId = Integer.parseInt(sid);
                request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
                list = questionDAO.getAllQuestionsOfASubject(subjectId);
            } else {
                request.setAttribute("lessonList", lessonDAO.getAllLessons());
                list = questionDAO.getAllQuestions();
            }
        } else {
            if ((lid != null) && (!lid.equals("All lessons")) && (!lid.isEmpty())) {
                int lessonId = Integer.parseInt(lid);
                Lesson lesson = lessonDAO.getLessonMatchId(lessonId);
                System.out.println(lesson.getSubjectId());
                Subject subject = subjectDAO.getSubjectMatchId(lesson.getSubjectId());
                request.setAttribute("lesson", lesson);
                request.setAttribute("subject", subject);
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subject.getId()));
                list = questionDAO.getAllQuestionsOfALesson(lessonId);
            } else {
                if ((sid != null) && (!sid.equals("All subjects")) && (!sid.isEmpty())) {
                    int subjectId = Integer.parseInt(sid);
                    request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
                    request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
                    list = questionDAO.getAllQuestionsOfASubject(subjectId);
                } else {
                    request.setAttribute("lessonList", lessonDAO.getAllLessons());
                    list = questionDAO.getAllQuestions();
                }
            }
        }
        return list;
    }

    private void viewQuestionList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Question> list = getQuestionsListOfLesson(request);

        String keyWord = request.getParameter("keyword");
        if (keyWord != null) {
            list = getAllMatchKeyWord(list, keyWord);
        }

        String sortBy = request.getParameter("sortBy");
        if (sortBy != null) {
            switch (sortBy) {
                case "Content":
                    Collections.sort(list, new Question.SortByContent());
                    break;
                case "Subject":
                    Collections.sort(list, new Question.SortBySubject());
                    break;
                case "Lesson":
                    Collections.sort(list, new Question.SortByLesson());
                    break;
                case "Status":
                    Collections.sort(list, new Question.SortByStatus());
                    break;
                default:
                    break;
            }
        }

        int noOfPages = getNoOfPages(list);
        int currentPage = getPage(request, noOfPages);
        list = getAllQuestionsOfPage(currentPage, list);

        HttpSession session = request.getSession();
        request.setAttribute("successful", session.getAttribute("successful"));
        session.removeAttribute("successful");
        request.setAttribute("err", session.getAttribute("err"));
        session.removeAttribute("err");

        request.setAttribute("sortOptions", getAllSortOptions());
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("list", list);
        request.setAttribute("keyword", keyWord);
        request.setAttribute("subjectList", subjectDAO.getAllSubject());
        request.getRequestDispatcher("/WEB-INF/views/question/questionlist.jsp").forward(request, response);
    }

    private void viewQuestionDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        Question question = questionDAO.getQuestionMatchId(questionId);
        if (question == null) {
            response.sendRedirect("../question");
        } else {
            ArrayList<Answer> answer = answerDAO.getAllAnswersOfAQuestion(questionId);
            int id = 0;
            answerList = new ArrayList<>();
            for (Answer a : answer) {
                id++;
                answerList.add(new Answer(id, a.getContent(), a.isIsCorrect(), question));
            }
            lastAnswerId = id;
            request.setAttribute("question", question);
            request.setAttribute("answerList", answerList);
            request.getRequestDispatcher("/WEB-INF/views/question/questiondetails.jsp").forward(request, response);
        }
    }

    private void updateAnswer(HttpServletRequest request, HttpServletResponse response, Question question)
            throws IOException, ServletException {
        boolean successful = true;
        String content = request.getParameter("question").trim();
        Question q = new Question(question.getId(), content, question.getLesson(), question.isStatus());
        if (q.getContent().isEmpty() || q.getContent().length() > 255) {
            successful = false;
            request.setAttribute("questionErr", "Question is empty!");
        }

        getAnswerListInfo(request);

        int nonEmptyAnswers = 0;
        int checked = 0;
        for (Answer a : answerList) {
            String answerContent = a.getContent().trim();
            a.setContent(answerContent);
            if (!a.getContent().isEmpty()) {
                nonEmptyAnswers++;
                if (a.getContent().length() > 255) {
                    successful = false;
                    request.setAttribute("answerErr", "Please enter answer within 255 characters!");
                    break;
                } else {
                    if (a.isIsCorrect()) {
                        checked++;
                    }
                }
            }
        }

        if (nonEmptyAnswers < 2) {
            successful = false;
            request.setAttribute("answerErr", "Please enter at least 2 answers!");
        } else if (checkDuplicateAnswer()) {
            successful = false;
            request.setAttribute("answerErr", "Please enter different answers!");
        } else if (checked == 0) {
            successful = false;
            request.setAttribute("answerErr", "Please select at least one correct answer!");
        }

        if (successful) {
            Question q1 = questionDAO.getQuestionByContent(q);
            if (q1 == null || q.getId() == q1.getId()) {
                try {
                    questionDAO.updateQuestion(q);
                    answerDAO.deleteAllAnswersOfAQuestion(q.getId());
                    for (Answer a : getNonEmptyAnswerList()) {
                        String answerContent = a.getContent().trim();
                        a.setContent(answerContent);
                        a.setQuestion(q);
                        answerDAO.insertAnswer(a);
                    }
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                    successful = false;
                    request.setAttribute("questionErr", "Update question failed!");
                }
            } else {
                successful = false;
                request.setAttribute("questionErr", "Question already exist in subject!");
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("successful", "Updated question successfully!");
            response.sendRedirect("../question");
        } else {
            request.setAttribute("question", q);
            request.setAttribute("answerList", answerList);
            request.getRequestDispatcher("/WEB-INF/views/question/questiondetails.jsp").forward(request, response);
        }
    }

    private void changeQuestionStatus(Question question, HttpServletResponse response, HttpServletRequest request)
            throws IOException {
        HttpSession session = request.getSession();
        String action;
        if (question.isStatus()) {
            action = "Deactivated";
        } else {
            action = "Activated";
        }
        try {
            questionDAO.changeQuestionStatus(question);
            session.setAttribute("successful", action + " question successfully!");
        } catch (SQLException e) {
            session.setAttribute("err", action + " question failed!");
        }
        response.sendRedirect("../question");
    }

    private void update_deleteAnswer(HttpServletRequest request, HttpServletResponse response, Question question)
            throws ServletException, IOException {
        String content = request.getParameter("question");
        Question q = new Question(question.getId(), content, question.getLesson(), question.isStatus());
        request.setAttribute("question", q);

        getAnswerListInfo(request);
        int deletedId = Integer.parseInt(request.getParameter("deletedId"));
        answerList.remove(getIndexById(deletedId));
        request.setAttribute("answerList", answerList);

        request.getRequestDispatcher("/WEB-INF/views/question/questiondetails.jsp").forward(request, response);
    }

    private void update_addAnswer(HttpServletRequest request, HttpServletResponse response, Question question)
            throws ServletException, IOException {
        Question q = new Question();
        q.setId(question.getId());
        q.setLesson(question.getLesson());
        q.setStatus(question.isStatus());
        q.setContent(request.getParameter("question"));
        request.setAttribute("question", q);

        getAnswerListInfo(request);

        lastAnswerId++;
        Answer a = new Answer();
        a.setId(lastAnswerId);
        a.setIsCorrect(false);
        answerList.add(a);
        request.setAttribute("answerList", answerList);
        request.getRequestDispatcher("/WEB-INF/views/question/questiondetails.jsp").forward(request, response);
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        System.out.println(questionId);
        Question question = questionDAO.getQuestionMatchId(questionId);
        if (question == null) {
            response.sendRedirect("../question");
        } else {
            switch (request.getParameter("action")) {
                case "changeStatus":
                    changeQuestionStatus(question, response, request);
                    break;
                case "deleteAnswer":
                    update_deleteAnswer(request, response, question);
                    break;
                case "addAnswer":
                    update_addAnswer(request, response, question);
                    break;
                default:
                    updateAnswer(request, response, question);
                    break;
            }

        }
    }

    private void newQuestionForm(HttpServletRequest request, HttpServletResponse response,
            int subjectId, int lessonId) throws IOException, ServletException {
        answerList = new ArrayList<>();
        Answer a = new Answer();
        a.setIsCorrect(false);
        a.setId(1);
        answerList.add(a);

        Answer a1 = new Answer();
        a1.setIsCorrect(false);
        a1.setId(2);
        answerList.add(a1);

        lastAnswerId = 2;

        if (subjectId != 0) {
            request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
            request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
        } else {
            request.setAttribute("lessonList", lessonDAO.getAllLessons());
        }
        if (lessonId != 0) {
            request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
        }

        request.setAttribute("subjectList", subjectDAO.getAllSubject());
        request.setAttribute("answerList", answerList);
        request.getRequestDispatcher("/WEB-INF/views/question/newquestion.jsp").forward(request, response);
    }

    private void getAnswerListInfo(HttpServletRequest request) {
        for (Answer a : answerList) {
            int id = a.getId();
            a.setContent(request.getParameter(String.valueOf(id)));
            if (request.getParameter(id + "isCorrect") != null) {
                a.setIsCorrect(true);
            } else {
                a.setIsCorrect(false);
            }
        }
    }

    private void changeSubjectAndLesson(HttpServletRequest request, HttpServletResponse response,
            int subjectId, int lessonId)
            throws ServletException, IOException {
        if (request.getParameter("change").equals("subject")) {
            if (subjectId == 0) {
                request.setAttribute("lessonList", lessonDAO.getAllLessons());
            } else {
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
            }
        } else {
            if (lessonId == 0) {
                if (subjectId == 0) {
                    request.setAttribute("lessonList", lessonDAO.getAllLessons());
                } else {
                    request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
                }
            } else {
                Lesson lesson = lessonDAO.getLessonMatchId(lessonId);
                Subject subject = subjectDAO.getSubjectMatchId(lesson.getSubjectId());
                request.setAttribute("subject", subject);
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subject.getId()));
            }
        }

        if (subjectId != 0) {
            request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
        }
        if (lessonId != 0) {
            request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
        }

        request.setAttribute("subjectList", subjectDAO.getAllSubject());

        getAnswerListInfo(request);
        request.setAttribute("answerList", answerList);
        Question q = new Question();
        q.setContent(request.getParameter("question"));
        request.setAttribute("question", q);
        request.getRequestDispatcher("/WEB-INF/views/question/newquestion.jsp").forward(request, response);
    }

    private void addAnswer(HttpServletRequest request, HttpServletResponse response,
            int subjectId, int lessonId) throws ServletException, IOException {
        if (subjectId != 0) {
            request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
            request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
        } else {
            request.setAttribute("lessonList", lessonDAO.getAllLessons());
        }
        if (lessonId != 0) {
            request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
        }
        request.setAttribute("subjectList", subjectDAO.getAllSubject());

        getAnswerListInfo(request);
        lastAnswerId++;
        Answer a = new Answer();
        a.setId(lastAnswerId);
        a.setIsCorrect(false);
        answerList.add(a);
        request.setAttribute("answerList", answerList);

        Question q = new Question();
        q.setContent(request.getParameter("question"));
        request.setAttribute("question", q);
        request.getRequestDispatcher("/WEB-INF/views/question/newquestion.jsp").forward(request, response);
    }

    private int getIndexById(int id) {
        int index = 0;
        for (Answer a : answerList) {
            if (a.getId() == id) {
                return index;
            }
            index++;
        }
        return index;
    }

    private void deleteAnswer(HttpServletRequest request, HttpServletResponse response,
            int subjectId, int lessonId) throws ServletException, IOException {
        if (subjectId != 0) {
            request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
            request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
        } else {
            request.setAttribute("lessonList", lessonDAO.getAllLessons());
        }
        if (lessonId != 0) {
            request.setAttribute("lesson", lessonDAO.getLessonMatchId(lessonId));
        }
        request.setAttribute("subjectList", subjectDAO.getAllSubject());

        getAnswerListInfo(request);
        int deletedId = Integer.parseInt(request.getParameter("deletedId"));
        answerList.remove(getIndexById(deletedId));
        request.setAttribute("answerList", answerList);

        Question q = new Question();
        q.setContent(request.getParameter("question"));
        request.setAttribute("question", q);
        request.getRequestDispatcher("/WEB-INF/views/question/newquestion.jsp").forward(request, response);
    }

    private ArrayList<Answer> getNonEmptyAnswerList() {
        ArrayList<Answer> nonEmptyList = new ArrayList<>();
        for (Answer a : answerList) {
            if (!a.getContent().isEmpty()) {
                nonEmptyList.add(a);
            }
        }
        return nonEmptyList;
    }

    private boolean checkDuplicateAnswer() {
        ArrayList<String> nonEmptyList = new ArrayList<>();
        for (Answer a : getNonEmptyAnswerList()) {
            nonEmptyList.add(a.getContent());
        }
        Set<String> set = new HashSet<>(nonEmptyList);
        return set.size() < nonEmptyList.size();
    }

    private void insertQuestion(HttpServletRequest request, HttpServletResponse response,
            int subjectId, int lessonId) throws ServletException, IOException {
        boolean successful = true;
        Lesson lesson = null;
        if (lessonId != 0) {
            lesson = lessonDAO.getLessonMatchId(lessonId);
            request.setAttribute("lesson", lesson);
        } else {
            successful = false;
            request.setAttribute("lessonErr", "Please choose a lesson");
        }
        getAnswerListInfo(request);
        Question q = new Question();
        q.setContent(request.getParameter("question".trim()));
        if (q.getContent().isEmpty()) {
            successful = false;
            request.setAttribute("questionErr", "Question cannot be blank!");
        }
        if (q.getContent().length() > 255) {
            successful = false;
            request.setAttribute("questionErr", "Question content can not exceed 255 characters!");
        }

        int nonEmptyAnswers = 0;
        int checked = 0;
        for (Answer a : answerList) {
            String content = a.getContent().trim();
            a.setContent(content);
            if (!a.getContent().isEmpty()) {
                nonEmptyAnswers++;
                if (a.getContent().length() > 255) {
                    successful = false;
                    request.setAttribute("answerErr", "Please enter answer within 255 characters!");
                    break;
                } else {
                    if (a.isIsCorrect()) {
                        checked++;
                    }
                }
            }
        }

        if (nonEmptyAnswers < 2) {
            successful = false;
            request.setAttribute("answerErr", "Please enter at least 2 answers!");
        } else if (checkDuplicateAnswer()) {
            successful = false;
            request.setAttribute("answerErr", "Please enter different answers!");
        } else if (checked == 0) {
            successful = false;
            request.setAttribute("answerErr", "Please select at least one correct answer!");
        }

        if (successful) {
            q.setLesson(lesson);
            q.setStatus(true);
            Question question = questionDAO.getQuestionByContent(q);
            if (question != null) {
                try {
                    questionDAO.insertQuestion(q);
                    for (Answer a : getNonEmptyAnswerList()) {
                        a.setQuestion(q);
                        answerDAO.insertAnswer(a);
                    }
                } catch (SQLException e) {
                    successful = false;
                    request.setAttribute("questionErr", "Adding question failed!");
                }
            } else {
                successful = false;
                request.setAttribute("questionErr", "Question already exist in subject!");
            }
        }

        if (successful) {
            HttpSession session = request.getSession();
            session.setAttribute("successful", "Insert question successfully!");
            response.sendRedirect("../question");
        } else {
            if (subjectId != 0) {
                request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
            } else {
                request.setAttribute("lessonList", lessonDAO.getAllLessons());
            }
            request.setAttribute("subjectList", subjectDAO.getAllSubject());
            request.setAttribute("answerList", answerList);
            request.setAttribute("question", q);
            request.getRequestDispatcher("/WEB-INF/views/question/newquestion.jsp").forward(request, response);
        }

    }

    private void insertQuestionByFile(HttpServletRequest request, HttpServletResponse response,
            int subjectId, int lessonId) throws ServletException, IOException {
        boolean successful = true;
        Lesson lesson = null;
        int count = 0;
        if (lessonId != 0) {
            lesson = lessonDAO.getLessonMatchId(lessonId);
            request.setAttribute("lesson", lesson);
            Part filePart = request.getPart("file");
            if ((filePart == null) || (filePart.getSize() == 0)) {
                successful = false;
                request.setAttribute("fileErr", "Please choose a file!");
            } else {
                try {
                    count = reader.readQuestionFromFile(filePart, lesson);
                } catch (IOException e) {
                    successful = false;
                    request.setAttribute("fileErr", "Import file failed!");
                }
            }
        } else {
            successful = false;
            request.setAttribute("lessonErr", "Please choose a lesson");
        }

        if (successful) {
            HttpSession session = request.getSession();
            if (count == 0) {
                session.setAttribute("err", "No question imported!");
            } else {
                session.setAttribute("successful", count + " questions imported successfully!");
            }
            response.sendRedirect("../question");
        } else {
            if (subjectId != 0) {
                request.setAttribute("subject", subjectDAO.getSubjectMatchId(subjectId));
                request.setAttribute("lessonList", lessonDAO.getAllLessonsOfASubject(subjectId));
            } else {
                request.setAttribute("lessonList", lessonDAO.getAllLessons());
            }
            request.setAttribute("subjectList", subjectDAO.getAllSubject());
            request.setAttribute("answerList", answerList);
            Question q = new Question();
            q.setContent(request.getParameter("question"));
            request.setAttribute("question", q);
            request.getRequestDispatcher("/WEB-INF/views/question/newquestion.jsp").forward(request, response);
        }
    }

    private void newQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int subjectId = 0, lessonId = 0;
        String sid = request.getParameter("subjectId");
        if ((sid != null) && (!sid.isEmpty()) && (!sid.equals("All subjects"))) {
            subjectId = Integer.parseInt(sid);
        }
        String lid = request.getParameter("lessonId");
        if ((lid != null) && (!lid.isEmpty()) && (!lid.equals("All lessons"))) {
            lessonId = Integer.parseInt(lid);
        }
        String action = request.getParameter("action");
        if (action != null) {
            switch (request.getParameter("action")) {
                case "changeSubjectAndLesson":
                    request.setAttribute("currentPage", request.getParameter("currentPage"));
                    changeSubjectAndLesson(request, response, subjectId, lessonId);
                    break;
                case "addAnswer":
                    request.setAttribute("currentPage", "enterData");
                    addAnswer(request, response, subjectId, lessonId);
                    break;
                case "deleteAnswer":
                    request.setAttribute("currentPage", "enterData");
                    deleteAnswer(request, response, subjectId, lessonId);
                    break;
                case "insertQuestion":
                    request.setAttribute("currentPage", "enterData");
                    insertQuestion(request, response, subjectId, lessonId);
                    break;
                case "insertQuestionByFile":
                    request.setAttribute("currentPage", "importFile");
                    insertQuestionByFile(request, response, subjectId, lessonId);
                    break;
                default:
                    request.setAttribute("currentPage", "enterData");
                    newQuestionForm(request, response, subjectId, lessonId);
                    break;
            }
        } else {
            request.setAttribute("currentPage", "enterData");
            newQuestionForm(request, response, subjectId, lessonId);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
