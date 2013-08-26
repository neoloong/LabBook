<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendPwd.aspx.cs" Inherits="LabBook.SendPwd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>光电学院实验预约系统找回密码</title>
    <link href="_props/CSS/SendPwd.css" rel="Stylesheet" type="text/css" />
</head>
<body id="FindPwd">
    <div id="wrapper">
    <div id="Recovered">
        <div id="header">
			<h1>光电学院实验预约系统</h1>
		</div>
		<div id="darkbanner" class="banner320">
			<h2>找回密码</h2>
		</div>
        <div id="darkbannerwrap">
		</div>
        <form action="SendPwd.aspx" method="post">  
       <fieldset class="form">
         <p>输入您的学号和姓名</p>
        <input type="text" name="Id" value="学号 " onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" />
        <input type="text" name="Name" value="姓名" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" />
        <p>发送邮件找回密码<input type="submit" class="submit" value="点击发送" /></p>
       </fieldset>
       </form>
       <%=Message %>
    </div>
    </div>
    
</body>
</html>
