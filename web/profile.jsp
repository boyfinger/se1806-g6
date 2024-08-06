<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Information</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">

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
<section class="bg-light p-3 p-md-4 p-xl-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="card border border-light-subtle rounded-4">
                    <div class="card-body p-4 p-md-5">
                        <div class="mb-5 text-center">
                            <h2 class="h4">User Profile</h2>
                        </div>
                        <div class="row gy-4 align-items-center">
                            <div class="col-md-4 text-center">
                                <c:set var="avatarPath"
                                       value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/${sessionScope.user.avatar}"/>
                                <img src="${avatarPath}" alt="User Avatar" class="rounded-circle border border-primary"
                                     width="150" height="150">
                            </div>
                            <div class="col-md-8">
                                <div class="row gy-3">
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <input type="text" class="form-control border border-primary" id="fullName"
                                                   value="${sessionScope.user.name}" readonly>
                                            <label for="fullName">Full Name</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <input type="email" class="form-control border border-primary" id="email"
                                                   value="${sessionScope.user.email}" readonly>
                                            <label for="email">Email</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <input type="text" class="form-control border border-primary" id="role"
                                                   readonly>
                                            <script>
                                                var sessionRoleValue = ${sessionScope.user.role};
                                                var roleMapping = {
                                                    0: 'Admin',
                                                    1: 'Manager',
                                                    2: 'Teacher',
                                                    3: 'Student'
                                                };
                                                var roleText = roleMapping[sessionRoleValue] || 'Other';
                                                document.getElementById('role').value = roleText;
                                            </script>
                                            <label for="role">Role</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-12 text-center">
                                <button class="btn btn-primary" onclick="loadContent('edit-profile')">
                                    <i class="fa fa-edit"></i> Edit Profile
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function loadContent(page) {
        $.ajax({
            url: page + ".jsp",
            type: "GET",
            success: function (data) {
                $("#mainContent").html(data);
            },
            error: function () {
                alert("Failed to load content");
            }
        });
    }
</script>
</body>
</html>
