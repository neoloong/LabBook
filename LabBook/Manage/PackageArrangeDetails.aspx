<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="PackageArrangeDetails.aspx.cs" Inherits="LabBook.Manage.PackageArrangeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        已预约学生名单</h3>
    <table class="NameList">
        <thead>
            <tr>
                <th>
                    学号
                </th>
                <th>
                    姓名
                </th>
                <th class="course">
                    预约课程包
                </th>
                <th>
                    预约时间
                </th>
            </tr>
        </thead>
       
        <tbody>
            <%foreach (var bookInfo in Arrange.PackageBookInfo)
              { %>
            <tr>
                <td>
                    <%=bookInfo.StudentId%>
                </td>
                <td>
                    <%=bookInfo.StudentInfo.Name%>
                </td>
                <td>
                    <%=bookInfo.PackageArrange.CoursePackage.Name%>
                </td>
                <td>
                    <%=bookInfo.BookTime%>
                </td>
            </tr>
            <%} %>
        </tbody> 
     
    </table>
</asp:Content>
