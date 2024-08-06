<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Set Password</title>
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
                                    <h2 class="h4 text-center">Set Password</h2>
                                    <h3 class="fs-6 fw-normal text-secondary text-center m-0">Please set a password for
                                        your account</h3>
                                </div>
                            </div>
                        </div>
                        <form action="signup-google" method="post">
                            <div class="row gy-3 overflow-hidden">

                                <!-- Email field -->
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" name="email" id="email"
                                               value="${sessionScope.email}" readonly>
                                        <label for="email" class="form-label">Email</label>
                                    </div>
                                </div>

                                <!-- Full Name field -->
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="fullName" id="fullName"
                                               placeholder="Full Name" required>
                                        <label for="fullName" class="form-label">Full Name</label>
                                    </div>
                                </div>
                                <!-- Password input -->
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" name="password" id="password"
                                               placeholder="Password" required>
                                        <label for="password" class="form-label">Password</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" name="repassword" id="re-password"
                                               placeholder="Confirm Password" required>
                                        <label for="password" class="form-label">Confirm Password</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <span class="text-danger font-italic">${sessionScope.message}</span>
                                    <div class="d-grid">
                                        <button class="btn bsb-btn-xl btn-primary" type="submit">Set Password</button>
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
