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

        .flashcard-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mt-5 mb-4"><span class="badge badge-pill badge-primary">My Flashcard Sets</span></h2>

    <!-- Search and Filter Section -->
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="Search for flashcard set...">
        <select id="subjectSelect">
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
        <select id="sortSelect">
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
                        <p><strong>Subject Code:</strong> <c:out value="${flashcard.subjectCode}"/></p>
                        <p><strong>Subject Name:</strong> ${flashcard.subjectName}</p>
                        <p><strong>Number of Questions:</strong> ${flashcard.numQuestions}</p>
                        <div class="flashcard-actions">
                            <a class="btn btn-primary"
                               href="${pageContext.request.contextPath}/flashcard-question?flashcardSetId=${flashcard.flashcardSetId}">View
                                Details</a>
                            <div class="dropdown">
                                <button class="btn btn-secondary dropdown-toggle" type="button"
                                        id="dropdownMenuButton${loop.index}" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton${loop.index}">
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/flashcard-edit.jsp?flashcardSetId=${flashcard.flashcardSetId}">Update</a>
                                    <a class="dropdown-item" href="javascript:void(0)"
                                       onclick="confirmDelete(${flashcard.flashcardSetId})">Delete</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Pagination Section -->
    <div id="pagination" class="pagination"></div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this flashcard set?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="deleteFlashcardSet()">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JavaScript and dependencies -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script>
    // Global variables
    let allFlashcards = [];
    let filteredFlashcards = [];
    const itemsPerPage = 3;
    let currentPage = 1;
    let flashcardToDelete = null;

    document.addEventListener("DOMContentLoaded", function () {
        const flashcardElements = document.getElementsByClassName('flashcard');
        for (let i = 0; i < flashcardElements.length; i++) {
            const element = flashcardElements[i];
            allFlashcards.push({
                element: element,
                name: element.querySelector('h4').innerText.toLowerCase(),
                subjectId: element.getAttribute('data-subject-id'),
                numQuestions: parseInt(element.getAttribute('data-num-questions'))
            });
        }

        filteredFlashcards = [...allFlashcards];
        updateDisplay();

        document.getElementById('searchInput').addEventListener('input', filterCards);
        document.getElementById('subjectSelect').addEventListener('change', filterCards);
        document.getElementById('sortSelect').addEventListener('change', sortFlashcards);
    });

    function filterCards() {
        const searchInput = document.getElementById('searchInput').value.toLowerCase();
        const selectedSubjectId = document.getElementById('subjectSelect').value;

        filteredFlashcards = allFlashcards.filter(card => {
            const nameMatch = card.name.includes(searchInput);
            const subjectMatch = selectedSubjectId === "" || card.subjectId === selectedSubjectId;
            return nameMatch && subjectMatch;
        });

        currentPage = 1;
        sortFlashcards();
    }

    function sortFlashcards() {
        const sortOrder = document.getElementById('sortSelect').value;

        filteredFlashcards.sort((a, b) => {
            if (sortOrder === 'asc') {
                return a.numQuestions - b.numQuestions;
            } else {
                return b.numQuestions - a.numQuestions;
            }
        });

        updateDisplay();
    }

    function updateDisplay() {
        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const flashcardContainer = document.querySelector('.flashcard-container');

        flashcardContainer.innerHTML = '';

        for (let i = startIndex; i < endIndex && i < filteredFlashcards.length; i++) {
            flashcardContainer.appendChild(filteredFlashcards[i].element);
        }

        updatePagination();
    }

    function updatePagination() {
        const totalPages = Math.ceil(filteredFlashcards.length / itemsPerPage);
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';

        for (let i = 1; i <= totalPages; i++) {
            const a = document.createElement('a');
            a.href = 'javascript:void(0)';
            a.innerText = i;
            a.className = i === currentPage ? 'active' : '';
            a.onclick = function () {
                currentPage = i;
                updateDisplay();
            };
            pagination.appendChild(a);
        }
    }

    function confirmDelete(flashcardSetId) {
        flashcardToDelete = flashcardSetId;
        $('#deleteModal').modal('show');
    }

    function deleteFlashcardSet() {
        window.location.href = '${pageContext.request.contextPath}/delete-flashcard-set?flashcardSetId=' + flashcardToDelete;
    }
</script>
</body>
</html>
