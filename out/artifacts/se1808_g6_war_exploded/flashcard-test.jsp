<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Flashcard Test</title>
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
            position: relative;
            pointer-events: none;
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

        .answers {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        .answers button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            width: calc(50% - 20px);
            min-height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            transition: background-color 0.3s ease, border 0.3s ease;
            text-align: center;
            border: 2px solid transparent;
        }

        .answers button.correct {
            background-color: #28a745 !important;
            color: #fff;
            border: none;
        }

        .answers button.wrong {
            background-color: #dc3545 !important;
            color: #fff;
            border: none;
        }

        .answers button.selected {
            border: 2px dashed #28a745;
        }

        .answers button.disabled {
            pointer-events: none;
        }

        .result {
            margin-top: 20px;
            text-align: center;
            font-size: 18px;
        }

        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .navigation-buttons .btn {
            margin: 0 10px;
        }

        .pagination {
            text-align: center;
            margin-top: 10px;
        }

        .pagination span {
            font-size: 14px;
            margin: 0 5px;
        }

        .go-back-button {
            display: block;
            margin: 20px auto;
        }

        .report-card {
            margin-top: 30px;
            text-align: center;
        }

        .report-card p {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .report-card .score {
            font-size: 24px;
            font-weight: bold;
        }

        /* Custom popup styles */
        .modal-content {
            padding: 20px;
        }

        .modal-header {
            border-bottom: none;
        }

        .modal-body {
            text-align: center;
        }

        .modal-footer {
            border-top: none;
            justify-content: center;
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
    <div class="flashcard-container">
        <div class="flashcard">
            <div class="flashcard-content flashcard-front">
                <h4 id="term"></h4>
            </div>
            <div class="flashcard-content flashcard-back">
                <h4 id="definition"></h4>
            </div>
        </div>
    </div>

    <div class="answers">
        <button class="btn btn-primary" onclick="checkAnswer(this)" id="option1"><span class="option-text"></span>
        </button>
        <button class="btn btn-primary" onclick="checkAnswer(this)" id="option2"><span class="option-text"></span>
        </button>
        <button class="btn btn-primary" onclick="checkAnswer(this)" id="option3"><span class="option-text"></span>
        </button>
        <button class="btn btn-primary" onclick="checkAnswer(this)" id="option4"><span class="option-text"></span>
        </button>
    </div>

    <div class="result">
        <p id="answerResult"></p>
    </div>

    <div class="navigation-buttons mt-3">
        <button class="btn btn-primary" onclick="previousFlashcard()">Previous</button>

        <div class="pagination">
            <span id="currentQuestion"></span> / <span id="totalQuestions"></span>
        </div>

        <button class="btn btn-primary" onclick="nextFlashcard()">Next</button>
    </div>

    <div class="go-back-button">
        <button class="btn btn-secondary" onclick="finishTest()">Finish Test</button>
    </div>
</div>

<!-- Report Popup -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reportModalLabel">Test Results</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>You answered <span id="correctAnswers"></span> out of <span id="totalQuestions"></span> questions
                    correctly.</p>
                <p>Your score: <span class="score" id="score"></span> / 10</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="goBack()">Go Back</button>
            </div>
        </div>
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
    let answeredFlashcards = [];
    let correctAnswersCount = 0;
    let isTestFinished = false; // Flag to check if the test is finished

    const flashcards = [
        <c:forEach var="question" items="${flashcardQuestions}">
        {
            questionId: ${question.questionId},
            term: '<c:out value="${question.term}"/>',
            definition: '<c:out value="${question.definition}"/>'
        }<c:if test="${!questionStatus.last}">, </c:if>
        </c:forEach>
    ];

    const allAnswers = [
        <c:forEach var="answer" items="${allAnswers}">
        {
            questionId: ${answer.questionId},
            answer: '<c:out value="${answer.answer}"/>'
        }<c:if test="${!answerStatus.last}">, </c:if>
        </c:forEach>
    ];

    const flashcardOptions = Array(flashcards.length).fill(null);
    const flashcardSelections = Array(flashcards.length).fill(null);

    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('totalQuestions').textContent = flashcards.length;
        displayCard();
    });

    function getRandomAnswers(correctAnswer) {
        let answers = allAnswers.filter(answer => answer.questionId !== correctAnswer.questionId);
        if (answers.length >= 3) {
            answers = answers.sort(() => 0.5 - Math.random()).slice(0, 3);
        }
        answers.push(correctAnswer);
        return answers.sort(() => 0.5 - Math.random());
    }

    function displayCard() {
        const question = flashcards[currentFlashcardIndex];
        document.getElementById('term').innerText = question.term;
        document.getElementById('definition').innerText = question.definition;
        document.getElementById('currentQuestion').innerText = currentFlashcardIndex + 1;
        document.getElementById('answerResult').innerText = '';

        if (!flashcardOptions[currentFlashcardIndex]) {
            flashcardOptions[currentFlashcardIndex] = getRandomAnswers({
                questionId: question.questionId,
                answer: question.definition
            });
        }

        flashcardOptions[currentFlashcardIndex].forEach((option, index) => {
            let button = document.getElementById('option' + (index + 1));
            button.innerText = option.answer;
            button.className = 'btn btn-primary';
            button.disabled = false;
            if (flashcardSelections[currentFlashcardIndex] === index) {
                button.classList.add('selected');
                button.disabled = true;
            }
        });

        // Disable options if the question has been answered
        if (answeredFlashcards.includes(currentFlashcardIndex) || isTestFinished) {
            document.querySelectorAll('.answers button').forEach(button => {
                button.disabled = true;
                const selectedIndex = flashcardSelections[currentFlashcardIndex];
                const correctAnswer = flashcards[currentFlashcardIndex].definition;
                const selectedAnswer = button.innerText;

                if (selectedAnswer === correctAnswer) {
                    button.classList.add('correct');
                } else if (selectedIndex !== null && selectedIndex.toString() === button.id.charAt(6)) {
                    button.classList.add('wrong');
                }
            });
        }
    }

    function checkAnswer(button) {
        let selectedAnswer = button.innerText;
        let correctAnswer = flashcards[currentFlashcardIndex].definition;
        let selectedIndex = Array.from(button.parentElement.children).indexOf(button);

        // Highlight the selected answer
        if (selectedAnswer === correctAnswer) {
            button.classList.add('correct');
            correctAnswersCount++;
            document.getElementById('answerResult').innerText = 'Correct!';
        } else {
            button.classList.add('wrong');
            // Highlight the correct answer
            flashcardOptions[currentFlashcardIndex].forEach((option, index) => {
                if (option.answer === correctAnswer) {
                    document.getElementById('option' + (index + 1)).classList.add('correct');
                }
            });
            document.getElementById('answerResult').innerText = 'Incorrect!';
        }

        // Disable all buttons and mark the selected one
        flashcardOptions[currentFlashcardIndex].forEach((option, index) => {
            let btn = document.getElementById('option' + (index + 1));
            btn.disabled = true;
            if (index === selectedIndex) {
                if (selectedAnswer === correctAnswer) {
                    btn.classList.add('correct');
                } else {
                    btn.classList.add('wrong');
                }
            }
        });

        // Add the answer to the answeredFlashcards array
        if (!answeredFlashcards.includes(currentFlashcardIndex)) {
            answeredFlashcards.push(currentFlashcardIndex);
        }
    }

    function nextFlashcard() {
        if (currentFlashcardIndex < flashcards.length - 1) {
            currentFlashcardIndex++;
            displayCard();
        } else {
            finishTest();
        }
    }

    function previousFlashcard() {
        if (currentFlashcardIndex > 0) {
            currentFlashcardIndex--;
            displayCard();
        }
    }

    function finishTest() {
        isTestFinished = true;
        document.querySelector('.flashcard-container').style.display = 'none';
        document.querySelector('.answers').style.display = 'none';
        document.querySelector('.navigation-buttons').style.display = 'none';

        // Show the report modal
        document.getElementById('correctAnswers').innerText = correctAnswersCount;
        document.getElementById('score').innerText = (correctAnswersCount / flashcards.length * 10).toFixed(2);
        $('#reportModal').modal('show');
    }

    function goBack() {
        window.location.href = "${pageContext.request.contextPath}/flashcard-question?flashcardSetId=${sessionScope.flashcardSetId}";
    }
</script>
</body>
</html>
