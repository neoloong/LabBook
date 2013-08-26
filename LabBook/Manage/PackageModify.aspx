<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="PackageModify.aspx.cs" Inherits="LabBook.Manage.PackageModify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../_props/CSS/PackageModify.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        课程包编辑</h3>
    <form class="AddCourse" action="PackageManage.aspx" method="post" id="form">
    <div class="addbox">
        <span class="addItem">课程包名称：</span>
        <input class="inputArea" type="text" name="Name" value="<%=Package.Name %>"  id="name"/>
    </div>
    <div class="addbox">
        <span class="addItem">实验地点：</span>
        <input class="inputArea" type="text" name="Address" value="<%=Package.Address %>"  id="address"/>
    </div>
    <div class="addbox">
        <span class="addItem">学时：</span>
        <select name="ClassHour" id="classHour">
            <option>
                <%=Package.ClassHour %>
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
        <select name="TeacherId" id="teacherId">
            <option value="<%=Package.TeacherId %>">
                <%=Package.TeacherInfo.Name+"(用户名:"+Package.TeacherInfo.Account.UserName+")" %>
            </option>
            <%foreach (var teacher in TeacherList)
              {
                  if (teacher.Id != Package.TeacherInfo.Id)
                  {%>
            <option value="<%=teacher.Id %>">
                <%=teacher.Name + "(用户名:" + teacher.Account.UserName + ")"%>
            </option>
            <%} %>
            <%} %>
        </select>
    </div>
    <div class="AddClass fix">
        <span class="addItem">添加课程：</span>
        <div class="centent">
            <select multiple="multiple" id="select1">
                <%foreach (var course in AllCourseList)
                  { %>
                <option value="<%=course.Name %>" id="<%=course.Id %>">
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
    <input class="submit" type="submit" value="提交更改" id="submit" /><%--此按钮应该在有修改时再显示--%>
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

                data['packageId'] = $.getUrlParam('packageId');  //获取需要修改的课程包id。

                $.post("AddPackage.ashx", data, callback);


                return false;
            });


            function callback(data) {
                if (data == "1") {
                    alert('修改成功！');
                    window.history.back(-1);
                }
                else {
                    alert('修改失败！' + data);
                }
            }
        });
    </script>
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
