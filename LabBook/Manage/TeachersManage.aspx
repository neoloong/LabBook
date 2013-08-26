<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="TeachersManage.aspx.cs" Inherits="LabBook.Manage.TeachersManage"   validateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>教师信息管理</title>
    <link href="../_props/CSS/TeachersManage.css" rel="Stylesheet" type="text/css" />
    <script src="../_props/JS/AddItem.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        教师信息</h3>
    <table class="teacherInfo">
        <thead>
            <tr>
                <th>
                    姓名
                </th>
                <th>
                    性别
                </th>
                <th>
                    用户名
                </th>
                <%--  <th>
                    重置密码
                </th>--%>
                <th>
                    修改
                </th>
                <th>
                    删除
                </th>
            </tr>
        </thead>
        <tbody>
            <%int i = 0;
              foreach (var teacher in TeacherList)
              {
                  i++; %>
            <tr <%if (i%2==0) {%>class="double" <%} %>>
                <td>
                    <%=teacher.Name %>
                </td>
                <td>
                    <%=(teacher.Sex==true?"男":"女") %>
                </td>
                <td>
                    <%=teacher.Account.UserName %>
                </td>
                <%--<td>
                    <a href="#">重置密码</a>
                </td>--%>
                <td>
                    <a href="TeacherModify.aspx?teacherId=<%=teacher.Id %>">修改</a> 
                </td>
                <td>
                    <a style="cursor:pointer"><p id="deleteTeacher" onclick="deleteTeacher(<%=teacher.Id %>)">
                        删除</p></a>
                </td>
            </tr>
            <% }%>
        </tbody>
    </table>
    <h3 class="title flip">
        添加教师信息</h3>
    <form class="Add" action="TeachersManage.aspx" method="post" enctype="multipart/form-data">
    <div class="addbox">
        <span class="addItem">姓名：</span>
        <input class="inputArea" type="text" name="Name" />
    </div>
    <div class="addbox">
        <span class="addItem">性别：</span> 男<input name="Sex" type="radio" value="male" />
        女<input name="Sex" type="radio" value="female" checked="checked" />
    </div>
    <div class="addbox">
        <span class="addItem">用户名：</span>
        <input class="inputArea" type="text" name="Account" />
    </div>
    <div class="addbox">
        <span class="addItem">密码：</span>
        <input class="inputArea" type="text" name="Password" />
    </div>
    <div class="addbox">
        <span class="addItem">电话：</span>
        <input class="inputArea" type="text" name="Tel" />
    </div>
    <div class="addbox">
        <span class="addItem">备注：</span>
        <textarea rows="10" cols="48" name="Remarks"></textarea>
    </div>
    <div class="addbox">
        <span class="addItem">上传照片：</span>
        <input type="file" name="Photo" accept="image/*" />
    </div>
    <input class="submit" type="submit" value="提交" id="submit" />
    </form>
    <script type="text/javascript">
        $(function () {

            $("#deleteTeacher").live(click, deleteTeacher);
        })
        function deleteTeacher(id) {
            if (confirm("确认删除吗？删除后请增加相关课程的任课老师！")) {
                $.get("DeleteTeacher.ashx", { id: id }, deleteCallback);
            }
        };
        function deleteCallback(data) {
            if (data == "1") {
                alert("删除成功！");
                location.reload(true);
            }
            else {
                alert("删除失败！请联系网站管理员！");
            }
        }
    </script>
</asp:Content>
