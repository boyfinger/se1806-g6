<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/img/favicon/favicon.ico"/>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Additional Custom Styles -->
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .card-body {
            padding: 2rem;
        }

        .form-floating label {
            font-size: 0.875rem;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .text-danger {
            font-size: 0.875rem;
        }
    </style>
</head>
<body>

<section class="d-flex align-items-center min-vh-100 bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card border-light">
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader"></i> KRS</h1>
                            <h2 class="h4 mt-3">Reset Password</h2>
                            <p class="fs-6 text-secondary">Please set a new password for your account</p>
                        </div>
                        <form action="resetpassword" method="post">
                            <div class="mb-3">
                                <div class="form-floating">
                                    <input type="password" class="form-control" name="oldpassword" id="oldpassword"
                                           placeholder="Old Password" required>
                                    <label for="oldpassword">Old Password</label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="form-floating">
                                    <input type="password" class="form-control" name="newpassword" id="newpassword"
                                           placeholder="New Password" required>
                                    <label for="newpassword">New Password</label>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="form-floating">
                                    <input type="password" class="form-control" name="confirmpassword"
                                           id="confirmpassword" placeholder="Confirm New Password" required>
                                    <label for="confirmpassword">Confirm New Password</label>
                                </div>
                            </div>
                            <div class="d-grid gap-2">
                                <span class="text-danger">${sessionScope.message}</span>
                                <button class="btn btn-primary" type="submit">Reset Password</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
