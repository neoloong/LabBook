<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true" CodeBehind="ArrangeDetails.aspx.cs" Inherits="LabBook.Manage.ArrangeDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="../_props/CSS/ArrangeDetails.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h3 class="title">已预约学生名单</h3>
<table class="NameList" >
        <thead>
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th class="course">预约课程</th>
                <th>预约时间</th>
            </tr>
        </thead>
        <tbody>

        <%foreach (var bookInfo in Arrange.CourseBookInfo)
          { %>
          <tr>
                <td><%=bookInfo.StudentId %></td>
                <td><%=bookInfo.StudentInfo.Name %></td>
                <td><%=bookInfo.CourseArrange.CourseInfo.Name %></td>
                <td><%=bookInfo.BookTime %></td>
            </tr>
          <%} %>
        </tbody>
    </table>


</asp:Content>
