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

        <title>User details</title>

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
                    document.getElementById("buttonAssignSubject").className = "nav-link";
                    document.getElementById("buttonAssignSubject").ariaSelected = false;
                } else {
                    document.getElementById("navs-pills-assign-subject").className = "tab-pane fade show active";
                    document.getElementById("buttonAssignSubject").ariaSelected = true;
                    document.getElementById("buttonAssignSubject").className = "nav-link active";
                    document.getElementById("buttonEnterData").className = "nav-link";
                    document.getElementById("buttonEnterData").ariaSelected = false;
                }
            }
            function getActiveTab() {
                if (document.getElementById("buttonAssignSubject").className === 'nav-link active') {
                    return "assignSubject";
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

                            <h4 class="py-3 mb-4"><span class="text-muted fw-light">User /</span> User details</h4>
                            <form action="${pageContext.request.contextPath}/user/update" method="post"
                                  enctype="multipart/form-data">
                                <input type="hidden" name="userId" value="${requestScope.user.id}"/>
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
                                                    Update user details
                                                </button>
                                            </li>
                                            <c:if test="${requestScope.user.role < 3}">
                                                <li class="nav-item">
                                                    <button
                                                        type="button"
                                                        id="buttonAssignSubject"
                                                        role="tab"
                                                        data-bs-toggle="tab"
                                                        data-bs-target="#navs-pills-assign-subject"
                                                        aria-controls="navs-pills-assign-subject">
                                                        Assign subjects
                                                    </button>
                                                </li>
                                            </c:if>
                                        </ul>
                                        <div class="tab-content" style="width: 100%;">
                                            <div class="tab-pane fade" id="navs-pills-enter-data" role="tabpanel">
                                                <div class="card mb-4">
                                                    <h5 class="card-header mb-3">User Details for ${requestScope.user.name}</h5>
                                                    <!-- Account -->
                                                    <div class="card-body">
                                                        <div class="d-flex align-items-start align-items-sm-center gap-4">
                                                            <img
                                                                src="../${requestScope.user.avatar}"
                                                                alt="user-avatar"
                                                                class="d-block rounded"
                                                                height="100"
                                                                width="100"
                                                                id="uploadedAvatar"/>
                                                            <div class="button-wrapper">
                                                                <label for="upload" class="btn btn-primary me-2 mb-4" tabindex="0">
                                                                    <span class="d-none d-sm-block">Upload new photo</span>
                                                                    <i class="bx bx-upload d-block d-sm-none"></i>
                                                                    <input
                                                                        type="file"
                                                                        id="upload"
                                                                        class="account-file-input"
                                                                        accept="image/png, image/jpeg"
                                                                        hidden
                                                                        name="newAvatar"/>
                                                                </label>
                                                                <button type="button" class="btn btn-outline-secondary account-image-reset mb-4 me-2">
                                                                    <i class="bx bx-reset d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">Reset</span>
                                                                </button>

                                                                <p class="text-muted mb-0">Allowed JPG, GIF or PNG. Max size of 800K</p>
                                                                <c:if test="${requestScope.avtErr != null && !requestScope.avtErr.isEmpty()}">
                                                                    <div>
                                                                        <h6 style="color: red;">${requestScope.avtErr}</h6>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <hr class="my-0" />
                                                    <div class="card-body">
                                                        <div class="row">
                                                            <div class="mb-3 col-md-6">
                                                                <label for="name" class="form-label">Name</label>
                                                                <input
                                                                    class="form-control"
                                                                    type="text"
                                                                    id="name"
                                                                    name="name"
                                                                    value="${requestScope.user.name}"
                                                                    autofocus />
                                                                <c:if test="${requestScope.nameErr != null && !requestScope.nameErr.isEmpty()}">
                                                                    <h6 style="color: red;">${requestScope.nameErr}</h6>
                                                                </c:if>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="email" class="form-label">E-mail</label>
                                                                <input
                                                                    class="form-control"
                                                                    type="text"
                                                                    id="email"
                                                                    name="email"
                                                                    value="${requestScope.user.email}"
                                                                    placeholder="john.doe@example.com" 
                                                                    readonly/>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label for="roleSelect" class="form-label">Role</label>
                                                                <select id="roleSelect" class="select2 form-select" name="roleId">
                                                                    <c:forEach items="${requestScope.roleList}" var="role">
                                                                        <c:if test="${requestScope.user.role == role.id}">
                                                                            <option value="${role.id}" selected>${role.name}</option>
                                                                        </c:if>
                                                                        <c:if test="${requestScope.user.role != role.id}">
                                                                            <option value="${role.id}">${role.name}</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3 col-md-6">
                                                                <label class="form-label" for="status">Status</label>
                                                                <div class="form-control" id="status">
                                                                    <c:if test="${requestScope.user.status == 1}">
                                                                        <span class="badge rounded-pill bg-success" >Active</span>
                                                                    </c:if>
                                                                    <c:if test="${requestScope.user.status == 0}">
                                                                        <span class="badge rounded-pill bg-danger" >Inactive</span>
                                                                    </c:if>
                                                                    <c:if test="${requestScope.user.status == 2}">
                                                                        <span class="badge rounded-pill bg-info" >Unverified</span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mt-2">
                                                            <button type="submit" class="btn btn-primary me-2"
                                                                    onclick="document.getElementById('action').value = 'saveChanges'">Save changes</button>
                                                        </div>
                                                    </div>
                                                    <!-- /Account -->
                                                </div>
                                            </div>
                                            <c:if test="${requestScope.user.role < 3}">
                                                <div class="tab-pane fade" id="navs-pills-assign-subject" role="tabpanel">
                                                    <div class="input-group mr-3 mb-3" style="overflow: auto;">
                                                        <label for="subjectId">Subject: </label>
                                                        <select style="height: 38px;" name="subjectId" id="subjectId" class="mr-3 ml-3" 
                                                                onmousedown="if (this.options.length > 5) {
                                                                            this.size = 5;
                                                                            document.getElementById('sortBy').style.height = '115px';
                                                                        }"  
                                                                onblur="this.size = 0;
                                                                        document.getElementById('sortBy').style.height = '38px';">
                                                            <c:forEach items="${requestScope.unassignedSubjectList}" var="subject">
                                                                <c:if test="${requestScope.subject.id == subject.id}">
                                                                    <option value="${subject.id}" selected>${subject.code}</option>
                                                                </c:if>
                                                                <c:if test="${requestScope.subject.id != subject.id}">
                                                                    <option value="${subject.id}">${subject.code}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                        <button style="height: 38px; float: right;" 
                                                                class="btn btn-outline-primary mr-2" type="submit"
                                                                onclick="document.getElementById('action').value = 'assignSubject';">Assign subject</button>
                                                        <c:if test="${requestScope.err != null && !requestScope.err.isEmpty()}">
                                                            <h6 style="color: red;">${requestScope.err}</h6>
                                                        </c:if>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <h5 style="color: black;">${requestScope.user.name}</h5>
                                                    </div>
                                                    <c:if test="${requestScope.successful != null && !requestScope.successful.isEmpty()}">
                                                        <div class="row mb-3">
                                                            <h6 class="text-success">${requestScope.successful}</h6>
                                                        </div>
                                                    </c:if>
                                                    <div class="card">
                                                        <h5 class="card-header">Subject list</h5>
                                                        <div class="table-responsive text-nowrap">
                                                            <table class="table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>Code</th>
                                                                        <th>Name</th>
                                                                        <th></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody class="table-border-bottom-0">
                                                                    <c:forEach items="${requestScope.subjectList}" var="subject">
                                                                        <tr>
                                                                            <td class="text-primary">${subject.id}</td>
                                                                            <td class="text-primary">${subject.code}</td>
                                                                            <td class="text-primary">${subject.name}</td>
                                                                            <td>
                                                                                <button class="btn btn-icon btn-outline-danger"
                                                                                        type="button"
                                                                                        style="height: 25px; width: 25px; float: left;"
                                                                                        data-toggle="tooltip" data-placement="bottom" title="Remove"
                                                                                        onclick="
                                                                                                document.getElementById('modalSubjectId').value = ${subject.id};"
                                                                                        data-bs-toggle="modal" data-bs-target="#modalAssign">
                                                                                    <i class="bx bx-trash"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>

                                                        </div>

                                                        <!--/ Basic Bootstrap Table -->


                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>


                            </form>
                            <hr class="my-5" />

                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/user">Back</a>

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

        <div class="modal fade" id="modalAssign" tabindex="-1" aria-hidden="true">
            <form action="${pageContext.request.contextPath}/user/update">
                <input type="hidden" name="userId" value="${requestScope.user.id}"/>
                <input type="hidden" name="action" value="removeSubject"/>
                <input type="hidden" name="subjectId" id="modalSubjectId"/>
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalCenterTitle">Remove subject</h5>
                            <button
                                type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5 id="modalOrderBodyText">Are you sure you want to remove subject?</h5>
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
        <script src="../assets/js/pages-account-settings-account.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
</html>
