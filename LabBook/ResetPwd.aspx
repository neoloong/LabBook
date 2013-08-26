<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPwd.aspx.cs" Inherits="LabBook.ResetPwd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>光电学院实验预约系统重置密码</title>
    <link href="_props/CSS/ResetPwd.css" rel="Stylesheet" type="text/css" />
</head>
<body id="ResetPwd">
    <div id="wrapper">
    <div id="Recovered">
        <div id="header">
			<h1>光电学院实验预约系统</h1>
		</div>
		<div id="darkbanner" class="banner320">
			<h2>修改密码</h2>
		</div>
        <div id="darkbannerwrap">
		</div>
        <form action="ResetPwd.aspx" method="post">
       <fieldset class="form">
        <input  type="hidden"  name="resetId" value="<%=Request.QueryString["resetId"] %>"/>
        <p><label>新密码：</label><input type="password" id="password" name="NewPwd" /></p>
        <p><label>确认密码：</label><input type="password" id="confirm" name="ConfirmPwd" /></p>
        <div id="msg" class="error"></div>
        <input type="submit" class="submit" value="确认修改" />
       </fieldset>
       </form>
    </div>
    </div>
    <script src="_props/JS/jquery-1.6.3.min.js" type="text/javascript"></script>  
<script type="text/javascript">
    $(function () {
        $(".submit").bind("click", function (event) {
            var password = $("#password").val();
            var confirm = $("#confirm").val();
            if (password != confirm) {
                $("#msg").html("<p>两次输入密码不同.</p>");
                $(".error").show();
                event.preventDefault();
            }
        })
    })
</script>
</body>
</html>
