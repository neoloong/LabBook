<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="AddStudents.aspx.cs" Inherits="LabBook.Manage.AddStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>添加学生名单@后台管理</title>
<link href="../_props/CSS/AddStudents.css" type="text/css" rel="Stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h3 class="title">学生名单上传</h3>
    <form class="add" action="AddStudents.aspx" method="post" enctype="multipart/form-data" >
    <div class="addbox">
    <span class="addItem">学院名称：</span>
    <input class="inputArea" type="text" name="College" />
    </div>
    <div class="addbox">
    <span class="addItem">默认密码：</span>
    <input class="inputArea" type="text" name="DefaultPwd" value="123456" />
    </div>
    <div class="addbox">
    <span class="addItem">学生名单txt文件：</span>
    <input class="AddFile" type="file" name="StudentInfoList"  value="选择文件"/>
    </div>
    <input class="submit" type="submit" value="上传" />
    </form>
</asp:Content>
