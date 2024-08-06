<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Flashcard Set</title>
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
    <style>
        .table {
            margin-top: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .delete-button {
            color: red;
            cursor: pointer;
            font-size: 1.5em;
        }

        .warning {
            color: red;
            margin-top: 10px;
        }

        .input-group {
            position: relative;
        }

        .warning-icon {
            color: red;
            position: absolute;
            top: 50%;
            left: -25px;
            transform: translateY(-50%);
            display: none;
            cursor: pointer;
        }

        .form-control {
            padding-right: 30px;
        }

        .warning-icon:hover::after {
            content: attr(data-warning);
            color: black;
            background-color: #ffc107;
            padding: 2px 5px;
            border-radius: 3px;
            position: absolute;
            top: -25px;
            left: 20px;
            white-space: nowrap;
            z-index: 10;
        }
    </style>
    <script>
        function addRow() {
            var table = document.getElementById("flashcardTable");
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount - 1);

            var cell1 = row.insertCell(0);
            var element1 = document.createElement("div");
            element1.className = "input-group";
            var input1 = document.createElement("input");
            input1.type = "text";
            input1.name = "term[]";
            input1.className = "form-control";
            input1.oninput = validateForm;
            var warningIcon1 = document.createElement("i");
            warningIcon1.className = "fa fa-exclamation-circle warning-icon";
            warningIcon1.setAttribute("aria-hidden", "true");
            warningIcon1.setAttribute("data-warning", "Term cannot be empty or duplicated");
            element1.appendChild(input1);
            element1.appendChild(warningIcon1);
            cell1.appendChild(element1);

            var cell2 = row.insertCell(1);
            var element2 = document.createElement("div");
            element2.className = "input-group";
            var input2 = document.createElement("input");
            input2.type = "text";
            input2.name = "definition[]";
            input2.className = "form-control";
            input2.oninput = validateForm;
            var warningIcon2 = document.createElement("i");
            warningIcon2.className = "fa fa-exclamation-circle warning-icon";
            warningIcon2.setAttribute("aria-hidden", "true");
            warningIcon2.setAttribute("data-warning", "Definition cannot be empty or duplicated");
            element2.appendChild(input2);
            element2.appendChild(warningIcon2);
            cell2.appendChild(element2);

            var cell3 = row.insertCell(2);
            var deleteButton = document.createElement("span");
            deleteButton.className = "delete-button";
            deleteButton.innerHTML = '<i class="fa fa-minus" aria-hidden="true"></i>';
            deleteButton.onclick = function () {
                deleteRow(this);
            };
            cell3.appendChild(deleteButton);

            validateForm();
        }

        function deleteRow(button) {
            var row = button.parentNode.parentNode;
            row.parentNode.removeChild(row);
            validateForm();
        }

        function validateForm() {
            var terms = document.getElementsByName("term[]");
            var definitions = document.getElementsByName("definition[]");
            var title = document.getElementById("title");
            var createButton = document.querySelector("button[type='submit']");
            var warning = document.getElementById("warning");
            var termSet = new Set();
            var definitionSet = new Set();
            var valid = true;

            // Validate title
            var titleWarningIcon = document.getElementById("titleWarningIcon");
            if (title.value.trim() === "") {
                valid = false;
                titleWarningIcon.style.display = "inline";
                titleWarningIcon.setAttribute("data-warning", "Title cannot be empty");
            } else {
                titleWarningIcon.style.display = "none";
            }

            // Validate terms and definitions
            for (var i = 0; i < terms.length; i++) {
                var term = terms[i].value.trim().toLowerCase();
                var definition = definitions[i].value.trim().toLowerCase();
                var warningIconTerm = terms[i].nextElementSibling;
                var warningIconDefinition = definitions[i].nextElementSibling;

                warningIconTerm.style.display = "none";
                warningIconDefinition.style.display = "none";

                if (term === "" || definition === "") {
                    valid = false;
                    if (term === "") {
                        warningIconTerm.style.display = "inline";
                        warningIconTerm.setAttribute("data-warning", "Term cannot be empty");
                    }
                    if (definition === "") {
                        warningIconDefinition.style.display = "inline";
                        warningIconDefinition.setAttribute("data-warning", "Definition cannot be empty");
                    }
                } else {
                    if (termSet.has(term)) {
                        valid = false;
                        warningIconTerm.style.display = "inline";
                        warningIconTerm.setAttribute("data-warning", "Terms cannot contain duplicate");
                    } else {
                        termSet.add(term);
                    }
                    if (definitionSet.has(definition)) {
                        valid = false;
                        warningIconDefinition.style.display = "inline";
                        warningIconDefinition.setAttribute("data-warning", "Definitions cannot contain duplicate");
                    } else {
                        definitionSet.add(definition);
                    }
                }
            }

            if (termSet.size === 0) {
                valid = false;
                warning.innerHTML = "At least one term is required.";
            } else {
                warning.innerHTML = "";
            }

            createButton.disabled = !valid;
        }

        window.onload = function () {
            validateForm();
        };
    </script>
</head>
<body>
<jsp:include page="header1.jsp"/>

<div class="container">
    <h2>Create New Flashcard Set</h2>
    <form action="flashcard-add" method="post" onsubmit="return validateForm();">
        <div class="form-group">
            <label for="title">Title</label>
            <div class="input-group">
                <input type="text" class="form-control" id="title" name="title" required oninput="validateForm()">
                <i id="titleWarningIcon" class="fa fa-exclamation-circle warning-icon" aria-hidden="true"></i>
            </div>
        </div>
        <div class="form-group">
            <label for="subject">Subject</label>
            <select class="form-control" id="subject" name="subjectId" required>
                <c:forEach var="subject" items="${subjects}">
                    <option value="${subject.id}">${subject.name}</option>
                </c:forEach>
            </select>
        </div>
        <table class="table" id="flashcardTable">
            <thead>
            <tr>
                <th>Term</th>
                <th>Definition</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <div class="input-group">
                        <input type="text" name="term[]" class="form-control" oninput="validateForm()" required>
                        <i class="fa fa-exclamation-circle warning-icon" aria-hidden="true"
                           data-warning="Term cannot be empty or duplicated"></i>
                    </div>
                </td>
                <td>
                    <div class="input-group">
                        <input type="text" name="definition[]" class="form-control" oninput="validateForm()" required>
                        <i class="fa fa-exclamation-circle warning-icon" aria-hidden="true"
                           data-warning="Definition cannot be empty or duplicated"></i>
                    </div>
                </td>
                <td><span class="delete-button" onclick="deleteRow(this)"><i class="fa fa-minus" aria-hidden="true"></i></span>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <button type="button" class="btn btn-primary" onclick="addRow()">+</button>
                </td>
            </tr>
            </tbody>
        </table>
        <div id="warning" class="warning"></div>
        <button type="submit" class="btn btn-success" disabled>Create Flashcard Set</button>
    </form>
</div>
<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<jsp:include page="footer.jsp"/>

</body>
</html>
