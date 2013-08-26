<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    ValidateRequest="false" CodeBehind="ModifyBulletin.aspx.cs" Inherits="LabBook.Manage.ModifyBulletin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>修改公告@后台管理</title>
<link href="../_props/CSS/AddBulletinOfManagePage.css" rel="Stylesheet" type="text/css"; />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">修改公告</h3>
    <form action="" method="post">
    <div class="BulletinContent">
        <div class="item">
        <label>公告标题:</label>
        <input type="text" name="Title" value="<%=BulletinToModify.Title %>" />
        </div>
        <div class="item">
        <label>发布人:</label>
        <input type="text" name="Bulletiner" value="<%=BulletinToModify.Bulletiner %>" />
        </div>
        <div  class="item">
            <script type="text/plain" id="myEditor" class="myEditor">
            </script>
            <script type="text/javascript">
                var editor_a = new baidu.editor.ui.Editor();
                editor_a.render('myEditor');
                <%--编辑器中要显示的内容，后台通过Request.Form["editorValue"]获取即可--%>
                var content = '<%=BulletinToModify.Content.Replace("\r\n","") %>';
                editor_a.setContent(content);
            </script>
            <input type="submit" class="submit" value="保存修改" />
        </div>
    </div>
    </form>
</asp:Content>
