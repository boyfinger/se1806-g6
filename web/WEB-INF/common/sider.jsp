<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html
    lang="en"
    class="light-style layout-menu-fixed layout-compact"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Dashboard</title>

        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico" />

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet" />

        <link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="assets/vendor/libs/apex-charts/apex-charts.css" />

        <!-- Page CSS -->

        <!-- Helpers -->
        <script src="assets/vendor/js/helpers.js"></script>
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="assets/js/config.js"></script>
    </head>

    <body>
        <c:set var="currentPage" value="${pageContext.request.requestURI}"></c:set>
            <!-- Layout wrapper -->
            <!-- Menu -->

            <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                <div class="app-brand demo">
                    <a href="${pageContext.request.contextPath}/home" class="app-brand-link">
                    <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader mr-3"></i>KRS</h1>
                </a>

                <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
                    <i class="bx bx-chevron-left bx-sm align-middle"></i>
                </a>
            </div>

            <div class="menu-inner-shadow"></div>

            <ul class="menu-inner py-1">

                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Administration</span>
                </li>
                <!-- Apps -->
                <c:if test="${sessionScope.user.role == 0}">
                    <li class="menu-item" id="user-menu-item">
                        <a href="${pageContext.request.contextPath}/user" class="menu-link">
                            <i class="menu-icon tf-icons bx bx-user"></i>
                            <div data-i18n="User list">User list</div>
                        </a>
                    </li>
                </c:if>
                <li class="menu-item" id="subjectlist-menu-item">
                    <a href="${pageContext.request.contextPath}/subjectlist" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-book-open"></i>
                        <div data-i18n="Subject list">Subject list</div>
                    </a>
                </li>
                <li class="menu-item" id="classlist-menu-item">
                    <a href="${pageContext.request.contextPath}/classlist" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-chalkboard"></i>
                        <div data-i18n="Class list">Class list</div>
                    </a>
                </li>
                <li class="menu-item" id="lesson-menu-item">
                    <a href="${pageContext.request.contextPath}/lesson" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-book-alt"></i>
                        <div data-i18n="Lesson list">Lesson list</div>
                    </a>
                </li>
                <li class="menu-item" id="question-menu-item">
                    <a href="${pageContext.request.contextPath}/question" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-question-mark"></i>
                        <div data-i18n="Question list">Question list</div>
                    </a>
                </li>

                <li class="menu-header small text-uppercase">
                    <span class="menu-header-text">Navigation</span>
                </li>

                <li class="menu-item">
                    <a href="${pageContext.request.contextPath}/home" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-home"></i>
                        <div data-i18n="Home">Home</div>
                    </a>
                </li>

                <li class="menu-item" id="dashboard-menu-item">
                    <a href="${pageContext.request.contextPath}/dashboard" class="menu-link">
                        <i class="menu-icon tf-icons bx bx-bar-chart"></i>
                        <div data-i18n="Dashboard">Dashboard</div>
                    </a>
                </li>

            </ul>
        </aside>
        <!-- / Menu -->

        <!-- / Layout wrapper -->

        <!-- build:js assets/vendor/js/core.js -->

        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/libs/popper/popper.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="assets/vendor/js/menu.js"></script>

        <!-- endbuild -->

        <!-- Vendors JS -->
        <script src="assets/vendor/libs/apex-charts/apexcharts.js"></script>

        <!-- Main JS -->
        <script src="assets/js/main.js"></script>

        <!-- Page JS -->

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
</html>
