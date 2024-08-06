<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Knowledge Revising System - My Flashcards</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles for Flashcards -->
    <style>
        .flashcard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 30px;
        }

        .flashcard {
            width: 300px;
            margin-bottom: 20px;
            padding: 20px;
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }

        .flashcard:hover {
            transform: scale(1.05);
        }

        .flashcard h4 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .flashcard p {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #6c757d;
        }

        .search-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .search-container input[type=text], .search-container select {
            padding: 10px;
            font-size: 17px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .search-container input[type=text] {
            flex: 1;
            margin-right: 10px;
        }

        .search-container select {
            width: 200px;
        }

        .sorting-container {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }

        .sorting-container label {
            margin-right: 10px;
            font-size: 17px;
        }

        .sorting-container select {
            padding: 10px;
            font-size: 17px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .add-flashcard-btn {
            margin-left: 20px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #4caf50;
            color: white;
            border: 1px solid #4caf50;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
    </style>
    <script>
        var currentPage = 1;
        var itemsPerPage = 3;

        function showPage(page) {
            var cards = document.getElementsByClassName('flashcard');
            var totalPages = Math.ceil(cards.length / itemsPerPage);

            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;

            currentPage = page;

            for (var i = 0; i < cards.length; i++) {
                cards[i].style.display = "none";
            }

            for (var i = (page - 1) * itemsPerPage; i < (page * itemsPerPage) && i < cards.length; i++) {
                cards[i].style.display = "block";
            }

            updatePagination(totalPages);
        }

        function updatePagination(totalPages) {
            var pagination = document.getElementById('pagination');
            pagination.innerHTML = '';

            for (var i = 1; i <= totalPages; i++) {
                var a = document.createElement('a');
                a.href = 'javascript:void(0)';
                a.innerHTML = i;
                a.onclick = (function (page) {
                    return function () {
                        showPage(page);
                    }
                })(i);

                if (i === currentPage) {
                    a.className = 'active';
                }

                pagination.appendChild(a);
            }
        }

        function filterCards() {
            var input = document.getElementById('searchInput').value.toUpperCase();
            var cards = document.getElementsByClassName('flashcard');

            for (var i = 0; i < cards.length; i++) {
                var title = cards[i].getElementsByTagName("h4")[0].textContent.toUpperCase();
                cards[i].style.display = title.indexOf(input) > -1 ? "block" : "none";
            }

            showPage(1);
        }

        function filterBySubject() {
            var selectedSubjectId = document.getElementById("subjectSelect").value;
            var cards = document.getElementsByClassName('flashcard');

            for (var i = 0; i < cards.length; i++) {
                var subjectId = cards[i].getAttribute("data-subject-id");
                cards[i].style.display = selectedSubjectId === "" || subjectId === selectedSubjectId ? "block" : "none";
            }

            showPage(1);
        }

        function sortCards() {
            var sortOrder = document.getElementById("sortSelect").value;
            var cardsContainer = document.querySelector('.flashcard-container');
            var cards = Array.from(cardsContainer.getElementsByClassName('flashcard'));

            cards.sort(function (a, b) {
                var numQuestionsA = parseInt(a.getAttribute('data-num-questions'), 10);
                var numQuestionsB = parseInt(b.getAttribute('data-num-questions'), 10);
                return sortOrder === 'asc' ? numQuestionsA - numQuestionsB : numQuestionsB - numQuestionsA;
            });

            cardsContainer.innerHTML = '';
            cards.forEach(function (card) {
                cardsContainer.appendChild(card);
            });

            showPage(currentPage);
        }

        window.onload = function () {
            showPage(currentPage);
        }
    </script>
</head>
<body>

<div class="container">
    <h2 class="text-center mt-5 mb-4"><span class="badge badge-pill badge-primary">My Flashcard Sets</span></h2>

    <!-- Search and Filter Section -->
    <div class="search-container">
        <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Search for flashcard set...">
        <select id="subjectSelect" onchange="filterBySubject()">
            <option value="">All Subjects</option>
            <c:forEach var="subject" items="${sessionScope.subjects}">
                <option value="${subject.id}">${subject.code}</option>
            </c:forEach>
        </select>
        <a href="${pageContext.request.contextPath}/flashcard-add.jsp" class="btn btn-success add-flashcard-btn">Add
            Flashcard</a>
    </div>

    <!-- Sorting Section -->
    <div class="sorting-container mt-4">
        <label for="sortSelect">Sort by Number of Questions:</label>
        <select id="sortSelect" onchange="sortCards()">
            <option value="asc">Ascending</option>
            <option value="desc">Descending</option>
        </select>
    </div>

    <!-- Flashcard Display Section -->
    <div class="flashcard-container">
        <c:choose>
            <c:when test="${empty sessionScope.userFlashcards}">
                <p>No flashcard sets available.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="flashcard" items="${sessionScope.userFlashcards}" varStatus="loop">
                    <div class="flashcard" data-subject-id="${flashcard.subjectId}"
                         data-num-questions="${flashcard.numQuestions}">
                        <h4>${flashcard.name}</h4>
                        <p><strong>Subject Code:</strong> ${flashcard.subjectCode}</p>
                        <p><strong>Subject Name:</strong> ${flashcard.subjectName}</p>
                        <p><strong>Number of Questions:</strong> ${flashcard.numQuestions}</p>
                        <a href="${pageContext.request.contextPath}/FlashcardQuestionServlet?flashcardSetId=${flashcard.flashcardSetId}"
                           class="btn btn-primary">Learn Now</a>
                    </div>
                </c:forEach>

            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination Section -->
    <div class="pagination" id="pagination"></div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>
