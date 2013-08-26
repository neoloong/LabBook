$("#login").submit(function () {
    $.post("Login.aspx", {
        UserName: $("#user-name").val(),
        Password: $("#password").val()
    })
    return false;
})