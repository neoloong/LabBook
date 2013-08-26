<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="PackageManage.aspx.cs" Inherits="LabBook.Manage.PackageManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../_props/CSS/PackageManage.css" rel="Stylesheet" type="text/css" />
    <script src="../_props/JS/AddItem.js" type="text/javascript"></script>
    <title>实验课程包管理@后台管理</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        课程包</h3>
    <table class="course">
        <thead>
            <tr>
                <th class="courseTitle">
                    名称
                </th>
                <th>
                    详情
                </th>
                <th>
                    修改
                </th>
                <th>
                    删除
                </th>
                <th>
                    课堂管理
                </th>
            </tr>
        </thead>
        <tbody>
            <%
                int t = 0;
                foreach (var package in PackageList)
                {
                    t++;%>
            <tr <%if (t%2==0) {%>class="double" <%} %>>
                <td d>
                    <%=package.Name%>
                </td>
                <td>
                    <a href="DetailsOfPackage.aspx?packageId=<%=package.Id %>">查看</a>
                </td>
                <td>
                    <a href="PackageModify.aspx?packageId=<%=package.Id %>">修改</a>
                </td>
                <td>
                    <a href="<%=package.Id%>" class="delete-package">删除</a>
                </td>
                <td>
                    <a href="PackageArrangeManage.aspx?packageId=<%=package.Id %>">管理</a>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <h3 class="title flip">
        添加新课程包</h3>
    <form class="Add" action="PackageManage.aspx" method="post" id="form">
    <div class="addbox">
        <span class="addItem">课程包名称：</span>
        <input class="inputArea" type="text" name="Name" id="name" />
    </div>
    <div class="addbox">
        <span class="addItem">实验地点：</span>
        <input class="inputArea" type="text" name="Address" id="address" />
    </div>
    <div class="addbox">
        <span class="addItem">学时：</span>
        <select name="ClassHour" id="classHour">
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
        <select name="TeacherId" id="teacherId">
            <%foreach (var teacher in TeacherList)
              { %>
            <option value="<%=teacher.Id %>">
                <%=teacher.Name+"(用户名:"+teacher.Account.UserName+")" %>
            </option>
            <%} %>
        </select>
    </div>
    <div class="AddClass fix">
        <span class="addItem">添加课程：</span>
        <div class="centent">
            <select multiple="multiple" id="select1">
                <%foreach (var course in Experiment.CourseInfo)
                  { %>
                <option value="<%=course.Id %>" id="<%=course.Id %>">
                    <%=course.Name %>
                </option>
                <%} %>
            </select>
        </div>
        <div id="AddOrDel">
            <span id="add">添加 >></span> <span id="del"><< 删除</span>
        </div>
        <div class="centent">
            <select multiple="multiple" id="select2">
            </select>
        </div>
    </div>
    <input class="submit" type="submit" value="添加" id="submit" />
    </form>
    <script type="text/javascript">
        $(function () {
            $("#submit").click(function () {

                if ($('#name').val() == "") {
                    alert('课程包名称不能为空！');
                }
                if ($('#address').val == "") {
                    alert('上课地点不能为空！');
                }

                if ($("#select2 option").length == 0) {
                    alert("课程不能为空！");
                    return false;
                }

                var data = {};
                $("#form").find("#name,#address,#classHour,#teacherId,#select2 option").each(function () {
                    if (this.id != "")
                        data[this.id] = $(this).val();
                });

                data['experimentId'] = $.getUrlParam('id'); //获取实验大类id。

                $.post("AddPackage.ashx", data, callback);


                return false;
            });


            function callback(data) {
                if (data == "1") {
                    alert('添加成功！');
                    location.reload(true);
                }
                else {
                    alert('添加失败！' + data);
                }
            }


            //静态删除课堂。
            $(".delete-package").live('click', function (event) {

                event.preventDefault();
                if (confirm("确认删除吗？如果删除，所有预约信息也将同时删除！")) {
                    $.get("DeletePackage.ashx", { packageId: $(this).attr('href') }, deleteCallback);
                }
            });

            function deleteCallback(data) {
                if (data == "1") {
                    alert('删除成功！');
                    location.reload(true);
                }
            }
        });
        
    </script>
    <%--添加课程列表控件--%>
    <script type="text/javascript">
        $(function () {
            $('#add').click(function () {
                $('#select1 option:selected').appendTo('#select2');
            });
            $('#del').click(function () {
                $('#select2 option:selected').appendTo('#select1');
            });
            $('#select1').dblclick(function () {
                $("option:selected", this).appendTo('#select2');
            });
            $('#select2').dblclick(function () {
                $("option:selected", this).appendTo('#select1');
            });
        });
    </script>
</asp:Content>
