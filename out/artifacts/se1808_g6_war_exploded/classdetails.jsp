<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Subject details</title>
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
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="row">
    <div class="col-lg-1"></div>
    <div class="col-lg-10">
        <h1><span class="badge badge-pill badge-primary">Class details</span></h1>
        <h5 style="color: red">${requestScope.err}</h5>
        <div class="form-row align-items-center">
            <form action="classdetails" method="post">
                <input type="hidden" name="action" value="updateclass"/>
                <input type="hidden" name="id" value="${requestScope.classes.id}"/>
                <div class="col-auto">
                    <label for="code">Class code</label>
                    <input type="text" class="form-control mb-2" name="code" id="code"
                           value="${requestScope.classes.code}" placeholder="Class code">
                </div>
                <button type="submit" class="btn btn-primary mb-2">Update</button>
            </form>
        </div>
        <div class="form-row align-items-center">
            <form action="classlist" method="post">
                <input type="hidden" name="classid" value="${requestScope.classes.id}"/>
                <input type="hidden" name="action" value="assignsubject"/>
                Assign subject: <select name="subjectid">
                <c:forEach items="${requestScope.subjectlist}" var="subject">
                    <option value="${subject.id}">${subject.code}</option>
                </c:forEach>
            </select>
                <button type="submit" class="btn btn-primary">Assign</button>
            </form>
        </div>
    </div>

    <div class="col-lg-1"></div>
</div>

<jsp:include page="footer.jsp"/>

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
