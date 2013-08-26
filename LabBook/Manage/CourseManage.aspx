<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="CourseManage.aspx.cs" Inherits="LabBook.Manage.CourseManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>实验课程管理@后台管理</title>
    <link href="../_props/CSS/CourseManage.css" rel="Stylesheet" type="text/css" />
    <script src="../_props/JS/AddItem.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        实验课程</h3>
    <table class="course">
        <thead>
            <tr>
                <th class="courseTitle">名称</th>
                <th>详情</th>
                <th>编辑</th>
                <th>删除</th>
                <th>课堂管理</th>
            </tr>
        </thead>
        <tbody>
            <%foreach (var course in CourseList)
              { %>
            <tr>
                <td><%=course.Name %></td>
                <td><a href="DetailsOfCourse.aspx?courseId=<%=course.Id %>">查看</a></td>
                <td><a href="CourseModify.aspx?courseId=<%=course.Id %>">编辑</a></td>
                <td>
                    <a href="DeleteCourse.aspx?courseId=<%=course.Id %>&experimentId=<%=Experiment.Id %>" class="delete">删除</a>
                    <%--<span class="delete" title="<%=course.Id %>">删除</span>--%>
                </td>
                <td><a href="CourseArrangeManage.aspx?courseId=<%=course.Id %>">管理</a></td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <h3 class="title flip">添加课程</h3>
    <form class="Add" action="CourseManage.aspx" method="post" enctype="multipart/form-data">
    <div class="addbox">
        <span class="addItem">实验名称：</span>
        <input class="inputArea" type="text" name="Name" />
    </div>
    <div class="addbox">
        <span class="addItem">上传图片：</span>
        <input class="AddFile" type="file" name="Photo" value="选择文件"  accept="image/*"/>
    </div>
    <div class="addbox">
        <span class="addItem">实验地点：</span>
        <input class="inputArea" type="text" name="Address" />
    </div>
    <div class="addbox">
        <span class="addItem">学时：</span>
        <select name="ClassHour">
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

        <select name="TeacherId">
            <%foreach(var teacher in TeacherList)
              { %>
              <option value="<%=teacher.Id %>">
                <%=teacher.Name+"(用户名:"+teacher.Account.UserName+")" %>
              </option>
              <%} %>
        </select>
    </div>
    <div class="addbox">
        <span class="addItem">课程简介：</span>
        <textarea rows="10" cols="50" name="Introduction" class="Introduction"></textarea>
    </div>

    <%--实验大类Id隐藏域--%>
    <input type="hidden" value="<%=Request.QueryString["id"] %>" name="ExperimentId"/>

    <input class="submit" type="submit" value="提交" />
    </form>
   <%-- <script type="text/javascript">
        $(function () {
            $(".delete").click(function () {
                var courseId = $(this).title;

                get("DeleteCourse.ashx", { courseid: courseId }, deleteItem, 'json')
            })

            function deleteItem(data) {
                alert(data);
            }
        });
        
    </script>--%>
</asp:Content>
