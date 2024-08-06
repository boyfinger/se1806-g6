(function () {
    let href = window.location.href;
    var elementId;
    if (href.includes('/dashboard')) {
        elementId = 'dashboard-menu-item';
    } else if (href.includes('/question')) {
        elementId = 'question-menu-item';
    } else if (href.includes('/user')) {
        elementId = 'user-menu-item';
    } else if (href.includes("/lesson")) {
        elementId = 'lesson-menu-item';
    }

    document.getElementById(elementId).className = "menu-item active";
}
)();