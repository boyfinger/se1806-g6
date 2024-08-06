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

        <title>Question list</title>

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

        <!-- Favicon -->
        <link href="../img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <!-- Helpers -->
        <script src="assets/vendor/js/helpers.js"></script>
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="assets/js/config.js"></script>
    </head>

    <body>
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

                        <div class="container-xxl flex-grow-1 container-p-y">

                            <div>
                                <form action="${pageContext.request.contextPath}/question/new">
                                    <input type="hidden" name="subjectId" value="${requestScope.subject.id}"/>
                                    <input type="hidden" name="lessonId" value="${requestScope.lesson.id}"/>
                                    <button class="btn btn-primary px-3">
                                        <i class="fa fa-plus-square mr-3"></i>
                                        New question
                                    </button>
                                </form>
                            </div>

                            <h4 class="py-3 mb-4"><span class="text-muted fw-light">Question /</span> Question list</h4>

                            <form id="searchBar" class="d-flex" action="${pageContext.request.contextPath}/question">
                                <input type="hidden" name="change" id="change"/>
                                <div class="input-group mr-3" style="overflow: auto;">
                                    <label for="subjectselect">Subject: </label>
                                    <select style="height: 38px;" name="subjectId" id="subjectselect" class="mr-3 ml-3" 
                                            onchange="document.getElementById('change').value = 'subject';
                                                    document.getElementById('searchBar').submit();"
                                            onmousedown="if (this.options.length > 5) {
                                                        this.size = 5;
                                                        document.getElementById('subjectselect').style.height = '115px';
                                                    }"  
                                            onblur="this.size = 0;document.getElementById('subjectselect').style.height = '38px';">
                                        <c:if test="${(requestScope.subject == null)}">
                                            <option selected>All subjects</option>
                                        </c:if>
                                        <c:if test="${(requestScope.subject != null)}">
                                            <option>All subjects</option>
                                        </c:if>
                                        <c:forEach items="${requestScope.subjectList}" var="subject">
                                            <c:if test="${subject.id == requestScope.subject.id}">
                                                <option value="${subject.id}" selected>${subject.code}</option>
                                            </c:if>
                                            <c:if test="${subject.id != requestScope.subject.id}">
                                                <option value="${subject.id}">${subject.code}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <label for="lessonSelect">Lesson: </label>
                                    <select style="height: 38px;" name="lessonId" id="lessonSelect" class="mr-3 ml-3" 
                                            onchange="document.getElementById('change').value = 'lesson';
                                                    document.getElementById('searchBar').submit();"
                                            onmousedown="if (this.options.length > 5) {
                                                        this.size = 5;
                                                        document.getElementById('lessonSelect').style.height = '115px';
                                                    }"  
                                            onblur="this.size = 0;
                                                    document.getElementById('lessonSelect').style.height = '38px';">
                                        <c:if test="${(requestScope.lesson == null)}">
                                            <option selected>All lessons</option>
                                        </c:if>
                                        <c:if test="${(requestScope.lesson != null)}">
                                            <option>All lessons</option>
                                        </c:if>
                                        <c:forEach items="${requestScope.lessonList}" var="lesson">
                                            <c:if test="${lesson.id == requestScope.lesson.id}">
                                                <option value="${lesson.id}" selected>${lesson.name}</option>
                                            </c:if>
                                            <c:if test="${lesson.id != requestScope.lesson.id}">
                                                <option value="${lesson.id}">${lesson.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <span style="height: 38px;" class="input-group-text"><i class="tf-icons bx bx-search"></i></span>
                                    <input type="text" name="keyword" class="form-control" placeholder="Search" value="${requestScope.keyword}"/>
                                    <button style="height: 38px;" class="btn btn-outline-primary mr-2" type="submit">Search</button>
                                    <label for="sortBy">Sort by: </label>
                                    <select style="height: 38px;" name="sortBy" id="sortBy" class="mr-3 ml-3" 
                                            onchange="document.getElementById('searchBar').submit();"
                                            onmousedown="if (this.options.length > 5) {
                                                        this.size = 5;
                                                        document.getElementById('sortBy').style.height = '115px';
                                                    }"  
                                            onblur="this.size = 0;
                                                    document.getElementById('sortBy').style.height = '38px';">
                                        <c:forEach items="${requestScope.sortOptions}" var="option">
                                            <c:if test="${requestScope.sortBy == option}">
                                                <option value="${option}" selected>${option}</option>
                                            </c:if>
                                            <c:if test="${requestScope.sortBy != option}">
                                                <option value="${option}">${option}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>


                            </form>

                            <div class="row mb-3">
                                <c:if test="${requestScope.successful != null && !requestScope.successful.isEmpty()}">
                                    <h6 class="text-success">${requestScope.successful}</h6>
                                </c:if>
                                <c:if test="${requestScope.err != null && !requestScope.err.isEmpty()}">
                                    <h6 class="text-danger">${requestScope.err}</h6>
                                </c:if>
                            </div>

                            <!-- Basic Bootstrap Table -->

                            <div class="card">
                                <h5 class="card-header">Question list</h5>
                                <div class="table-responsive text-nowrap">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Content</th>
                                                <th>Subject</th>
                                                <th>Lesson</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="table-border-bottom-0">
                                            <c:forEach items="${requestScope.list}" var="question">
                                                <tr>
                                                    <c:if test="${question.status}">
                                                        <td style="color: #696cff;">${question.id}</td>
                                                        <td style="color: #696cff;">${question.content}</td>
                                                        <td style="color: #696cff;">${question.lesson.subject.code}</td>
                                                        <td style="color: #696cff;">${question.lesson.name}</td>
                                                    </c:if>
                                                    <c:if test="${!question.status}">
                                                        <td>${question.id}</td>
                                                        <td>${question.content}</td>
                                                        <td>${question.lesson.subject.code}</td>
                                                        <td>${question.lesson.name}</td>
                                                    </c:if>
                                                    <td>
                                                        <c:if test="${question.status}">
                                                            <span class="badge rounded-pill bg-success">Active</span>
                                                        </c:if>
                                                        <c:if test="${!question.status}">
                                                            <span class="badge rounded-pill bg-danger">Inactive</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${question.status}">
                                                            <form action="${pageContext.request.contextPath}/question/details" id="questionDetails">
                                                                <input type="hidden" name="questionId" value="${question.id}"/>
                                                                <button style="height: 25px; width: 25px; float: left;" type="submit" class="btn btn-icon btn-outline-primary mr-1"
                                                                        data-toggle="tooltip" data-placement="bottom" title="View details">
                                                                    <i class="bx bx-edit"></i>
                                                                </button>
                                                            </form>
                                                            <button style="height: 25px; width: 25px; float: left;" type="button" class="btn btn-icon btn-outline-danger"
                                                                    data-toggle="tooltip" data-placement="bottom" title="Deactivate"
                                                                    data-bs-toggle="modal" data-bs-target="#modal" onclick="assignValue(${question.id}, 'deactivate')">
                                                                <i class="bx bx-x"></i>
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${!question.status}">
                                                            <button style="height: 25px; width: 25px; float: left;" class="btn btn-icon btn-outline-secondary mr-1"
                                                                    data-toggle="tooltip" data-placement="bottom" title="View details" disabled>
                                                                <i class="bx bx-edit"></i>
                                                            </button>
                                                            <button style="height: 25px; width: 25px; float: left" type="button" class="btn btn-icon btn-outline-success"
                                                                    data-toggle="tooltip" data-placement="bottom" title="Activate"
                                                                    data-bs-toggle="modal" data-bs-target="#modal" onclick="assignValue(${question.id}, 'activate')">
                                                                <i class="bx bx-check me-1"></i>
                                                            </button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="modal fade" id="modal" tabindex="-1" aria-hidden="true">
                                        <form action="${pageContext.request.contextPath}/question/update">
                                            <input type="hidden" name="questionId" id="questionId"/>
                                            <input type="hidden" name="action" value="changeStatus"/>
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="modalCenterTitle">Activate / Deactivate</h5>
                                                        <button
                                                            type="button"
                                                            class="btn-close"
                                                            data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h5 id="modalBodyText"></h5>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                                            No
                                                        </button>
                                                        <button type="submit" class="btn btn-primary">Yes</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!--/ Basic Bootstrap Table -->


                            </div>
                            <!-- / Content -->

                            <form action="${pageContext.request.contextPath}/question">
                                <input type="hidden" name="subjectId" value="${requestScope.subject.id}"/>
                                <input type="hidden" name="lessonId" value="${requestScope.lesson.id}"/>
                                <input type="hidden" name="sortBy" value="${requestScope.sortBy}"/>
                                <input type="hidden" name="keyword" value="${requestScope.keyword}"/>
                                <input type="hidden" name="pageAction" id="pageAction"/>
                                <input type="hidden" name="newPage" id="newPage"/>
                                <input type="hidden" name="currentPage" value="${requestScope.currentPage}"/>
                                <div class="card mb-4">
                                    <!-- Basic Pagination -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <small class="text-light fw-medium">Basic</small>
                                                <div class="demo-inline-spacing">
                                                    <!-- Basic Pagination -->
                                                    <nav aria-label="Page navigation">
                                                        <ul class="pagination">
                                                            <li class="page-item first">
                                                                <button class="page-link"
                                                                        type="submit"
                                                                        onclick="document.getElementById('pageAction').value = 'firstPage';">
                                                                    <i class="tf-icon bx bx-chevrons-left"></i>
                                                                </button>
                                                            </li>
                                                            <li class="page-item prev">
                                                                <button class="page-link"
                                                                        type="submit"
                                                                        onclick="document.getElementById('pageAction').value = 'prevPage';">
                                                                    <i class="tf-icon bx bx-chevron-left"></i>
                                                                </button>
                                                            </li>
                                                            <c:set var="noOfPages" value="${requestScope.noOfPages}"></c:set>
                                                            <c:forEach begin="1" end="${requestScope.noOfPages}" var="page">
                                                                <c:if test="${(page == 1) || (page == 2) || (Math.abs(page - requestScope.currentPage) <= 1)
                                                                              || (page == noOfPages) || (page == noOfPages - 1)}">
                                                                    <c:if test="${page == requestScope.currentPage}">
                                                                        <li class="page-item active">
                                                                            <button class="page-link"
                                                                                    type="submit"
                                                                                    onclick="document.getElementById('newPage').value = ${page}">${page}</button>
                                                                        </li>
                                                                    </c:if>
                                                                    <c:if test="${page != requestScope.currentPage}">
                                                                        <li class="page-item">
                                                                            <input type="hidden" name="page" value="${page}"/>
                                                                            <button class="page-link"
                                                                                    type="submit"
                                                                                    onclick="document.getElementById('newPage').value = ${page}">${page}</button>
                                                                        </li>
                                                                    </c:if>
                                                                </c:if>
                                                                <c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
                                                                <c:if test="${(page == currentPage - 2) && (page > 2)}">
                                                                    <li class="page-item">
                                                                        <button class="page-link">...</button>
                                                                    </li>
                                                                </c:if>
                                                                <c:if test="${(page == currentPage + 2) && (page < noOfPages - 1)}">
                                                                    <li class="page-item">
                                                                        <button class="page-link">...</button>
                                                                    </li>
                                                                </c:if>
                                                            </c:forEach>
                                                            <li class="page-item next">
                                                                <button class="page-link"
                                                                        type="submit"
                                                                        onclick="document.getElementById('pageAction').value = 'nextPage';">
                                                                    <i class="tf-icon bx bx-chevrons-right"></i>
                                                                </button>
                                                            </li>

                                                            <li class="page-item last">
                                                                <button class="page-link"
                                                                        type="submit"
                                                                        onclick="document.getElementById('pageAction').value = 'lastPage';">
                                                                    <i class="tf-icon bx bx-chevrons-right"></i>
                                                                </button>
                                                            </li>
                                                        </ul>
                                                    </nav>
                                                    <!--/ Basic Pagination -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <jsp:include page="/WEB-INF/common/footer.jsp"/>
                        </div>
                        <!-- Content wrapper -->


                    </div>
                    <!-- / Layout page -->
                </div>
            </div>
            <!-- / Layout wrapper -->
        </div>

        <script>
            function assignValue(questionId, action) {
                document.getElementById("questionId").value = questionId;
                let text1 = "Are you sure you want to ";
                let text2 = " question?";
                let s = text1 + action + text2;
                document.getElementById("modalBodyText").innerHTML = s;
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="../lib/easing/easing.min.js"></script>
        <script src="../lib/waypoints/waypoints.min.js"></script>
        <script src="../lib/counterup/counterup.min.js"></script>
        <script src="../lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="../js/main.js"></script>

        <!-- Core JS -->
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
        <script src="assets/js/dashboards-analytics.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>

        <script src="js/sider.js"></script>
    </body>
</html>
