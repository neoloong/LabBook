<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="AddBulletin.aspx.cs" Inherits="LabBook.Manage.AddBulletin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>添加公告通知@后台管理</title>
<link href="../_props/CSS/AddBulletinOfManagePage.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="title">添加公告</h3>
<form action="AddBulletin.aspx" method="post">
    <div class="BulletinContent">
    <div class="item">
    <label>公告标题:</label>
    <input type="text" name="Title" />
    </div>
    <div class="item">
    <label>发布人:</label>
    <input type="text" name="Bulletiner" />
    </div>
    <div  class="item">
    <label>公告内容:</label>
    <%--控制富文本编辑器的样式--%>
        <script type="text/plain" id="myEditor" class="myEditor">
        </script>
        <script type="text/javascript">
            var editor_a = new baidu.editor.ui.Editor();
            editor_a.render('myEditor');
            editor_a.setContent("");
        </script>
    </div>
        <input type="submit" class="submit" value="发布" />
    </div>
    </form>
</asp:Content>
