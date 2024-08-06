<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Flashcard Questions</title>
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

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles for Flashcards -->
    <style>
        .flashcard-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            perspective: 1000px;
        }

        .flashcard {
            width: 400px;
            height: 300px;
            margin-bottom: 20px;
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.6s;
            transform-style: preserve-3d;
            position: relative;
        }

        .flashcard.flip {
            transform: rotateY(180deg);
        }

        .flashcard-content {
            width: 100%;
            height: 100%;
            text-align: center;
            position: absolute;
            backface-visibility: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            box-sizing: border-box;
        }

        .flashcard-back {
            transform: rotateY(180deg);
        }

        .terms-list {
            margin-top: 20px;
        }

        .terms-list ul {
            list-style-type: none;
            padding: 0;
        }

        .terms-list li {
            padding: 5px;
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 4px;
            margin-bottom: 5px;
        }

        .navigation-buttons {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .navigation-buttons .btn {
            margin: 0 10px;
        }

        .extra-buttons {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .extra-buttons .btn {
            margin: 0 10px;
        }

        .dropdown-menu {
            display: none;
        }

        .dropdown-menu.show {
            display: block;
        }
    </style>
</head>
<body>
<%-- Header --%>
<jsp:include page="header1.jsp"/>

<h1 class="text-center mt-5 mb-4">
    <span class="badge badge-pill badge-primary">${sessionScope.flashcardSetName}</span>
</h1>

<%-- Flashcard Content --%>
<div class="container">

    <div class="flashcard-container">
        <div class="flashcard" onclick="flipFlashcard()">
            <div class="flashcard-content flashcard-front">
                <h4 id="term"></h4>
            </div>
            <div class="flashcard-content flashcard-back">
                <h4 id="definition"></h4>
            </div>
        </div>
    </div>

    <div class="navigation-buttons">
        <button class="btn bg-light" onclick="prevFlashcard()"><i class="fas fa-arrow-left"></i></button>
        <button class="btn bg-light" onclick="nextFlashcard()"><i class="fas fa-arrow-right"></i></button>
    </div>

    <div class="extra-buttons">
        <a href="${pageContext.request.contextPath}/flashcard-learn?flashcardSetId=${sessionScope.flashcardSetId}"
           class="btn btn-primary">Learn</a>
        <a href="${pageContext.request.contextPath}/flashcard-match?flashcardSetId=${sessionScope.flashcardSetId}"
           class="btn btn-primary">Match</a>
        <a href="${pageContext.request.contextPath}/flashcard-test?flashcardSetId=${sessionScope.flashcardSetId}"
           class="btn btn-primary">Test</a>
        <!-- Three-Dot Menu for Owner -->
        <c:if test="${sessionScope.isOwner}">
            <div class="dropdown">
                <button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-ellipsis-v"></i>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item"
                       href="${pageContext.request.contextPath}/flashcard-edit?flashcardSetId=${sessionScope.flashcardSetId}">Edit
                        Flashcard Set</a>
                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#deleteModal">Delete
                        Flashcard Set</a>
                </div>
            </div>
        </c:if>
    </div>

    <div class="terms-list">
        <h5>Total Terms: <c:out value="${sessionScope.flashcardQuestions.size()}"/></h5>
        <ul>
            <c:forEach var="question" items="${sessionScope.flashcardQuestions}">
                <li><strong>Term:</strong> <c:out value="${question.term}"/> <br> <strong>Definition:</strong> <c:out
                        value="${question.definition}"/></li>
            </c:forEach>
        </ul>
    </div>
</div>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<!-- JavaScript for Dynamic Flashcard Navigation -->
<script>
    let currentFlashcardIndex = 0;
    const flashcards = [
        <c:forEach var="question" items="${sessionScope.flashcardQuestions}">
        {
            term: '<c:out value="${question.term}"/>',
            definition: '<c:out value="${question.definition}"/>'
        }<c:if test="${!questionStatus.last}">, </c:if>
        </c:forEach>
    ];

    document.addEventListener('DOMContentLoaded', (event) => {
        updateFlashcard();
    });

    function flipFlashcard() {
        const flashcardElement = document.querySelector('.flashcard');
        flashcardElement.classList.toggle('flip');
    }

    function updateFlashcard() {
        const termElement = document.getElementById('term');
        const definitionElement = document.getElementById('definition');
        termElement.innerHTML = flashcards[currentFlashcardIndex].term;
        definitionElement.innerHTML = flashcards[currentFlashcardIndex].definition;
    }

    function nextFlashcard() {
        currentFlashcardIndex = (currentFlashcardIndex + 1) % flashcards.length;
        updateFlashcard();
        document.querySelector('.flashcard').classList.remove('flip'); // Reset flip state
    }

    function prevFlashcard() {
        currentFlashcardIndex = (currentFlashcardIndex - 1 + flashcards.length) % flashcards.length;
        updateFlashcard();
        document.querySelector('.flashcard').classList.remove('flip'); // Reset flip state
    }
</script>

<!-- Bootstrap Modal for Delete Confirmation -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this flashcard set? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <a href="${pageContext.request.contextPath}/flashcard-delete?flashcardSetId=${sessionScope.flashcardSetId}"
                   class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
