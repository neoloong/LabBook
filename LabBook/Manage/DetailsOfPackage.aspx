<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="DetailsOfPackage.aspx.cs" Inherits="LabBook.Manage.DetailsOfPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>实验包课程详情@后台管理</title>
    <link href="../_props/CSS/DetailsOfPackage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        实验课程包</h3>
    <div class="CourseInfo">
        <div>
            <span class="item">实验名称：</span> <span>asdf</span>
        </div>
        <div>
            <span class="item">所属实验大类：</span> <span>
                <%=Package.ExperimentInfo.Name %></span>
        </div>
        <div>
            <span class="item">实验地点：</span> <span>
                <%=Package.Address %></span>
        </div>
        <div>
            <span class="item">指导老师：</span> <span>
                <%=Package.TeacherInfo.Name %></span>
        </div>
        <div>
            <span class="item">包含课程：</span>
            <table class="contain">
                <%
           
                    foreach (var course in CourseList)
                    {
                %>
                <tr>
                    <td class="CourseName">
                        <%=course.Name%>
                    </td>
                    <td>
                        <%=course.TeacherInfo.Name%>
                    </td>
                </tr>
                <%} %>
            </table>
        </div>
    </div>
    <h3 class="title">
        预约详情</h3>
    <div class="BookingDetails fix">
        <div class="details">
            <div class="DetailBox">
                <div>
                    <span>时间：</span> <span>第十三周周四、周五、周六整个下午</span>
                </div>
                <div>
                    <span>容量：</span> <span>4个班</span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
