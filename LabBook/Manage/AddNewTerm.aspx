<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="AddNewTerm.aspx.cs" Inherits="LabBook.Manage.AddNewTerm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>添加新学期@后台管理</title>
<link href="../_props/CSS/AddNewTerm.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h3 class="title">添加新学期</h3>
    <form action="AddNewTerm.aspx" method="post">
    <select name="SchoolYear" id="SchoolYear">
        <%
            int currentYear = Convert.ToInt32(DateTime.Now.Year.ToString());
            int i;
            for (i = currentYear; i < currentYear + 10; i++)
            {%>
        <option value="<%=i %>">
            <%=i %>年
        </option>
        <%} %>
    </select>
    <select name="Season" id="Season">
        <option value="秋季">秋季 </option>
        <option value="春季">春季 </option>
    </select>
    <input type="submit" value="提交" id="submit" />
    </form>
</asp:Content>
