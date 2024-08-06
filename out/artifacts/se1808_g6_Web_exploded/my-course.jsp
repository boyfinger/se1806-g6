<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Knowledge Revising System - My Course</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Custom Styles for Sidebar -->
    <style>
        #sidebar {
            height: 100%;
            width: 0;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background-color: #111;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 60px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        #sidebar a {
            padding: 8px 8px 8px 32px;
            text-decoration: none;
            font-size: 25px;
            color: #818181;
            display: block;
            transition: 0.3s;
        }

        #sidebar a:hover {
            color: #f1f1f1;
        }

        #sidebar .closebtn {
            position: absolute;
            top: 15px;
            right: 25px;
            font-size: 36px;
            margin-left: 50px;
        }

        #sidebar h3 {
            margin: 0;
            padding: 10px;
            color: white;
        }

        #main {
            transition: margin-left .5s;
            padding: 16px;
        }

        .openbtn {
            font-size: 20px;
            cursor: pointer;
            background-color: #111;
            color: white;
            padding: 10px 15px;
            border: none;
        }

        .openbtn:hover {
            background-color: #444;
        }

        /* Adjusted styles for tab content */
        .tab-content {
            margin-top: 20px; /* Adjust as needed */
        }

        .tab-pane {
            padding-top: 15px; /* Adjust as needed */
        }

        .card {
            margin-bottom: 20px; /* Adjust as needed */
        }
    </style>
</head>
<body>
<%--Header include--%>
<jsp:include page="header1.jsp"/>

<%-- Sidebar --%>
<div id="sidebar">
    <a href="javascript:void(0)" class="closebtn" onclick="toggleNav()">&times;</a>
    <h3 class="text-center text-white">My Classes</h3>
    <c:forEach var="myCourse" items="${sessionScope.myCourses}">
        <a href="${pageContext.request.contextPath}/my-course?classId=${myCourse.id}">${myCourse.subjectCode}</a>
    </c:forEach>
</div>

<div id="main">
    <button class="openbtn" onclick="toggleNav()">&#9776; My Classes</button>

    <div class="container mt-5">
        <h3 class="text-center">
            <span class="badge badge-pill badge-primary">Course Details</span>
        </h3>

        <%-- Course Details Section --%>
        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">${sessionScope.myCourse.courseDetail.className}</h5>
                <p class="card-text"><strong>Subject Name:</strong> ${sessionScope.myCourse.courseDetail.subjectName}
                </p>
                <p class="card-text"><strong>Instructor:</strong> ${sessionScope.myCourse.courseDetail.instructorName}
                </p>
            </div>
        </div>

        <%-- Tabs for announcements, lessons, tests, flashcards --%>
        <div class="mt-5">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="announcements-tab" data-toggle="tab" href="#announcements" role="tab"
                       aria-controls="announcements" aria-selected="true">Announcements</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="lessons-tab" data-toggle="tab" href="#lessons" role="tab"
                       aria-controls="lessons" aria-selected="false">Lessons</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="tests-tab" data-toggle="tab" href="#tests-content" role="tab"
                       aria-controls="tests-content" aria-selected="false">Tests</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="flashcards-tab" data-toggle="tab" href="#flashcards" role="tab"
                       aria-controls="flashcards" aria-selected="false">Flashcards</a>
                </li>
            </ul>

            <%-- Tab Content --%>
            <div class="tab-content">
                <!-- Announcements Tab Pane -->
                <div class="tab-pane fade show active" id="announcements" role="tabpanel"
                     aria-labelledby="announcements-tab">
                    <div>
                        <c:if test="${sessionScope.user.role == 2}">
                            <h4 class="text-center">Post Announcement</h4>
                            <form action="${pageContext.request.contextPath}/post-announcement" method="post">
                                <div class="form-group">
                                    <label for="announcement">Announcement:</label>
                                    <textarea class="form-control" id="announcement" name="announcement"
                                              rows="3"></textarea>
                                </div>
                                <input type="hidden" name="classId" value="${sessionScope.myCourse}">
                                <button type="submit" class="btn btn-primary">Post</button>
                            </form>
                            <hr>
                        </c:if>
                        <h4 class="text-center">Announcements</h4>
                        <c:forEach var="announcement" items="${sessionScope.myCourse.announcements}">
                            <div class="alert alert-info mt-3" role="alert">
                                    ${announcement.announcement}
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Lessons Tab Pane -->
                <div class="tab-pane fade" id="lessons" role="tabpanel" aria-labelledby="lessons-tab">
                    <div>
                        <h4 class="text-center">Lessons</h4>
                        <div class="row">
                            <c:forEach var="lesson" items="${sessionScope.myCourse.lessons}">
                                <div class="col-md-4 mb-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title">${lesson.name}</h5>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Tests Tab Pane -->
                <div class="tab-pane fade" id="tests-content" role="tabpanel" aria-labelledby="tests-tab">
                    <div>
                        <h4 class="text-center">Tests</h4>
                        <div class="row">
                            <c:forEach var="test" items="${sessionScope.myCourse.tests}">
                                <div class="col-md-4 mb-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title">Test ID: ${test.id}</h5>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Flashcards Tab Pane -->
                <div class="tab-pane fade" id="flashcards" role="tabpanel" aria-labelledby="flashcards-tab">
                    <div>
                        <h4 class="text-center">Flashcards</h4>
                        <div class="row">
                            <c:forEach var="flashcardSet" items="${sessionScope.myCourse.flashcardSets}">
                                <div class="col-md-4 mb-4">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title">${flashcardSet.name}</h5>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

<!-- Custom JavaScript for Sidebar -->
<script>
    function toggleNav() {
        const sidebar = document.getElementById("sidebar");
        const main = document.getElementById("main");
        if (sidebar.style.width === "250px") {
            sidebar.style.width = "0";
            main.style.marginLeft = "0";
        } else {
            sidebar.style.width = "250px";
            main.style.marginLeft = "250px";
        }
    }

    $(document).ready(function () {
        $('#myTab a').on('click', function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
    });
</script>

<%--Footer--%>
<jsp:include page="footer.jsp"/>
</body>
</html>
<%--connect flashcards to flashcard--%>
<%--add delete announcement--%>
<%--add new lesson for instructor--%>
<%--add new flashcard for instructor (choose from existing)--%>
<%--add new test for instructor--%>
<%--add searches for all of this--%>