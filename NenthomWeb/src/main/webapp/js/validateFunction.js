function validatePassword() {
    const password = document.getElementById("password").value;
    const message = document.getElementById("pw-msg");
    const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;

    if (!strongRegex.test(password)) {
        message.innerText = "Password phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.";
    } else {
        message.innerText = "";
    }
}
function validateUsername() {
    const username = document.getElementById("username").value;
    const message = document.getElementById("un-msg");
    const usernameRegex = /^[a-zA-Z0-9]{5,20}$/;

    if (!usernameRegex.test(username)) {
        message.innerText = "Username chỉ được chứa chữ, số và dài từ 5 đến 20 ký tự.";
    } else {
        message.innerText = "";
    }
}