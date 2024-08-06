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

        <title>New Question</title>

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


                            <h4 class="py-3 mb-4"><span class="text-muted fw-light">User /</span> New user</h4>

                            <form action="${pageContext.request.contextPath}/user/new" method="post"
                                  enctype="multipart/form-data">
                                <input type="hidden" name="action" value="addUser"/>
                                <input type="hidden" name="isAvatarChanged" id="isAvatarChanged" value="false"/>
                                <input type="hidden" name="avt" value="${requestScope.user.avatar}"/>

                                <c:if test="${requestScope.user != null && requestScope.user.avatar != null 
                                              && !requestScope.user.avatar.isEmpty()}">
                                    <c:set var="avtSrc" value="../${requestScope.user.avatar}"></c:set>
                                </c:if>
                                <c:if test="${requestScope.user == null || requestScope.user.avatar == null 
                                              || requestScope.user.avatar.isEmpty()}">
                                    <c:set var="avtSrc" value="../assets/img/default_avt.jpg"></c:set>
                                </c:if>

                                <div class="card mb-4">
                                    <h5 class="card-header mb-3">New user</h5>
                                    <!-- Account -->
                                    <div class="card-body">
                                        <div class="d-flex align-items-start align-items-sm-center gap-4">
                                            <img
                                                src="${avtSrc}"
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
                                                        name="avatar"
                                                        onclick="document.getElementById('isAvatarChanged').value = 'true';"/>
                                                </label>
                                                <button type="button" class="btn btn-outline-secondary account-image-reset mb-4"
                                                        onclick="document.getElementById('isAvatarChanged').value = 'false';">
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
                                                    placeholder="john.doe@example.com"/>
                                                <c:if test="${requestScope.emailErr != null && !requestScope.emailErr.isEmpty()}">
                                                    <h6 style="color: red;">${requestScope.emailErr}</h6>
                                                </c:if>
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
                                                    <span class="badge rounded-pill bg-info" >Unverified</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mt-2">
                                            <button type="submit" class="btn btn-primary me-2">Add user</button>
                                        </div>
                                        <c:if test="${requestScope.err != null && !requestScope.err.isEmpty()}">
                                            <h5 style="color: red;">${requestScope.err}</h5>
                                        </c:if>
                                    </div>
                                    <!-- /Account -->
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
