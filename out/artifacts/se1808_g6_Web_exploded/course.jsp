<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Knowledge Revising System</title>
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
    </style>
</head>
<body>
<%--Header--%>
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

    <%--Content--%>
    <div class="container mt-5">
        <h3 class="text-center">
            <span class="badge badge-pill badge-primary">Courses</span>
        </h3>
        <div class="row mt-5">
            <c:forEach var="course" items="${sessionScope.courses}">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${course.className}</h5>
                            <p class="card-text"><strong>Subject Code:</strong> ${course.subjectCode}</p>
                            <p class="card-text"><strong>Subject Name:</strong> ${course.subjectName}</p>
                            <p class="card-text"><strong>Instructor:</strong> ${course.instructorName}</p>
                                <%-- Display Student Count here --%>
                            <p class="card-text text-success"><strong>Students Enrolled:</strong>
                                <c:forEach var="courseStudentCount" items="${sessionScope.courseStudentCounts}">
                                    <c:if test="${courseStudentCount.courseId eq course.id}">
                                        ${courseStudentCount.studentCount}
                                    </c:if>
                                </c:forEach>
                            </p>
                            <a href="${pageContext.request.contextPath}/enroll?courseId=${course.id}"
                               class="btn btn-primary">Enroll</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
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
<!-- Custom Script for Sidebar -->
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
</script>
<%--Footer--%>
<jsp:include page="footer.jsp"/>
</body>
</html>
<%--add searches--%>
<%--add filters--%>
<%--add sorting--%>
<%--add pagination--%>