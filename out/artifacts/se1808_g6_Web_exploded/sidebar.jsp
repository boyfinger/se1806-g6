<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside class="sidebar">
    <div class="text-center my-4">
        <c:set var="avatarPath"
               value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/${sessionScope.user.avatar}"/>
        <img src="${avatarPath}" alt="User Avatar" class="rounded-circle" width="100" height="100">
    </div>
    <div class="menu-inner-shadow"></div>

    <ul class="menu-vertical py-1">
        <li class="menu-header small text-uppercase">
            <span class="menu-header-text">Navigation</span>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-link" onclick="loadContent('profile')">
                <i class="menu-icon tf-icons bx bx-user"></i>
                <div data-i18n="Profile">Profile</div>
            </a>
        </li>
        <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link" onclick="loadContent('userCourse')">
                <i class="menu-icon tf-icons bx bx-book"></i>
                <div data-i18n="My Courses">My Courses</div>
            </a>
        </li>
        <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link" onclick="loadContent('userFlashcard')">
                <i class="menu-icon tf-icons bx bx-bookmark"></i>
                <div data-i18n="My Flashcard Sets">My Flashcard Sets</div>
            </a>
        </li>
        <li class="menu-item">
            <a href="javascript:void(0);" class="menu-link" onclick="loadContent('change-password')">
                <i class="menu-icon tf-icons bx bx-lock"></i>
                <div data-i18n="Change Password">Change Password</div>
            </a>
        </li>
        <li class="menu-item">
            <a href="${pageContext.request.contextPath}/logout" class="menu-link">
                <i class="menu-icon tf-icons bx bx-power-off"></i>
                <div data-i18n="Log Out">Log Out</div>
            </a>
        </li>
    </ul>
</aside>
<!-- / Menu -->

<!-- build:js assets/vendor/js/core.js -->
<script src="assets/vendor/libs/jquery/jquery.js"></script>
<script src="assets/vendor/libs/popper/popper.js"></script>
<script src="assets/vendor/js/bootstrap.js"></script>
<script src="assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="assets/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->
<script src="assets/vendor/libs/apex-charts/apexcharts.js"></script>
<!-- Main JS -->
<script src="assets/js/main.js"></script>
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<script>
    function loadContent(page) {
        $.ajax({
            url: "${pageContext.request.contextPath}/profile/" + page,
            type: "GET",
            success: function (data) {
                $("#mainContent").html(data);
            },
            error: function (xhr, status, error) {
                console.error("Error loading content:", error);
                alert("Failed to load content. Please try again.");
            }
        });
    }
</script>
