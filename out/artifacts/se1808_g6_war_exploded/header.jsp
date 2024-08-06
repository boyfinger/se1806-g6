<%-- 
    Document   : header
    Created on : May 20, 2024, 8:24:26 AM
    Author     : DELL
--%>
<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
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
<!-- Topbar Start -->
<div class="container-fluid bg-dark">
    <div class="row py-2 px-lg-5">
        <div class="col-lg-6 text-center text-lg-left mb-2 mb-lg-0">
            <div class="d-inline-flex align-items-center text-white">
                <small><i class="fa fa-phone-alt mr-2"></i>+012 345 6789</small>
                <small class="px-3">|</small>
                <small><i class="fa fa-envelope mr-2"></i>info@example.com</small>
            </div>
        </div>
        <div class="col-lg-6 text-center text-lg-right">
            <div class="d-inline-flex align-items-center">
                <a class="text-white px-2" target="_blank" href="https://www.facebook.com/boyfingerr/">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a class="text-white px-2" target="_blank" href="https://twitter.com/boyfinger42">
                    <i class="fab fa-twitter"></i>
                </a>
                <a class="text-white px-2" target="_blank" href="https://www.linkedin.com/">
                    <i class="fab fa-linkedin-in"></i>
                </a>
                <a class="text-white px-2" target="_blank" href="https://www.instagram.com/">
                    <i class="fab fa-instagram"></i>
                </a>
                <a class="text-white pl-2" target="_blank" href="https://www.youtube.com/@JOISPOI">
                    <i class="fab fa-youtube"></i>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->


<!-- Navbar Start -->
<div class="container-fluid p-0">
    <nav class="navbar navbar-expand-lg bg-white navbar-light py-3 py-lg-0 px-lg-5">
        <a href="${pageContext.request.contextPath}/home" class="navbar-brand ml-lg-3">
            <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader mr-3"></i>KRS</h1>
        </a>
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between px-lg-3" id="navbarCollapse">
            <div class="navbar-nav mx-auto py-0">
                <a href="${pageContext.request.contextPath}/home" class="nav-item nav-link" id="home">Home</a>
                <a href="${pageContext.request.contextPath}/course" class="nav-item nav-link" id="subjects">Subjects</a>
                <a href="course.jsp" class="nav-item nav-link" id="classes">Classes</a>
                <a href="${pageContext.request.contextPath}/course" class="nav-item nav-link" id="contact">Contact</a>
                <a href="${pageContext.request.contextPath}/flashcard" class="nav-item nav-link" id="flashcard">Flashcard</a>
            </div>
            <c:if test="${sessionScope.user != null}">
                <div class="kekw">
                    <button class="btn bg-white text-body px-4 dropdown-toggle hide-arrow" type="button"
                            data-toggle="dropdown"
                            aria-haspopup="false" aria-expanded="false">
                        <img height="20px" src="${sessionScope.user.avatar}"/>
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="dashboard.jsp">Dashboard</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Profile</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
            </c:if>
            <c:if test="${sessionScope.user == null}">
                <a href="login.jsp" class="btn btn-primary py-2 px-4 d-none d-lg-block mr-3">Login</a>
                <a href="signup.jsp" class="btn btn-primary py-2 px-4 d-none d-lg-block">Sign up</a>
            </c:if>
        </div>
    </nav>
</div>
<!-- Navbar End -->

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

<!-- JavaScript to handle the active state of navbar items -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Get the current active item from local storage
        const currentActive = localStorage.getItem('activeNavItem');
        if (currentActive) {
            // Remove 'active' class from all nav-links
            document.querySelectorAll('.nav-link').forEach(item => item.classList.remove('active'));
            // Add 'active' class to the stored active item
            document.getElementById(currentActive).classList.add('active');
        }

        // Add click event listener to all nav-links
        document.querySelectorAll('.nav-link').forEach(item => {
            item.addEventListener('click', function () {
                // Remove 'active' class from all nav-links
                document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));
                // Add 'active' class to the clicked item
                item.classList.add('active');
                // Store the id of the clicked item in local storage
                localStorage.setItem('activeNavItem', item.id);
            });
        });
    });
</script>
</body>
</html>
