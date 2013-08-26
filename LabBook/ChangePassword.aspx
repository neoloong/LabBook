<%@ Page Title="" Language="C#" MasterPageFile="~/IndividualCenter.master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="LabBook.ChangePassword" validateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="headChild" runat="server">
    <title>修改密码</title>
    <link href="_props/CSS/ChangePassword.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
    <form class="InfoContent" id="ChangePassword" action="ChangePassword.aspx" method="post">
    <div class="CurrentPwd m">
        <label class="InfoTitle">当前密码：</label>
        <input type="password" name="OldPwd" />
    </div>
    <div class="NewPwd m">
        <label class="InfoTitle">新密码：</label>
        <input type="password" id="password" name="NewPwd" /><span class="attention">提示：密码长度为6-12位。</span>
    </div>
    <div class="ConfirmPwd m">
        <label class="InfoTitle">确认密码：</label>
        <input type="password" id="confirm" name="ConfirmPwd" />
        <span class="errmsg3" id="error3"></span>
    </div>
    <input class="button" type="submit" value="保存修改"/><span class="errmsg" id="checked"><%=Message %></span>
    </form>
</asp:Content>
