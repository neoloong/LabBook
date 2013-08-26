<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true" CodeBehind="TermManage.aspx.cs" Inherits="LabBook.Manage.TermManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title></title>
<link href="../_props/CSS/TermManage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h3 class="title">学期管理</h3>
<div class="term">
<select class="termList">
    <option value="">2011年春季</option>
</select>
<a href="#">详情</a>
</div>
</asp:Content>
