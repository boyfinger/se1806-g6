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

        <title>Enter activation code</title>

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

        <!-- Page -->
        <link rel="stylesheet" href="../assets/vendor/css/pages/page-auth.css" />

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

        <jsp:include page="/WEB-INF/common/header.jsp"/>

        <div class="container-sm" style="width: 500px;">
            <div class="authentication-wrapper authentication-basic container-p-y">
                <div class="authentication-inner">
                    <!-- Register Card -->
                    <div class="card">
                        <div class="card-body">
                            <!-- Logo -->
                            <div class="app-brand justify-content-center">
                                <a href="${pageContext.request.contextPath}/activate" class="navbar-brand ml-lg-3">
                                    <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader mr-3"></i>KRS</h1>
                                </a>
                            </div>
                            <!-- /Logo -->
                            <br/>

                            <h5 style="color: black; margin: auto 0;">Your account is inactive. Please check your email to get your activation code.</h5>

                            <br/>

                            <form id="formAuthentication" class="mb-3" action="${pageContext.request.contextPath}/activate"
                                  method="post">
                                <input type="hidden" name="userId" value="${requestScope.user.id}"/>
                                <input type="hidden" name="activationCode" value="${requestScope.activationCode}"/>
                                <div class="mb-3 form-password-toggle">
                                    <label class="form-label" for="code">Your activation code</label>
                                    <div class="input-group input-group-merge">
                                        <input
                                            type="text"
                                            id="code"
                                            class="form-control"
                                            name="code"
                                            value="${requestScope.code}"
                                            placeholder="Your activation code"
                                            aria-describedby="code" />
                                    </div>
                                </div>
                                <c:if test="${err != null && !err.isEmpty()}">
                                    <h6 style="color: red;">${requestScope.err}</h6>
                                </c:if>
                                <button class="btn btn-primary d-grid w-100">Enter code</button>
                            </form>
                        </div>
                    </div>
                    <!-- Register Card -->
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/common/footer.jsp"/>

        <script>
            function showPassword(elementId) {
                const passwordField = document.getElementById(elementId);
                let show = elementId + 'Show';
                const icon = document.getElementById(show);
                if (passwordField.type === 'password') {
                    passwordField.type = 'text';
                    icon.className = 'bx bx-hide';
                } else {
                    passwordField.type = 'password';
                    icon.className = 'bx bx-show';
                }
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

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="../assets/vendor/js/menu.js"></script>

        <!-- endbuild -->

        <!-- Vendors JS -->

        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>

        <!-- Page JS -->

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
</html>
