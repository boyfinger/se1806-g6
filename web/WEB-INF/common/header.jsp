<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html
        lang="en"
        class="light-style layout-menu-fixed layout-compact"
        dir="ltr"
        data-theme="theme-default"
        data-assets-path="assets/"
        data-template="vertical-menu-template-free">
<head>
    <title>Tables - Basic Tables | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"/>

    <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css"/>

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Core CSS -->
    <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css"/>
    <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="assets/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="assets/js/config.js"></script>
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
                <a href="${pageContext.request.contextPath}/home"
                   id="nav-item-home" class="nav-item nav-link text-dark">Home</a>
                <a href="${pageContext.request.contextPath}/course"
                   class="nav-item nav-link text-dark" id="nav-item-course">Subjects</a>
                <a href="course.jsp" class="nav-item nav-link text-dark" id="nav-item-classes">Classes</a>
                <a href="${pageContext.request.contextPath}/contact"
                   class="nav-item nav-link text-dark" id="nav-item-contact">Contact</a>
                <a href="${pageContext.request.contextPath}/flashcard"
                   id="nav-item-flashcard" class="nav-item nav-link text-dark">Flashcard</a>
            </div>
        </div>

        <c:if test="${sessionScope.user != null}">
            <c:set var="currentPage" value="${pageContext.request.requestURI}"></c:set>
            <c:set var="avt" value="${sessionScope.user.avatar}"></c:set>
            <c:if test="${currentPage.contains('userdetails.jsp') || currentPage.contains('questiondetails.jsp')
                                  || currentPage.contains('newquestion.jsp') || currentPage.contains('newuser.jsp')}">
                <c:set var="avatar" value="../${avt}"></c:set>
            </c:if>
            <c:if test="${!currentPage.contains('userdetails.jsp') && !currentPage.contains('questiondetails.jsp')
                                  && !currentPage.contains('newquestion.jsp') && !currentPage.contains('newuser.jsp')}">
                <c:set var="avatar" value="${avt}"></c:set>
            </c:if>
            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
                <ul class="navbar-nav flex-row align-items-center ms-auto">
                    <!-- Place this tag where you want the button to render. -->


                    <!-- User -->
                    <li class="nav-item navbar-dropdown dropdown-user dropdown">
                        <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);"
                           data-bs-toggle="dropdown">
                            <div class="avatar avatar-online">
                                <img src="${avatar}" alt class="rounded-circle border border-primary"
                                     width="40" height="40"/>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="#">
                                    <div class="d-flex">
                                        <div class="flex-shrink-0 me-3">
                                            <div class="avatar avatar-online">
                                                <img src="${avatar}" alt class="rounded-circle border border-primary"
                                                     width="40" height="40"/></div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <span class="fw-medium d-block">${sessionScope.user.name}</span>
                                            <small class="text-muted">${sessionScope.user.r.name}</small>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <div class="dropdown-divider"></div>
                            </li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                    <i class="bx bx-user me-2"></i>
                                    <span class="align-middle">My Profile</span>
                                </a>
                            </li>
                            <c:if test="${sessionScope.user.role < 2}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="bx bx-bar-chart me-2"></i>
                                        <span class="align-middle">Dashboard</span>
                                    </a>
                                </li>
                            </c:if>
                            <li>
                                <div class="dropdown-divider"></div>
                            </li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="bx bx-power-off me-2"></i>
                                    <span class="align-middle">Log Out</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!--/ User -->
                </ul>
            </div>
        </c:if>
        <c:if test="${sessionScope.user == null}">
            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
                <a href="${pageContext.request.contextPath}/login.jsp"
                   class="btn btn-primary py-2 px-4 d-none d-lg-block mr-3">Login</a>
                <a href="${pageContext.request.contextPath}/signup.jsp"
                   class="btn btn-primary py-2 px-4 d-none d-lg-block">Sign up</a>
            </div>
        </c:if>


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

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->

<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/libs/popper/popper.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="assets/vendor/js/menu.js"></script>

<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="assets/js/main.js"></script>

<!-- Page JS -->

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<script src="js/header.js"></script>
</body>
</html>
