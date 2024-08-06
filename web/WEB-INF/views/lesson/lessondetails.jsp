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

        <title>Lesson details</title>

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
        <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>

        <script>
            function setActiveTab(currentPage) {
                if (currentPage === 'enterData' || currentPage === null || currentPage === '') {
                    document.getElementById("navs-pills-enter-data").className = "tab-pane fade show active";
                    document.getElementById("buttonEnterData").ariaSelected = true;
                    document.getElementById("buttonEnterData").className = "nav-link active";
                    document.getElementById("buttonMaterial").className = "nav-link";
                    document.getElementById("buttonMaterial").ariaSelected = false;
                } else {
                    document.getElementById("navs-pills-material").className = "tab-pane fade show active";
                    document.getElementById("buttonMaterial").ariaSelected = true;
                    document.getElementById("buttonMaterial").className = "nav-link active";
                    document.getElementById("buttonEnterData").className = "nav-link";
                    document.getElementById("buttonEnterData").ariaSelected = false;
                }
            }
            function getActiveTab() {
                if (document.getElementById("buttonMaterial").className === 'nav-link active') {
                    return "inportFile";
                } else {
                    return "enterData";
                }
            }
            function setActiveTabForRefresh() {
                document.getElementById('currentPage').value = getActiveTab();
            }
        </script>

    </head>

    <body onload="setActiveTab('${requestScope.currentPage}');">
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


                            <h4 class="py-3 mb-4"><span class="text-muted fw-light">Lesson /</span> Lesson details</h4>
                            <div class="mb-3">
                                <label for="subject">Subject: </label>
                                <input type="text" value="${requestScope.lesson.subject.code}" readonly id="subject"/>
                            </div>
                            <form action="${pageContext.request.contextPath}/lesson/update"
                                  enctype="multipart/form-data"
                                  method="post">
                                <input type="hidden" name="lessonId" value="${requestScope.lesson.id}"/>
                                <input type="hidden" name="action" id="action"/>
                                <div class="row">
                                    <div class="nav-align-top mb-4">
                                        <ul class="nav nav-pills mb-3" role="tablist">
                                            <li class="nav-item">
                                                <button
                                                    type="button"
                                                    id="buttonEnterData"
                                                    role="tab"
                                                    data-bs-toggle="tab"
                                                    data-bs-target="#navs-pills-enter-data"
                                                    aria-controls="navs-pills-enter-data">
                                                    Update lesson name
                                                </button>
                                            </li>
                                            <li class="nav-item">
                                                <button
                                                    type="button"
                                                    id="buttonMaterial"
                                                    role="tab"
                                                    data-bs-toggle="tab"
                                                    data-bs-target="#navs-pills-material"
                                                    aria-controls="navs-pills-material">
                                                    View lesson's materials
                                                </button>
                                            </li>
                                        </ul>
                                        <div class="tab-content" style="width: 100%;">
                                            <div class="tab-pane fade" id="navs-pills-enter-data" role="tabpanel">
                                                <div class="col-xxl">
                                                    <div class="card mb-4">
                                                        <div class="card-header d-flex align-items-center justify-content-between mb-3">
                                                            <h5 class="mb-0">Lesson details</h5>
                                                            <small class="text-muted float-end">Input lesson name</small>
                                                        </div>
                                                        <div class="card-body">

                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label" for="basic-icon-default-fullname">Name</label>
                                                                <div class="col-sm-10">
                                                                    <div class="input-group input-group-merge">
                                                                        <span id="basic-icon-default-fullname2" class="input-group-text">
                                                                            <i class="bx bx-rename"></i></span>
                                                                        <input
                                                                            type="text"
                                                                            class="form-control"
                                                                            id="basic-icon-default-fullname"
                                                                            name="name"
                                                                            value="${requestScope.lesson.name}"
                                                                            placeholder="Lesson name"
                                                                            aria-label="Lesson name"
                                                                            aria-describedby="basic-icon-default-fullname2" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <c:if test="${requestScope.err != null && !requestScope.err.isEmpty()}">
                                                                <div class="row mb-3">
                                                                    <div class="col-sm-2"></div>
                                                                    <div class="col-sm-10">
                                                                        <h6 style="color: red;">${requestScope.err}</h6>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                            <div class="row justify-content-end">
                                                                <div class="col-sm-10">
                                                                    <button type="submit" class="btn btn-primary"
                                                                            onclick="document.getElementById('action').value = 'updateLesson';"> 
                                                                        Update lesson 
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade" id="navs-pills-material" role="tabpanel">
                                                <div class="row mb-4">
                                                    <label for="formFile" class="form-label">Choose a file</label>
                                                    <div class="col-sm-9">
                                                        <input class="form-control" type="file" id="formFile"
                                                               name="file"
                                                               style="width: 100%;"/>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <button
                                                            style="height: 38px;" class="btn btn-primary ml-3"
                                                            type="submit"
                                                            onclick="document.getElementById('action').value = 'insertMaterial'">
                                                            Add material
                                                        </button>
                                                    </div>
                                                </div>
                                                <c:if test="${(requestScope.fileErr != null) && (!requestScope.fileErr.isEmpty())}">
                                                    <div class="row mb-3">
                                                        <h6 style="color: red;">${requestScope.fileErr}</h6>
                                                    </div>
                                                </c:if>
                                                <c:if test="${(requestScope.fileSuccessful != null) && (!requestScope.fileSuccessful.isEmpty())}">
                                                    <div class="row mb-3">
                                                        <h6 class="text-success">${requestScope.fileSuccessful}</h6>
                                                    </div>
                                                </c:if>
                                                <div class="row mb-3">
                                                    <h5 style="color: black;">${requestScope.lesson.name}</h5>
                                                </div>
                                                <div class="table-responsive text-nowrap">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Name</th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="table-border-bottom-0">
                                                            <c:forEach items="${requestScope.materialList}" var="material">
                                                                <tr>
                                                                    <td>${material.id}</td>
                                                                    <td>
                                                                        <a href="../${material.uri}" download="${material.name}">
                                                                            ${material.name}
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <button class="btn btn-icon btn-outline-danger"
                                                                                type="button"
                                                                                style="height: 25px; width: 25px; float: left;"
                                                                                data-toggle="tooltip" data-placement="bottom" title="Remove"
                                                                                onclick="
                                                                                        document.getElementById('materialId').value = ${material.id};"
                                                                                data-bs-toggle="modal" data-bs-target="#modalMaterial">
                                                                            <i class="bx bx-trash"></i>
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </form>
                            <hr class="my-5" />

                            <a href="${pageContext.request.contextPath}/lesson" class="btn btn-primary">Back</a>

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

        <div class="modal fade" id="modalMaterial" tabindex="-1" aria-hidden="true">
            <form action="${pageContext.request.contextPath}/lesson/update">
                <input type="hidden" name="lessonId" value="${requestScope.lesson.id}"/>
                <input type="hidden" name="action" value="removeMaterial"/>
                <input type="hidden" name="materialId" id="materialId"/>
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalCenterTitle">Remove material</h5>
                            <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5 id="modalOrderBodyText">Are you sure you want to remove material?</h5>
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
