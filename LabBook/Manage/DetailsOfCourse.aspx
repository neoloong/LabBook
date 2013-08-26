<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true" CodeBehind="DetailsOfCourse.aspx.cs" Inherits="LabBook.Manage.DetailsOfCourse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>实验课程详情@后台管理</title>
<link href="../_props/CSS/DetailsOfCourse.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h3 class="title">实验课程信息</h3>
<div class="CourseInfo">
    <div>
        <span class="item">实验名称：</span>
        <span><%=Course.Name %></span>
    </div>
    <div>
        <span class="item">所在学期：</span>
        <span><%=Course.ExperimentInfo.Semester.SchoolYear+Course.ExperimentInfo.Semester.Season %></span>
    </div>
    <div>
        <span class="item">所属大类：</span>
        <span><%=Course.ExperimentInfo.Name %></span>
    </div>
    <div>
        <span class="item">实验地点：</span>
        <span><%=Course.Address %></span>
    </div>
    <div>
        <span class="item">指导老师：</span>
        <span><%=Course.TeacherInfo==null?"暂无":Course.TeacherInfo.Name %></span>
    </div>
    <div>
        <span class="item">选修/必修：</span>
        <span><%=Course.Choosable?"选修":"必修" %></span>
    </div>
    <div>
        <span class="item">实验简介：</span>
        <span><%=Course.Introduction %></span>
    </div>
    <div>
        <img class="CoursePhoto" src="<%=Course.PhotoUrl %>" <%--alt="<%Course.Name %>" title="<%=Course.Name %>"--%>/>
    </div>
</div>
<!-- <h3 class="title">预约详情</h3>
<div class="BookingDetails fix">
    <div class="TimeLabel">
        <label>时间</label>
        <select>
            <option>第一周</option>
        </select>
    </div>
    <div class="details">
        <div class="DetailBox">
            <span>时间：</span>
            <span>1-2</span>
            <span>容量：</span>
            <span>4</span>
        </div>
    </div>
</div>!-->
</asp:Content>
