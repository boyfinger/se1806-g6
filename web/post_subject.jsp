<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Post Subject</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }

        .form-group button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #5cb85c;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #4cae4c;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="row">
    <div class="col-lg-1"></div>
    <div class="col-lg-10">
        <h1><span class="badge badge-pill badge-primary">Post subject</span></h1>
        <h5 style="color: red">${requestScope.err}</h5>
        <form>
            <!-- Tiêu Đề -->
            <div class="form-group">
                <label for="title">Tiêu đề</label>
                <input type="text" id="title" name="title" required>
            </div>

            <!-- Nội Dung -->
            <div class="form-group">
                <label for="content">Nội dung</label>
                <textarea id="content" name="content" rows="10" required></textarea>
            </div>

            <!-- Upload Link hoặc File -->
            <div class="form-group">
                <label for="upload-link">Upload link hoặc file</label>
                <input type="url" id="upload-link" name="upload-link" placeholder="Nhập link...">
                <input type="file" id="upload-file" name="upload-file">
            </div>

            <!-- Môn Học -->
            <div class="form-group">
                <label for="subject">Môn</label>
                <select id="subject" name="subject" required>
                    <option value="">Chọn môn</option>
                    <option value="math">Toán</option>
                    <option value="science">Khoa học</option>
                    <option value="literature">Văn học</option>
                    <option value="history">Lịch sử</option>
                    <option value="geography">Địa lý</option>
                    <!-- Thêm các môn học khác ở đây -->
                </select>
            </div>

            <!-- Lớp Học -->
            <div class="form-group">
                <label for="subject">Lớp</label>
                <select id="subject" name="subject" required>
                    <option value="">Chọn Lớp</option>
                    <option value="math">Toán</option>
                    <option value="science">Khoa học</option>
                    <option value="literature">Văn học</option>
                    <option value="history">Lịch sử</option>
                    <option value="geography">Địa lý</option>
                    <!-- Thêm các môn học khác ở đây -->
                </select>
            </div>

            <!-- Nút Đăng Bài -->
            <div class="form-group ">
                <button type="submit" style="background-color: #1F74EA ">Đăng bài</button>
            </div>
        </form>
    </div>
    <div class="col-lg-1"></div>
</div>


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
</body>
</html>
