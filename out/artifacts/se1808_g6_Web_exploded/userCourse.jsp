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

    <!-- Custom Styles -->
    <style>
        .card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #6c757d;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .search-container {
            margin-bottom: 20px;
        }

        .search-container input[type="text"] {
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .search-container input[type="text"] {
            width: 100%;
        }

    </style>
</head>
<body>
<div class="container mt-5">
    <h3 class="text-center">
        <span class="badge badge-pill badge-primary">My Courses</span>
    </h3>

    <!-- Search section -->
    <div class="search-container mb-3">
        <input type="text" id="searchInput" placeholder="Search by course name..." onkeyup="filterCourses()">
    </div>
    <div class="row" id="coursesContainer">
        <c:forEach var="course" items="${sessionScope.myCourses}">
            <c:set var="studentCount" value="${0}"/>
            <c:forEach var="courseStudentCount" items="${sessionScope.courseStudentCounts}">
                <c:if test="${courseStudentCount.courseId eq course.id}">
                    <c:set var="studentCount" value="${courseStudentCount.studentCount}"/>
                </c:if>
            </c:forEach>
            <div class="col-md-4 mb-4 flashcard" data-student-count="${studentCount}">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">${course.className}</h5>
                        <p class="card-text"><strong>Subject Code:</strong> ${course.subjectCode}</p>
                        <p class="card-text"><strong>Subject Name:</strong> ${course.subjectName}</p>
                        <p class="card-text"><strong>Instructor:</strong> ${course.instructorName}</p>
                        <p class="card-text text-success"><strong>Students Enrolled:</strong> ${studentCount}</p>
                        <a href="${pageContext.request.contextPath}/profile/course?courseId=${course.id}"
                           class="btn btn-primary">View Details</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Custom Script -->
<script>
    function filterCourses() {
        var input, filter, container, cards, cardTitle, i, txtValue;
        input = document.getElementById('searchInput');
        filter = input.value.toUpperCase();
        container = document.getElementById('coursesContainer');
        cards = container.getElementsByClassName('flashcard');

        for (i = 0; i < cards.length; i++) {
            cardTitle = cards[i].getElementsByClassName('card-title')[0];
            txtValue = cardTitle.textContent || cardTitle.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                cards[i].style.display = "";
            } else {
                cards[i].style.display = "none";
            }
        }
    }


</script>

</body>
</html>
