<%@page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Knowledge Revising System</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp"/>


        <!-- Contact Start -->
        <div class="container-fluid py-5" id="contact-form">
            <div class="container py-5">
                <div class="row align-items-center">
                    <div class="col-lg-5 mb-5 mb-lg-0">
                        <div class="bg-light d-flex flex-column justify-content-center px-5" style="height: 450px;">
                            <div class="d-flex align-items-center mb-5">
                                <div class="btn-icon bg-primary mr-4">
                                    <i class="fa fa-2x fa-map-marker-alt text-white"></i>
                                </div>
                                <div class="mt-n1">
                                    <h4>Our Location</h4>
                                    <p class="m-0">123 Street, New York, USA</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-5">
                                <div class="btn-icon bg-secondary mr-4">
                                    <i class="fa fa-2x fa-phone-alt text-white"></i>
                                </div>
                                <div class="mt-n1">
                                    <h4>Call Us</h4>
                                    <p class="m-0">+012 345 6789</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="btn-icon bg-warning mr-4">
                                    <i class="fa fa-2x fa-envelope text-white"></i>
                                </div>
                                <div class="mt-n1">
                                    <h4>Email Us</h4>
                                    <p class="m-0">info@example.com</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-7">
                        <div class="section-title position-relative mb-4">
                            <h6 class="d-inline-block position-relative text-secondary text-uppercase pb-2">Need Help?</h6>
                            <h1 class="display-4">Send Us A Message</h1>
                            <h5 class="d-inline-block position-relative text-success pb-2">${requestScope.success}</h5>
                            <h5 class="d-inline-block position-relative text-secondary pb-2">${requestScope.err}</h5>
                        </div>
                        <div class="contact-form">
                            <form action="${pageContext.request.contextPath}/contact" method="post">
                                <input type="hidden" name="action" value="enterInfo"/>
                                <div class="row">
                                    <c:if test="${sessionScope.user == null}">
                                        <div class="col-6 form-group">
                                            <input type="text" name="name" 
                                                   class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                                   placeholder="Your Name" value="${requestScope.contact.name}">
                                            <h6 style="color: red; font-style: italic;">${requestScope.contactErr.nameErr}</h6>
                                        </div>
                                        <div class="col-6 form-group">
                                            <input type="text" name="email" 
                                                   class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                                   placeholder="Your Email" value="${requestScope.contact.email}">
                                            <h6 style="color: red; font-style: italic;">${requestScope.contactErr.emailErr}</h6>
                                        </div>
                                    </c:if>
                                    <c:if test="${sessionScope.user != null}">
                                        <div class="col-6 form-group">
                                            <input type="text" name="name"
                                                   class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                                   placeholder="Your Name" value="${sessionScope.user.name}"
                                                   readonly>
                                            <h6 style="color: red; font-style: italic;">${requestScope.contactErr.nameErr}</h6>
                                        </div>
                                        <div class="col-6 form-group">
                                            <input type="text" name="email" 
                                                   class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                                   placeholder="Your Email" value="${sessionScope.user.email}"
                                                   readonly>
                                            <h6 style="color: red; font-style: italic;">${requestScope.contactErr.emailErr}</h6>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="phone" 
                                           class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                           placeholder="Your Phone Number" value="${requestScope.contact.phone}">
                                    <h6 style="color: red; font-style: italic;">${requestScope.contactErr.phoneErr}</h6>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="subject" 
                                           class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                           placeholder="Subject" value="${requestScope.contact.subject}">
                                    <h6 style="color: red; font-style: italic;">${requestScope.contactErr.subjectErr}</h6>
                                </div>
                                <div class="form-group">
                                    <textarea name="message"
                                              class="form-control border-top-0 border-right-0 border-left-0 p-0" 
                                              rows="5" placeholder="Message">${requestScope.contact.message}</textarea>
                                    <h6 style="color: red; font-style: italic;">${requestScope.contactErr.messageErr}</h6>
                                </div>
                                <div>
                                    <button class="btn btn-primary py-3 px-5" type="submit">Send Message</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->

        <jsp:include page="/WEB-INF/common/footer.jsp"/>


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary rounded-0 btn-lg-square back-to-top"><i class="fa fa-angle-double-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>

        <script src="js/header.js"></script>
    </body>

</html>