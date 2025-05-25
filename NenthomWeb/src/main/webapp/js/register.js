document.addEventListener("DOMContentLoaded", function () {
    // Xử lý click vào link Login
    const loginLink = document.getElementById("go-to-login");
    if (loginLink) {
        loginLink.addEventListener("click", function (event) {
            event.preventDefault();
            window.location.href = "/NenthomWeb/views/login.jsp";
        });
    }

    // Hiển thị toastr dựa trên message và error trong div ẩn
    const messageDiv = document.getElementById("register-message-data");
    if (messageDiv) {
        const message = messageDiv.dataset.message;
        const error = messageDiv.dataset.error === "true";

        if (error) {
            toastr.error(message, "Lỗi");
        } else {
            toastr.success(message, "Thành công");
        }
    }
});
