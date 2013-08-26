<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="AddArrange.aspx.cs" Inherits="LabBook.Manage.AddArrange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>课堂管理@后台管理</title>
<link href="../_props/CSS/AddArrange.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">课堂管理</h3> 
    <form action="" class="arrange">
        <div class="addbox fix">
            <lable class="addItem"> 周次</lable>
            <select name="Week" class="select" id="week">
                <%
                    for (var i = 1; i < 23; i++)
                    { %>
                <option value="<%=i %>">第<%=i %>周</option>
                <%} %>
            </select>
            <lable class="addItem">星期</lable>
            <select name="WeekDay" class="select" id="weekday">
                <option value="1">星期一</option>
                <option value="2">星期二</option>
                <option value="3">星期三</option>
                <option value="4">星期四</option>
                <option value="5">星期五</option>
                <option value="6">星期六</option>
                <option value="7">星期日</option>
            </select>
        </div>
        <div class="addbox fix">
            <lable class="addItem">开始节次</lable>
            <select id="begin-lesson" name="BeginLesson">
                <%for (var i = 1; i <= 12; i++)
                  { %>
                <option value="<%=i %>">第<%=i%>节 </option>
                <%} %>
            </select>
            <lable class="addItem">结束节次</lable>
            <select id="end-lesson" name="EndLesson">
                <%for (var i = 1; i <= 12; i++)
                  { %>
                <option value="<%=i %>">第<%=i%>节 </option>
                <%} %>
            </select>
        </div>
        <div class="addbox fix">
            <lable class="addItem">容量</lable>
            <select name="Capacity">
                <%for (var i = 1; i <= 50; i++)
                  { %>
                <option value="<%=i %>"><%=i%>人 </option>
                <%} %>
            </select>
        </div>
        <input type="submit" class="submit" value="提交" />

        <%--课堂隐藏域，用于修改课堂安排--%>
        <input type="hidden" value="<% =Request.QueryString["arrangeId"]%>" name="arrangeId"/>

        <%--课程Id隐藏域 用于增加课堂安排--%>
        <input type="hidden" value="<%=Request.QueryString["id"] %>" name="courseId"/>
    </form>
</asp:Content>
