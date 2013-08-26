<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="CourseModify.aspx.cs" Inherits="LabBook.Manage.CourseModify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../_props/CSS/CourseModify.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        添加课程</h3>
    <form class="AddCourse" action="" method="post" enctype="multipart/form-data">
    <div class="addbox">
        <span class="addItem">实验名称：</span>
        <input class="inputArea" type="text" name="Name" value="<%=Course.Name %>" />
    </div>
    <div class="addbox">
        <span class="addItem">上传图片：</span>上传新图片&nbsp;&nbsp;&nbsp;
        <input class="AddFile" type="file" name="Photo" value="选择文件" />
    </div>
    <div class="addbox">
        <span class="addItem">实验地点：</span>
        <input class="inputArea" type="text" name="Address" value="<%=Course.Address %>" />
    </div>
    <div class="addbox">
        <span class="addItem">学时：</span>
        <%--<input class="inputArea" type="text" name="Period" />--%>
        <select name="ClassHour" class="ClassHour">
            <option>
                <%=Course.ClassHour %>
            </option>
            <%int i;
              for (i = 1; i < 8; i++)
              {%>
            <option value="<%=i %>">
                <%=i %>课时 </option>
            <%} %>
        </select>
    </div>
    <div class="addbox">
        <span class="addItem">指导老师：</span>
        <select name="TeacherId" class="TeacherId">
            <option value="<%=Course.TeacherId %>">
                <%if (Course.TeacherInfo != null)
                  { %>
                <%=Course.TeacherInfo.Name+"(用户名:"+Course.TeacherInfo.Account.UserName+")" %>
                <%} %>
            </option>
            <%foreach (var teacher in TeacherList)
              {

                  if ((Course.TeacherInfo != null && teacher.Id != Course.TeacherInfo.Id) || Course.TeacherInfo == null)
                  {%>
            <option value="<%=teacher.Id %>">
                <%=teacher.Name + "(用户名:" + teacher.Account.UserName + ")"%>
            </option>
            <%} %>
            <%} %>
        </select>
    </div>
    <div class="addbox">
        <span class="addItem">课程简介：</span>
        <textarea rows="10" cols="50" name="Introduction" class="Introduction"><%=Course.Introduction %></textarea>
    </div>
    <div class="addbox">
        <span class="addItem">注意事项:</span><input type="text" class="inputArea" name="Attention"/><span class="attention">(*请复制网页链接到这里,该项可以留空)</span>
    </div>
    <input class="submit" type="submit" value="提交" />
    </form>
</asp:Content>
