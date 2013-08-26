<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true" CodeBehind="PackageArrangeManage.aspx.cs" Inherits="LabBook.Manage.PackageArrangeManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>课堂管理@后台管理</title>
<link href="../_props/CSS/CourseArrangeManage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h3 class="title">课堂管理</h3> 
    <div class="heading">
        <p class="courseName" id="CourseName"><%=Package.Name %></p>
        <a class="addArrange" href="AddPackageArrange.aspx?packageId=<%=Package.Id%>">添加课堂</a>
    </div> 
    
    <table class="" id="arrange-list">
        <thead>
            <tr>
                <th>上课时间</th>
                <th>已预约/容量</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
        </thead>
        <tbody>

        <%foreach(var arrange in PackageArrangeList){ %>
            <tr>
                <td><%=arrange.CustomTime %></td>
                <td><a href="PackageArrangeDetails.aspx?arrangeId=<%=arrange.Id %>">  <%=arrange.HaveBooked%>/<%=arrange.Capacity %></a></td>
                <td><a href="AddPackageArrange.aspx?arrangeId=<%=arrange.Id %>">修改</a></td>
                <td><a href="<%=arrange.Id %>" class="delete-arrange">删除</a></td>
            </tr>
        <%} %>
        </tbody>
    </table>
    
    <%--预约信息刷新--%>
    <script type="text/javascript">
        $(function () {
            $(document).ready(function () {
                do_refresh();
            });

            //静态删除课堂。
            $(".delete-arrange").live('click', function (event) {

                event.preventDefault();
                //console.log($(this).attr('href'));
                if (confirm("确认删除吗？如果删除，所有预约信息也将同时被删除！")) {
                    $.get("DeletePackageArrange.ashx", { arrangeId: $(this).attr('href') }, deleteCallback);
                }
            });


            function deleteCallback(data) {
                //alert(data);
                if (data == "1") {
                    alert('删除成功！');
                    location.reload(true);
                }
                else {
                    alert('删除失败！错误信息：' + data);
                }
            }


        });
      

    </script>
</asp:Content>
