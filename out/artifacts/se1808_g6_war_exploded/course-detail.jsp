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
</head>
<body>
<%-- Header --%>
<jsp:include page="header1.jsp"/>

<%-- Content --%>
<div class="container mt-5">
    <h3 class="text-center"><span class="badge badge-pill badge-primary">Course Detail</span></h3>

    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">${sessionScope.courseDetail.className}</h5>
            <p class="card-text"><strong>Subject Name:</strong> ${sessionScope.courseDetail.subjectName}</p>
            <p class="card-text"><strong>Instructor:</strong> ${sessionScope.courseDetail.instructorName}</p>
        </div>
    </div>
    <br>

    <%-- Student List --%>
    <h3 class="text-center"><span class="badge badge-pill badge-primary">Student List</span></h3>
    <div class="mt-5">
        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover table-striped table-bordered">
                    <thead class="table-info">
                    <tr>
                        <th scope="col">Student Name</th>
                        <th scope="col">Contact Email</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="student" items="${sessionScope.courseStudent}">
                        <tr>
                            <td>${student.fullName}</td>
                            <td>${student.email}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%-- Enroll Button --%>
    <div class="container-fluid mt-3">
        <div class="row">
            <div class="col text-right">
                <a href="${pageContext.request.contextPath}/enroll?courseId=${sessionScope.courseDetail.id}"
                   class="btn btn-primary text-white">Enroll Me!</a>
            </div>
        </div>
    </div>
</div>


<%-- JavaScript Libraries --%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
</body>
</html>
