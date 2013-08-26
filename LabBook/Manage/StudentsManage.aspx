<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="StudentsManage.aspx.cs" Inherits="LabBook.Manage.StudentsManage"
    ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>学生信息管理@后台管理</title>
    <link href="../_props/CSS/StudentsManage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        学生信息</h3>
    <form class="classlist fix" action="StudentsManage.aspx" method="post">
    <%--<label class="SelectName">
        年级</label>
    <select name="grade" class="SelectBox" id="grade">
        <option value="">11级</option>
    </select>
    <label class="SelectName">
        班级</label>
    <select name="class" class="SelectBox" id="class">
        <option value="">光信1102</option>
    </select>--%>
    <%-- <a id="search">查询</a>--%>
    <%--<select>
       <%foreach (var class in StudentList)
              { %>
              <option>dffd</option>
              <%} %>
    </select>--%>
    <div>
        <select class="select" id="class">
        <option value="all">
            全部
        </option>
            <%int i = 0;
              while (Classes[i] != null)
              {%>
            <option value="<%=Classes[i]%>">
                <%=Classes[i]%>
            </option>
            <%
                  i++;
              } %>
        </select>
    </div>
    <div class="search-box">
        <input type="text" name="Key" />
        <input type="submit" value="搜索" class="search" /><span class="condition">（请输入学生学号，姓名，班级或院系进行查询）</span>
    </div>
    </form>
    <p class="listmention">
        *列表显示前50条信息</p>
    <table class="StudentInfo" id="student-list">
        <thead>
            <tr>
                <th>
                    学号
                </th>
                <th>
                    姓名
                </th>
                <th>
                    性别
                </th>
                <th>
                    院系
                </th>
                <th>
                    班级
                </th>
                <th>
                    电话
                </th>
                <th>
                    删除
                </th>
            </tr>
        </thead>
        <tbody>
            <%foreach (var student in StudentList)
              { %>
            <tr>
                <td>
                    <%=student.Id %>
                </td>
                <td>
                    <%=student.Name %>
                </td>
                <td>
                    <%=student.Sex==true?"男":"女" %>
                </td>
                <td>
                    <%=student.College %>
                </td>
                <td>
                    <%=student.Class %>
                </td>
                <td>
                    <%=student.PhoneNumber==null?"暂缺":student.PhoneNumber %>
                </td>
                <td>
                    <a style="cursor: pointer">
                        <p id="deleteStudent" onclick="deleteStudent('<%=student.Id %>')">
                            删除</p>
                    </a>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <div id="ajax_div1" style="text-align: center">
        <img src="../_props/images/ajax_loader.gif" alt="正在加载..." title="正在加载..." /><span>正在加载数据...</span>
    </div>
    <script type="text/javascript">

        function deleteStudent(id) {
            if (confirm("确认删除吗？删除后所有有关学生的预约信息将一同被删除！")) {
                $.get("DeleteStudent.ashx", { id: id }, deleteCallback);
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
    <script type="text/javascript">
        $(function () {
            $("#ajax_div1").hide();

            $("#class").change(function () {
                do_refresh();
            });



            function do_refresh() {

                var classval = $("#class").val();

                $("#student-list thead").siblings().children().remove();
                $("#ajax_div1").show();

                $.get("RefreshStudentList.ashx", { class: classval }, function (data) {
                    refresh_student_list(data);
                    //alert(data);
                    //$(".book").on('click', function () { booking($(this).attr('id')); });
                }, 'json');


            }

            function refresh_student_list(data) {
                $("#ajax_div1").hide();
                //alert(data);
                var tr, td;
                for (var i = 0; i < data.length; i++) {
                    tr = $('<tr></tr>');

                    for (var key in data[i]) {

                        td = $('<td>' + data[i][key] + '</td>');
                        td.appendTo(tr).hide().fadeIn(400);
                        //tr.append(td);
                    }
                    td = $('<td><a style="cursor:pointer"><p id="deleteStudent" onclick="deleteStudent(\'' + data[i]['Id'] + '\')">删除</p></a></td>');
                    td.appendTo(tr).hide().fadeIn(400);
                    $("#student-list").append(tr);
                }
            }
        });
    </script>
</asp:Content>
