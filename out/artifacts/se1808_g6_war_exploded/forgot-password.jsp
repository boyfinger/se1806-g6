<%@ page import="static model.google.GoogleConstants.GOOGLE_LOGIN_URL" %><%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 02-Jun-24
  Time: 3:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot password</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-4/assets/css/login-4.css">
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"/>
<section class="bg-light p-3 p-md-4 p-xl-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                <div class="card border border-light-subtle rounded-4">
                    <div class="card-body p-3 p-md-4 p-xl-5">
                        <div class="row">
                            <div class="col-12">
                                <div class="mb-5">
                                    <div class="text-center mb-4">
                                        <a href="home" class="navbar-brand ml-lg-3">
                                            <h1 class="m-0 text-uppercase text-primary"><i
                                                    class="fa fa-book-reader mr-3"></i>KRS</h1>
                                        </a>

                                    </div>
                                    <h4 class="text-center">Forgot password</h4>
                                </div>
                            </div>
                        </div>

                        <form action="forgotpassword" method="POST">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" name="email" id="email"
                                               placeholder="name@example.com" required>
                                        <label for="email" class="form-label">Email</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn bsb-btn-xl btn-primary" type="submit">Reset password</button>
                                        <span style="color: red; font-style: italic;">${message}</span>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="row">
                            <div class="col-12">
                                <hr class="mt-5 mb-4 border-secondary-subtle">
                                <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-end">
                                    <a href="signup.jsp" class="link-secondary text-decoration-none">Create new
                                        account</a>
                                    <a href="login.jsp" class="link-secondary text-decoration-none">Login</a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 d-flex align-items-center justify-content-center">
                                <p class="mt-5 mb-5 mr-2">Or continue with</p>
                                <!-- Google sign-up button -->
                                <a href="<%=GOOGLE_LOGIN_URL%>" class="btn btn-lg btn-outline-danger p-3 lh-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor"
                                         class="bi bi-google" viewBox="0 0 16 16">
                                        <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>
</body>
</html>
