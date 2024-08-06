<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Flashcard Match</title>
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

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles for Flashcards -->
    <style>
        .flashcard-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 15px;
            margin-top: 30px;
        }

        .flashcard {
            padding: 20px;
            background-color: #f8f9fa; /* Light grey background */
            border: 1px solid #ced4da;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); /* Adding a subtle shadow */
        }

        .flashcard.correct {
            background-color: #28a745 !important;
            color: #fff;
        }

        .flashcard.wrong {
            background-color: #dc3545 !important;
            color: #fff;
        }

        .flashcard.selected {
            border: 2px dashed #007bff;
        }

        .navigation-buttons {
            display: flex;
            justify-content: center; /* Center align navigation buttons */
            align-items: center;
            margin-top: 20px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
        }

        .pagination a {
            font-size: 14px;
            margin: 0 5px;
            cursor: pointer;
            text-decoration: none;
            color: #007bff;
        }

        .pagination a.active {
            font-weight: bold;
        }

        .go-back-button {
            display: block;
            margin: 20px auto;
        }
    </style>
</head>
<body>
<%-- Header --%>
<jsp:include page="header1.jsp"/>

<h2 class="text-center mt-5 mb-4">
    <span class="badge badge-pill badge-primary">${sessionScope.flashcardSetName}</span>
</h2>
<%-- Flashcard Content --%>
<div class="container">
    <div class="flashcard-container" id="flashcardContainer">
        <c:forEach var="flashcard" items="${flashcards}" varStatus="loop">
            <div class="flashcard" data-question-id="${flashcard.questionId}" data-type="term">
                    ${flashcard.term}
            </div>
            <div class="flashcard" data-question-id="${flashcard.questionId}" data-type="definition">
                    ${flashcard.definition}
            </div>
        </c:forEach>
    </div>

    <div class="navigation-buttons mt-3">
        <button class="btn btn-primary" id="prevPageBtn" onclick="prevPage()">Previous</button>
        <div class="pagination" id="pagination"></div>
        <button class="btn btn-primary" id="nextPageBtn" onclick="nextPage()">Next</button>
    </div>

    <div class="go-back-button">
        <button class="btn btn-secondary" onclick="finishStudy()">Finish Studying</button>
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
<!-- JavaScript for Dynamic Flashcard Match -->
<script>
    let selectedCards = [];
    let flashcardPages = [];
    let currentPage = 0;
    const itemsPerPage = 8; // Each page will contain 8 pairs (16 flashcards)

    document.addEventListener('DOMContentLoaded', () => {
        initializeFlashcards();
        updatePagination();
        displayFlashcards();
    });

    function initializeFlashcards() {
        // Collect all terms and definitions
        const allTerms = [...document.querySelectorAll('.flashcard[data-type="term"]')];
        const allDefinitions = [...document.querySelectorAll('.flashcard[data-type="definition"]')];

        // Divide into pages and ensure matching pairs
        for (let i = 0; i < allTerms.length; i += itemsPerPage) {
            const pageTerms = allTerms.slice(i, i + itemsPerPage);
            const pageDefinitions = allDefinitions.slice(i, i + itemsPerPage);

            // Combine and shuffle within the page to create randomness
            const pageContent = shuffleArray([...pageTerms, ...pageDefinitions]);
            flashcardPages.push(pageContent);
        }

        // Add click event listeners to each flashcard
        document.querySelectorAll('.flashcard').forEach(card => {
            card.addEventListener('click', () => {
                if (selectedCards.length < 2 && !card.classList.contains('correct') && !card.classList.contains('selected')) {
                    card.classList.add('selected');
                    selectedCards.push(card);

                    if (selectedCards.length === 2) {
                        checkMatch();
                    }
                }
            });
        });
    }

    function shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }

    function displayFlashcards() {
        const container = document.getElementById('flashcardContainer');
        container.innerHTML = '';
        const currentPageCards = flashcardPages[currentPage];

        currentPageCards.forEach(card => container.appendChild(card));
    }

    function updatePagination() {
        const totalPages = flashcardPages.length;
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';

        for (let i = 0; i < totalPages; i++) {
            const pageLink = document.createElement('a');
            pageLink.innerText = i + 1;
            pageLink.onclick = () => goToPage(i);
            if (i === currentPage) {
                pageLink.classList.add('active');
            }
            pagination.appendChild(pageLink);
        }

        document.getElementById('prevPageBtn').disabled = currentPage === 0;
        document.getElementById('nextPageBtn').disabled = currentPage === totalPages - 1;
    }

    function prevPage() {
        if (currentPage > 0) {
            currentPage--;
            displayFlashcards();
            updatePagination();
        }
    }

    function nextPage() {
        if (currentPage < flashcardPages.length - 1) {
            currentPage++;
            displayFlashcards();
            updatePagination();
        }
    }

    function goToPage(page) {
        currentPage = page;
        displayFlashcards();
        updatePagination();
    }

    function finishStudy() {
        window.location.href = "${pageContext.request.contextPath}/flashcard-question?flashcardSetId=${sessionScope.flashcardSetId}";
    }

    function checkMatch() {
        const [card1, card2] = selectedCards;
        const questionId1 = card1.dataset.questionId;
        const questionId2 = card2.dataset.questionId;

        if (questionId1 === questionId2) {
            card1.classList.add('correct');
            card2.classList.add('correct');
        } else {
            card1.classList.add('wrong');
            card2.classList.add('wrong');
        }

        setTimeout(() => {
            card1.classList.remove('selected', 'wrong');
            card2.classList.remove('selected', 'wrong');
            selectedCards = [];
        }, 1000);
    }
</script>
</body>
</html>
