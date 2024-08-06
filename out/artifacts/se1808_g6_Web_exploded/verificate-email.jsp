<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 04-Jun-24
  Time: 12:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- This taglib is not used in this file -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Verify your email</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://unpkg.com/bs-brain@2.0.4/components/registrations/registration-7/assets/css/registration-7.css">

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
<jsp:include page="header1.jsp"/>
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
                                    <h2 class="h4 text-center">Email Verification</h2>
                                    <h3 class="fs-6 fw-normal text-secondary text-center m-0">Please enter the code sent
                                        to your email. If you do not see the code, check your spam</h3>
                                </div>
                            </div>
                        </div>
                        <!-- Verificaiton code -->
                        <form action="verify-email" method="post">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" name="verifycode" id="verifycode"
                                               placeholder="Verificaiton code" required>
                                        <label for="verifycode" class="form-label">Verificaiton code</label>
                                    </div>
                                    <div class="col-12">
                                        <div class="d-grid gap-2">
                                            <span class="text-danger font-italic">${sessionScope.message}</span>

                                            <button class="btn bsb-btn-md btn-primary" type="submit">Verify</button>
                                            <button class="btn bsb-btn-md btn-secondary" type="button"
                                                    onclick="window.history.back();">Go Back
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="footer.jsp"/>
</body>
</html>
