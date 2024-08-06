<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html
    lang="en"
    class="light-style layout-menu-fixed layout-compact"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Question details</title>

        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet" />

        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

        <!-- Page CSS -->

        <!-- Favicon -->
        <link href="../img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="../lib/owlcarousel/../assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>


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


                            <h4 class="py-3 mb-4"><span class="text-muted fw-light">Question /</span> Question details</h4>
                            <div class="mb-3">
                                <label for="subject">Subject: </label>
                                <input type="text" style="width: 100px;"
                                       value="${requestScope.question.lesson.subject.code}" readonly id="subject"/>
                                <label for="lesson">Lesson: </label>
                                <input type="text" style="width: 500px;" 
                                       value="${requestScope.question.lesson.name}" readonly id="lesson"/>
                            </div>
                            <form action="${pageContext.request.contextPath}/question/update">
                                <div class="col-xxl">
                                    <div class="card mb-4">
                                        <div class="card-header d-flex align-items-center justify-content-between mb-3">
                                            <small class="text-muted float-end">Input question and answers content</small>
                                        </div>
                                        <div class="card-body">
                                            <input type="hidden" name="questionId" value="${requestScope.question.id}"/>
                                            <input type="hidden" name="action" id="action"/>
                                            <input type="hidden" name="deletedId" id="deletedId"/>
                                            <div class="row mb-5">
                                                <label class="col-sm-2 col-form-label" for="basic-icon-default-fullname2">Question</label>
                                                <div class="col-sm-10">
                                                    <textarea name="question" id="basic-icon-default-fullname2"
                                                              class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                                              rows="5" placeholder="Question content">${requestScope.question.content}</textarea>
                                                </div>
                                            </div>
                                            <c:if test="${requestScope.questionErr != null}">
                                                <div class="row mb-3">
                                                    <div class="col-sm-2"></div>
                                                    <div class="col-sm-10">
                                                        <h5 style="color: red;">${requestScope.questionErr}</h5>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${requestScope.answerErr != null}">
                                                <div class="row mb-3">
                                                    <div class="col-sm-2"></div>
                                                    <div class="col-sm-10">
                                                        <h5 style="color: red;">${requestScope.answerErr}</h5>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:forEach items="${requestScope.answerList}" var="answer">
                                                <div class="row mb-3">
                                                    <label class="col-sm-2 col-form-label" for="basic-icon-default-fullname">Answer</label>

                                                    <div class="col-sm-9">
                                                        <div class="input-group">
                                                            <c:if test="${answer.isCorrect}">
                                                                <span style="height: 38px; width: 38px;" class="input-group-text"></span>
                                                                <input
                                                                    class="form-check-input mt-0 ml-2"
                                                                    type="checkbox" style="align-self: center; "
                                                                    name="${answer.id}isCorrect"
                                                                    checked/>
                                                            </c:if>
                                                            <c:if test="${!answer.isCorrect}">
                                                                <span style="height: 38px; width: 38px;" class="input-group-text"></span>
                                                                <input
                                                                    class="form-check-input mt-0 ml-2"
                                                                    name="${answer.id}isCorrect"
                                                                    type="checkbox" style="align-self: center;"/>
                                                            </c:if>

                                                            <input type="text" class="form-control" id="basic-icon-default-fullname"
                                                                   name="${answer.id}"
                                                                   value="${answer.content}"/>
                                                        </div>
                                                    </div>
                                                    <c:if test="${requestScope.answerList.size() > 2}">
                                                        <div class="col-sm-1">
                                                            <button style="height: 38px; width: 38px;" class="btn btn-icon"
                                                                    type="submit"
                                                                    onclick="document.getElementById('action').value = 'deleteAnswer';
                                                                            document.getElementById('deletedId').value = ${answer.id};">
                                                                <i style="color: red;" class="bx bx-trash"></i>
                                                            </button>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                            <div class="row mb-3">
                                                <div class="col-sm-2"></div>
                                                <div class="col-sm-10">
                                                    <button type="submit" style="height: 38px; width: 38px;" 
                                                            class="btn btn-icon btn-primary"
                                                            onclick="document.getElementById('action').value = 'addAnswer';">
                                                        <i class="bx bx-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-2"></div>
                                                <div class="col-sm-10">
                                                    <button type="submit" class="btn btn-primary">Update answer</button>
                                                    <h3>${requestScope.err}</h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <hr class="my-5" />

                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/question">Back</a>

                        </div>
                        <!-- / Content -->

                        <div class="content-backdrop fade"></div>
                        <jsp:include page="/WEB-INF/common/footer.jsp"/>
                    </div>
                    <!-- Content wrapper -->


                </div>
                <!-- / Layout page -->
            </div>
        </div>
        <!-- / Layout wrapper -->

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="../lib/easing/easing.min.js"></script>
        <script src="../lib/waypoints/waypoints.min.js"></script>
        <script src="../lib/counterup/counterup.min.js"></script>
        <script src="../lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="../js/main.js"></script>

        <!-- Core JS -->
        <!-- build:js ../assets/vendor/js/core.js -->

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="../assets/vendor/js/menu.js"></script>

        <!-- endbuild -->

        <!-- Vendors JS -->
        <script src="../assets/vendor/libs/apex-charts/apexcharts.js"></script>

        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>

        <!-- Page JS -->
        <script src="../assets/js/dashboards-analytics.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
</html>
