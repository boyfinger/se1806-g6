<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Subject list</title>
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

<div class="container">
    <div class="row px-xl-5">
        <div>
            <a class="btn btn-primary px-3" href="newsubject">
                <i class="fa fa-plus-square mr-3"></i>
                Add subject
            </a>
        </div>
        <br/><br/>
        <div class="table-responsive">
            <table class="table">
                <tr class="table-primary">
                    <th>#</th>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <c:forEach items="${requestScope.list}" var="subject">
                    <form action="subjectdetails" method="get">
                        <input type="hidden" name="id" value="${subject.id}"/>
                        <input type="hidden" name="action" value="viewsubjectdetails"/>
                        <input type="hidden" name="status" value="${subject.status}"/>
                        <tr>
                            <td>${subject.id}</td>
                            <td>${subject.code}</td>
                            <td>${subject.name}</td>
                            <td>${subject.status}</td>
                            <td>
                                <button class="btn btn-primary py-2 px-4 mr-3" data-toggle="tooltip"
                                        data-placement="bottom" title="View details">
                                    <i class="fa fa-eye"></i>
                                </button>
                                <c:if test="${subject.status == 'Active'}">
                                    <button class="btn btn-primary py-2 px-4 mr-3" name="changestatus"
                                            data-toggle="tooltip" data-placement="bottom" title="Deactivate">
                                        <i class="fa fa-ban"></i>
                                    </button>
                                </c:if>
                                <c:if test="${subject.status == 'Inactive'}">
                                    <button class="btn btn-primary py-2 px-4 mr-3" name="changestatus"
                                            data-toggle="tooltip" data-placement="bottom" title="Activate">
                                        <i class="fa fa-check"></i>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
            </table>
        </div>
    </div>
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
