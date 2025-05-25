document.addEventListener("DOMContentLoaded", function () {
    const signupLink = document.getElementById("go-to-signup");
    if (signupLink) {
        signupLink.addEventListener("click", function (event) {
            event.preventDefault();
            window.location.href = "/NenthomWeb/views/register.jsp";
        });
    }

    const logoutMessageEl = document.getElementById("logout-message-data");
    if (logoutMessageEl) {
        const message = logoutMessageEl.dataset.message;
        toastr.success(message);
    }
});
