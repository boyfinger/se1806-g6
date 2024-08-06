<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="static model.google.GoogleConstants.GOOGLE_LOGIN_URL" %>
<html
    lang="en"
    class="light-style layout-wide customizer-hide"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Login</title>

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

        <!-- Page CSS -->
        <!-- Page -->
        <link rel="stylesheet" href="assets/vendor/css/pages/page-auth.css" />

        <!-- Helpers -->
        <script src="assets/vendor/js/helpers.js"></script>
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="assets/js/config.js"></script>

        <link href="img/favicon.ico" rel="icon">

        <!-- Page CSS -->
    </head>

    <body>
        <jsp:include page="header1.jsp"/>
        <!-- Layout wrapper -->
        <div class="container-xxl">
            <div class="authentication-wrapper authentication-basic container-p-y">
                <div class="authentication-inner">
                    <!-- Register -->
                    <div class="card">
                        <div class="card-body">
                            <!-- Logo -->
                            <div class="app-brand justify-content-center">
                                <a href="${pageContext.request.contextPath}/home" class="navbar-brand ml-lg-3">
                                    <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader mr-3"></i>KRS</h1>
                                </a>
                            </div>
                            <!-- /Logo -->
                            <h4 class="mb-2">Adventure starts here 🚀</h4>
                            <p class="mb-4">Make your learning easy and fun!</p>

                            <form id="formAuthentication" class="mb-3" action="signup" method="post">
                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full name</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="fullName"
                                        name="fullName"
                                        placeholder="Your full name"/>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input
                                        type="text"
                                        class="form-control"
                                        id="email"
                                        name="email"
                                        placeholder="Enter your email or username"
                                        autofocus />
                                </div>
                                <div class="mb-3 form-password-toggle">
                                    <div class="d-flex justify-content-between">
                                        <label class="form-label" for="password">Password</label>
                                    </div>
                                    <div class="input-group input-group-merge">
                                        <input
                                            type="password"
                                            id="password"
                                            class="form-control"
                                            name="password"
                                            placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                                            aria-describedby="password" />
                                        <span class="input-group-text cursor-pointer"
                                              onclick="showPassword('password','showIconPassword');">
                                            <i class="bx bx-show" id="showIconPassword"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="mb-3 form-password-toggle">
                                    <div class="d-flex justify-content-between">
                                        <label class="form-label" for="repassword">Confirm password</label>
                                    </div>
                                    <div class="input-group input-group-merge">
                                        <input
                                            type="password"
                                            id="repassword"
                                            class="form-control"
                                            name="repassword"
                                            placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                                            aria-describedby="repassword" />
                                        <span class="input-group-text cursor-pointer"
                                              onclick="showPassword('repassword','showIconRePassword');">
                                            <i class="bx bx-show" id="showIconRePassword"></i>
                                        </span>
                                    </div>
                                </div>
                                <div>
                                    <c:set var="message" value="${sessionScope.message}"></c:set>
                                    <c:if test="${message != null && !message.isEmpty()}">
                                        <h6 style="color: red;">${message}</h6>
                                    </c:if>
                                </div>
                                <div class="mb-3">
                                    <button class="btn btn-primary d-grid w-100" type="submit">Sign up</button>
                                </div>
                            </form>

                            <p class="text-center mb-3">
                                <span>Already have an account?</span>
                                <a href="login.jsp">
                                    <span>Sign in instead</span>
                                </a>
                            </p>
                        </div>
                        <div class="row mb-3"
                             style="display: inline-flex; align-items: center; justify-content: center;">
                            <span class="mb-3 text-center">Or continue with</span>
                            <a href="<%=GOOGLE_LOGIN_URL%>"
                               class="btn btn-icon btn-outline-danger" 
                               style="width: 54px; height: 54px; display: inline-flex;
                               align-items: center; justify-content: center;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor"
                                     class="bi bi-google" viewBox="0 0 16 16"
                                     style="margin: auto;">
                                <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z"></path>
                                </svg>
                            </a>
                        </div>
                    </div>
                    <!-- /Register -->
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>

        <script>
            function showPassword(passwordElementId, iconElementId) {
                let passwordElement = document.getElementById(passwordElementId);
                let iconElement = document.getElementById(iconElementId);
                let type = passwordElement.type;
                if (type === 'password') {
                    passwordElement.type = 'text';
                    iconElement.className = 'bx bx-hide';
                } else {
                    passwordElement.type = 'password';
                    iconElement.className = 'bx bx-show';
                }
            }
        </script>

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
    </body>
</html>
