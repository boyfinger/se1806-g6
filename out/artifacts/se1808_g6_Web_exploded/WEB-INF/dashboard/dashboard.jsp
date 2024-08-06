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
        <input type="hidden" name="currentPageUri" value="${pageContext.request.requestURI}"/> 
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->

                <jsp:include page="/WEB-INF/common/sider.jsp"/>
                <!-- / Menu -->

                <!-- Layout container -->
                <div class="layout-page">

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <jsp:include page="/WEB-INF/common/header.jsp"/>

                        <div class="content-wrapper">
                            <!-- Content -->

                            <div class="container-xxl flex-grow-1 container-p-y">
                                <div class="row">
                                    <div class="col-lg-8 mb-4 order-0">
                                        <div class="card">
                                            <div class="d-flex align-items-end row">
                                                <div class="col-sm-7">
                                                    <div class="card-body">
                                                        <h5 class="card-title text-primary">Welcome back! 🎉</h5>
                                                        <p class="mb-4">
                                                            You have done <span class="fw-medium">72%</span> more sales today. Check your new badge in
                                                            your profile.
                                                        </p>

                                                        <a href="javascript:;" class="btn btn-sm btn-outline-primary">View Badges</a>
                                                    </div>
                                                </div>
                                                <div class="col-sm-5 text-center text-sm-left">
                                                    <div class="card-body pb-0 px-0 px-md-4">
                                                        <img
                                                            src="assets/img/illustrations/man-with-laptop-light.png"
                                                            height="140"
                                                            alt="View Badge User"
                                                            data-app-dark-img="illustrations/man-with-laptop-dark.png"
                                                            data-app-light-img="illustrations/man-with-laptop-light.png" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-4 order-1">
                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-6 mb-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="card-title d-flex align-items-start justify-content-between">
                                                            <div class="avatar flex-shrink-0">
                                                                <a href="${pageContext.request.contextPath}/user">
                                                                    <span class="badge bg-label-primary p-2"><i class="bx bx-user text-primary"></i></span>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <span class="fw-medium d-block mb-1">Users</span>
                                                        <h3 class="card-title mb-2">${requestScope.userList.size()}</h3>
                                                        <c:if test="${requestScope.newUsersToday != 0}">
                                                            <small class="text-success fw-medium">
                                                                <i class="bx bx-up-arrow-alt"></i> ${requestScope.newUsersToday} new users today
                                                            </small>
                                                        </c:if>
                                                        <c:if test="${requestScope.newUsersToday == 0}">
                                                            <small class="text-dark fw-medium">
                                                                No new users today
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-6 mb-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="card-title d-flex align-items-start justify-content-between">
                                                            <div class="avatar flex-shrink-0">
                                                                <a href="${pageContext.request.contextPath}/subjectlist">
                                                                    <span class="badge bg-label-success p-2"><i class="bx bx-book-open text-success"></i></span>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <span>Subjects</span>
                                                        <h3 class="card-title text-nowrap mb-1">${requestScope.subjectList.size()}</h3>
                                                        <small class="text-success fw-medium">------</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Total Revenue -->
                                    <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                                        <div class="card">
                                            <div class="row row-bordered g-0">
                                                <div class="col-md-8">
                                                    <h5 class="card-header m-0 me-2 pb-3">Total Revenue</h5>
                                                    <div id="totalRevenueChart" class="px-2"></div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="card-body">
                                                        <div class="text-center">
                                                            <div class="dropdown">
                                                                <button
                                                                    class="btn btn-sm btn-outline-primary dropdown-toggle"
                                                                    type="button"
                                                                    id="growthReportId"
                                                                    data-bs-toggle="dropdown"
                                                                    aria-haspopup="true"
                                                                    aria-expanded="false">
                                                                    2022
                                                                </button>
                                                                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="growthReportId">
                                                                    <a class="dropdown-item" href="javascript:void(0);">2021</a>
                                                                    <a class="dropdown-item" href="javascript:void(0);">2020</a>
                                                                    <a class="dropdown-item" href="javascript:void(0);">2019</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div id="growthChart"></div>
                                                    <div class="text-center fw-medium pt-3 mb-2">62% Company Growth</div>

                                                    <div class="d-flex px-xxl-4 px-lg-2 p-4 gap-xxl-3 gap-lg-1 gap-3 justify-content-between">
                                                        <div class="d-flex">
                                                            <div class="me-2">
                                                                <span class="badge bg-label-primary p-2"><i class="bx bx-dollar text-primary"></i></span>
                                                            </div>
                                                            <div class="d-flex flex-column">
                                                                <small>2022</small>
                                                                <h6 class="mb-0">$32.5k</h6>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex">
                                                            <div class="me-2">
                                                                <span class="badge bg-label-info p-2"><i class="bx bx-wallet text-info"></i></span>
                                                            </div>
                                                            <div class="d-flex flex-column">
                                                                <small>2021</small>
                                                                <h6 class="mb-0">$41.2k</h6>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/ Total Revenue -->
                                    <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
                                        <div class="row">
                                            <div class="col-6 mb-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="card-title d-flex align-items-start justify-content-between">
                                                            <div class="avatar flex-shrink-0">
                                                                <a href="${pageContext.request.contextPath}/classlist">
                                                                    <span class="badge bg-label-danger p-2"><i class="bx bx-group text-danger"></i></span>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <span class="d-block mb-1">Class</span>
                                                        <h3 class="card-title text-nowrap mb-2">${requestScope.classList.size()}</h3>
                                                        <small class="text-danger fw-medium">-----</small>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6 mb-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="card-title d-flex align-items-start justify-content-between">
                                                            <div class="avatar flex-shrink-0">
                                                                <a href="${pageContext.request.contextPath}/question">
                                                                    <span class="badge bg-label-primary p-2"><i class="bx bx-question-mark text-primary"></i></span>
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <span class="fw-medium d-block mb-1">Question</span>
                                                        <h3 class="card-title mb-2">${requestScope.questionList.size()}</h3>
                                                        <small class="text-success fw-medium">-----</small>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- </div>
                            <div class="row"> -->
                                            <div class="col-12 mb-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                                                            <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                                                                <div class="card-title">
                                                                    <h5 class="text-nowrap mb-2">Profile Report</h5>
                                                                    <span class="badge bg-label-warning rounded-pill">Year 2021</span>
                                                                </div>
                                                                <div class="mt-sm-auto">
                                                                    <small class="text-success text-nowrap fw-medium"
                                                                           ><i class="bx bx-chevron-up"></i> 68.2%</small
                                                                    >
                                                                    <h3 class="mb-0">$84,686k</h3>
                                                                </div>
                                                            </div>
                                                            <div id="profileReportChart"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- / Content -->


                            <div class="content-backdrop fade"></div>
                        </div>

                        <jsp:include page="/WEB-INF/common/footer.jsp"/>
                    </div>
                    <!-- Content wrapper -->


                </div>
                <!-- / Layout page -->
            </div>
        </div>
        <!-- / Layout wrapper -->

        <!-- build:js assets/vendor/js/core.js -->

        <script src="assets/vendor/libs/jquery/jquery.js"></script>
        <script src="assets/vendor/libs/popper/popper.js"></script>
        <script src="assets/vendor/js/bootstrap.js"></script>
        <script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="assets/vendor/js/menu.js"></script>
        <script src="js/sider.js"></script>

        <!-- endbuild -->
        
        

        <!-- Vendors JS -->
        <script src="assets/vendor/libs/apex-charts/apexcharts.js"></script>

        <!-- Main JS -->
        <script src="assets/js/main.js"></script>

        <!-- Page JS -->
        <script src="assets/js/dashboards-analytics.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
</html>
