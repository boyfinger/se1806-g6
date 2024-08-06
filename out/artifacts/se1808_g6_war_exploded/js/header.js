(function () {
    let href = window.location.href;
    var elementId;
    if (href.includes('/home') || href === 'http://localhost:8080/se1808-g6/') {
        elementId = 'nav-item-home';
    } else if (href.includes('/flashcard')) {
        elementId = 'nav-item-flashcard';
    } else if (href.includes('/course')) {
        elementId = 'nav-item-course';
    } else if (href.includes('/contact')) {
        elementId = 'nav-item-contact';
    }


    document.getElementById(elementId).className = "nav-item nav-link text-primary";
}
)();