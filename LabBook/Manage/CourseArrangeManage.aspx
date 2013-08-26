<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="CourseArrangeManage.aspx.cs" Inherits="LabBook.Manage.CourseArrangeManage1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>课堂管理@后台管理</title>
    <link href="../_props/CSS/CourseArrangeManage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        课堂管理</h3>
    <div class="heading">
        <p class="courseName" id="CourseName">
            <%=Course.Name %></p>
        <a class="addArrange" href="AddArrange.aspx?id=<%=Course.Id%>">添加课堂</a>
    </div>
    <form class="check">
    <label class="choseTime">
        周次</label>
    <select name="Week" class="select" id="week">
        <%
            for (var i = 1; i < 23; i++)
            { %>
        <option>第<%=i %>周</option>
        <%} %>
    </select>
    <label class="choseTime">
        星期</label>
    <select name="WeekDay" class="select" id="weekday">
        <option value="1">星期一</option>
        <option value="2">星期二</option>
        <option value="3">星期三</option>
        <option value="4">星期四</option>
        <option value="5">星期五</option>
        <option value="6">星期六</option>
        <option value="7">星期日</option>
    </select>
    <a id="search">查询</a>
    </form>
    <table id="arrange-list">
        <thead>
            <tr>
                <th title="date">
                    周次
                </th>
                <th title="date">
                    星期
                </th>
                <th>
                    节次
                </th>
                <th>
                    已预约/容量
                </th>
                <th>
                    修改
                </th>
                <th>
                    删除
                </th>
            </tr>
        </thead>
        <tbody>
            <%foreach (var arrange in ArrangeList)
              {%>
            <tr>
                <td>
                    <%=arrange.Week %>
                </td>
                <td>
                    <%=arrange.WeekDay %>
                </td>
                <td>
                    <%=arrange.BeginLesson %>-<%=arrange.EndLesson%>
                </td>
                <td>
                    <a href="ArrangeDetails.aspx?arrangeId=<%=arrange.Id %>"><%=arrange.CourseBookInfo.Count %>/<%=arrange.Capacity %></a>
                </td>
                <td>
                    <a href="AddArrange.aspx?arrangeId=<%=arrange.Id %>">修改</a>
                </td>
                <td>
                    <a class="delete-arrange" href="<%=arrange.Id %>">删除</a>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <div id="loading">
        <img src="../_props/images/ajax_loader.gif" alt="正在加载..." title="正在加载..." /><span>正在加载数据...</span>
    </div>
    <%--预约信息刷新--%>
    <script type="text/javascript">
        $(function () {
            //            $(document).ready(function () {
            //                do_refresh();
            //            });
            $("#loading").hide();
            $("#search").click(function () {
                do_refresh();
            });


            function do_refresh() {
                var weekval = $("#week").val();
                var weekdayval = $("#weekday").val();
                var idval = $.getUrlParam('courseId'); //获取课程Id 

                $("#arrange-list thead").siblings().children().remove();
                $("#arrange-list thead th").remove("th[title]==date");                
                $("#loading").show();
                $.get("../RefreshArranges.ashx", { id: idval, week: weekval, weekday: weekdayval }, refresh_arranges, 'json');
            }

            function refresh_arranges(data) {
                $("#loading").hide();
                for (var i = 0; i < data.length; i++) {
                    var tr = $('<tr></tr>');
                    var time = parseInt(data[i]["BeginLesson"]) + '-' + data[i]["EndLesson"] + '节';

                    tr.append($('<td>' + time + '</td>'));

                    tr.append($('<td><a href="ArrangeDetails.aspx?arrangeId=' + data[i]['Id'] + '">' + data[i]['HaveBookedNum'] + '/' + data[i]['Capacity'] + '</a></td>'));
                    tr.append($('<td><a href="AddArrange.aspx?arrangeId=' + data[i]['Id'] + '">修改</a></td>'));
                    tr.append($('<td><a  class="delete-arrange" href="' + data[i]['Id'] + '">删除</a></td>'));
                    tr.appendTo($("#arrange-list tbody")).hide().show(400);

                }
            }


            //静态删除课堂。
            $(".delete-arrange").live('click', function (event) {

                event.preventDefault();
                //console.log($(this).attr('href'));
                if (confirm("确认删除吗？如果删除，所有预约信息也将同时删除！")) {
                    $.get("DeleteCourseArrange.ashx", { arrangeId: $(this).attr('href') }, deleteCallback);
                }
            });


            function deleteCallback(data) {
                //alert(data);
                if (data == "1") {
                    alert('删除成功！');
                    do_refresh();
                }
                else {
                    alert('删除失败！错误信息：' + data);
                }
            }

            //            $("#arrange-list tbody p").live('click', function () {
            //                window.location=("AddArrange.aspx?id="+);
            //            });


            //获取Url参数。
            $.getUrlParam = function (name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); var r = window.location.search.substr(1).match(reg);
                if (r != null) return unescape(r[2]); return null;
            }

        });
      

    </script>
</asp:Content>
