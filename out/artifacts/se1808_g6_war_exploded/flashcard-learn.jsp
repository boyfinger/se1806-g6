<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Flashcard Learn</title>
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
            border: 2px solid transparent; /* Initial transparent border */
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
            border: 2px dashed #28a745; /* Green dashed border for selected option */
        }

        .answers button.disabled {
            pointer-events: none;
        }

        .result {
            margin-top: 20px;
            text-align: center;
            font-size: 18px;
        }

        .reveal-answer {
            margin-top: 20px;
            text-align: center;
        }

        .reveal-answer button {
            padding: 10px 20px;
            font-size: 16px;
        }

        .reveal-answer p {
            display: none;
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

    <div class="reveal-answer">
        <button class="btn btn-info" onclick="revealAnswer()">Reveal Answer</button>
        <p id="revealedAnswer"></p>
    </div>

    <div class="navigation-buttons mt-3">
        <button class="btn btn-primary" onclick="previousFlashcard()">Previous</button>

        <div class="pagination">
            <span id="currentQuestion"></span> / <span id="totalQuestions"></span>
        </div>

        <button class="btn btn-primary" onclick="nextFlashcard()">Next</button>
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
<!-- JavaScript for Dynamic Flashcard Navigation -->
<script>
    let currentFlashcardIndex = 0;
    let answeredFlashcards = [];

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
        let question = flashcards[currentFlashcardIndex];
        document.getElementById('term').innerText = question.term;

        let correctAnswer = {questionId: question.questionId, answer: question.definition};
        let answers = getRandomAnswers(correctAnswer);

        if (answeredFlashcards[currentFlashcardIndex]) {
            answers = answeredFlashcards[currentFlashcardIndex].answers;
        }

        document.getElementById('option1').querySelector('.option-text').innerText = answers[0].answer;
        document.getElementById('option2').querySelector('.option-text').innerText = answers[1].answer;
        document.getElementById('option3').querySelector('.option-text').innerText = answers[2].answer;
        document.getElementById('option4').querySelector('.option-text').innerText = answers[3].answer;

        resetButtons();
        updatePagination();
        showSelectedAnswer(currentFlashcardIndex);
    }

    function resetButtons() {
        let buttons = document.querySelectorAll('.answers button');
        buttons.forEach(button => {
            button.disabled = false;
            button.classList.remove('correct', 'wrong', 'selected');
        });
        document.getElementById('answerResult').innerText = '';
    }

    function updatePagination() {
        document.getElementById('currentQuestion').textContent = currentFlashcardIndex + 1;
    }

    function nextFlashcard() {
        if (currentFlashcardIndex < flashcards.length - 1) {
            currentFlashcardIndex++;
            displayCard();
        }
    }

    function previousFlashcard() {
        if (currentFlashcardIndex > 0) {
            currentFlashcardIndex--;
            displayCard();
        }
    }

    function showSelectedAnswer(index) {
        let answerData = answeredFlashcards[index];
        if (answerData) {
            document.getElementById(answerData.buttonId).classList.add('selected');
            document.getElementById(answerData.buttonId).classList.add(answerData.isCorrect ? 'correct' : 'wrong');
            document.getElementById('answerResult').innerText = answerData.isCorrect ? 'Correct!' : 'Incorrect!';
            document.getElementById('answerResult').style.color = answerData.isCorrect ? '#28a745' : '#dc3545';

            // Disable all answer buttons
            document.querySelectorAll('.answers button').forEach(button => {
                button.disabled = true;
            });

            // Highlight correct answer
            document.querySelectorAll('.answers button').forEach(button => {
                if (button.querySelector('.option-text').innerText === flashcards[index].definition) {
                    button.classList.add('correct');
                } else {
                    button.classList.add('wrong');
                }
            });
        }
    }

    function checkAnswer(button) {
        let selectedAnswer = button.querySelector('.option-text').innerText;
        let question = flashcards[currentFlashcardIndex];
        let correctAnswer = question.definition;
        let isCorrect = selectedAnswer === correctAnswer;

        button.classList.add(isCorrect ? 'correct' : 'wrong');
        button.disabled = true;
        button.classList.add('selected');

        answeredFlashcards[currentFlashcardIndex] = {
            buttonId: button.id,
            isCorrect: isCorrect,
            answers: [
                {answer: document.getElementById('option1').querySelector('.option-text').innerText},
                {answer: document.getElementById('option2').querySelector('.option-text').innerText},
                {answer: document.getElementById('option3').querySelector('.option-text').innerText},
                {answer: document.getElementById('option4').querySelector('.option-text').innerText}
            ]
        };

        document.getElementById('answerResult').innerText = isCorrect ? 'Correct!' : 'Incorrect!';
        document.getElementById('answerResult').style.color = isCorrect ? '#28a745' : '#dc3545';

        // Disable all answer buttons after selection
        document.querySelectorAll('.answers button').forEach(button => {
            button.disabled = true;
        });
    }

    function revealAnswer() {
        let question = flashcards[currentFlashcardIndex];
        let correctAnswer = question.definition;

        document.querySelectorAll('.answers button').forEach(button => {
            if (button.querySelector('.option-text').innerText === correctAnswer) {
                button.classList.add('correct');
            } else {
                button.classList.add('wrong');
            }
            button.disabled = true;
        });

        answeredFlashcards[currentFlashcardIndex] = {
            buttonId: null,
            isCorrect: false,
            answers: [
                {answer: document.getElementById('option1').querySelector('.option-text').innerText},
                {answer: document.getElementById('option2').querySelector('.option-text').innerText},
                {answer: document.getElementById('option3').querySelector('.option-text').innerText},
                {answer: document.getElementById('option4').querySelector('.option-text').innerText}
            ]
        };

        document.getElementById('answerResult').innerText = 'Answer revealed!';
        document.getElementById('answerResult').style.color = '#007bff';
    }

    function finishStudy() {
        window.location.href = "${pageContext.request.contextPath}/flashcard-question?flashcardSetId=${sessionScope.flashcardSetId}";
    }
</script>
</body>
</html>
