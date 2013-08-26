<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LabBook.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>光电学院实验预约系统登录</title>
    <link href="_props/css/Login.css" rel="Stylesheet" type="text/css" />
    <script src="_props/JS/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="_props/JS/login.js" type="text/javascript"></script>
    <script src="_props/JS/html5-placeholder.js" type="text/javascript"></script>
</head>
<body id="log_in">
    <div id="wrapper">
        <div id="LoginFrame">
            <div id="header">
                <h1>
                    光电学院实验预约系统</h1>
            </div>
            <div id="darkbanner" class="banner320">
                <h2>
                    Login</h2>
            </div>
            <div id="darkbannerwrap">
            </div>
            <form id="signs" action="Login.aspx" method="post">
            <fieldset class="form">
                <p>
                    <%--<label id="f-title-label1">用户名</label> --%>
                    <input placeholder="用户名" class="username box" type="text" name="UserName" id="user_name"
                        value="用户名" />
                </p>
                <div id="msg1" class="error1">
                </div>
                <p>
                    <%-- <label id="f-title-label2">密码</label> --%>
                    <input placeholder="密码" class="password box" type="password" name="Password" id="password"
                        value="" />
                </p>
                <div id="msg2" class="error2">
                </div>
                <button class="button" type="submit" value="登录" id="login">
                    登录</button>
                    
                    <button type="submit" class="button">♥ 随便逛逛</button>
                    <%--<input type="submit" class="tourist " value="➹游客入口" />--%>
                
                <ul id="forgottenpassword">
                    <li class="boldtext">|</li>
                    <li><a href="SendPwd.aspx" class="forgetPassword">忘记密码?</a></li>
                </ul>
            </fieldset>
            </form>
        </div>
    </div>
    <%--<form action="Login.aspx" method="post" class="entrance">
                <input type="hidden" name="UserName" value="visitor" />
                <input type="hidden" name="Password" value="visitor" />
                <input type="submit" class="tourist " value="➹游客入口" />
                </form>--%>
    <script src="_props/JS/jquery-1.6.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#login").bind("click", function (event) {
                var username = $("#user_name").val();
                var password = $("#password").val();
                if (username == "用户名") {
                    $("#msg1").html("用户名不能为空.");
                    $(".error1").show();
                    event.preventDefault();
                }
                if (password == "") {
                    $("#msg2").html("密码不能为空.");
                    $(".error2").show();
                    event.preventDefault();
                }
            })
        })
    </script>
    <script type="text/javascript">
        var title_label1 = document.getElementById('f-title-label1');
        var title_label2 = document.getElementById('f-title-label2');
        var title_input1 = document.getElementById('user_name');
        var title_input2 = document.getElementById('password');
        title_input1.value = '';
        title_label1.onclick = function () {
            title_input1.focus();
        }
        title_input1.onfocus = function () {
            if (title_input1.value === '') {
                title_label1.style.display = "none";
            }
        }
        title_input1.onblur = function () {
            if (title_input1.value === '') {
                title_label1.style.display = "block";
            }
        }

        title_input2.value = '';
        title_label2.onclick = function () {
            title_input2.focus();
        }
        title_input2.onfocus = function () {
            if (title_input2.value === '') {
                title_label2.style.display = "none";
            }
        }
        title_input2.onblur = function () {
            if (title_input2.value === '') {
                title_label2.style.display = "block";
            }
        }
    </script>
</body>
</html>
