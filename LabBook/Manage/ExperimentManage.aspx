<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="ExperimentManage.aspx.cs" Inherits="LabBook.Manage.ExperimentManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>实验大类管理@后台管理</title>
    <link href="../_props/CSS/ExperimentManage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">实验管理</h3>
    <%if (SemesterList != null)
      {%>
    <form class="ChooseTerm" action="ExperimentManage.aspx" method="post">
    <label>
        选择学期</label>
    <select id="term">
        <%foreach (var semester in SemesterList)
          {%>
        <option value="<%=semester.Id %>">
            <%=semester.SchoolYear + "年  " + semester.Season%></option>
        <%} %>
    </select>
    <%--<span class="AddNewTerm"><a href="#">删除此学期</a></span>--%>
    <input type="button" value="删除" id="deleteTerm" />
    <%} %>
    <span class="AddNewTerm"><a href="AddNewTerm.aspx">添加新学期</a></span>d
    </form>
    <table class="Sort" id="experiment-list">
        <thead>
            <tr>
                <th class="SortTitle">实验大类名称</th>
                <th>实验课程管理</th>
                <th>课程包管理</th>
                <th>详情</th>
            </tr>
        </thead>
        <%if (ExperimentList.GetEnumerator()!=null)
          { %>
        <tbody>
            <%foreach (var experiment in ExperimentList)
              {%>
            <tr>
                <td>
                    <%=experiment.Name%>
                </td>
                <td>
                    <a href="CourseManage.aspx?id=<%=experiment.Id %>">实验课程管理</a>
                </td>
                <td>
                    <a href="PackageManage.aspx?id=<%=experiment.Id %>">课程包管理</a>
                </td>
                <td>
                    <a href="ExperimentDetails.aspx?id=<%=experiment.Id %>">详情</a>
                </td>
            </tr>
            <%} %>
        </tbody>
        <%} %>
    </table>
    <div id="ajax_div1">
        <img src="../_props/images/ajax_loader.gif" alt="正在加载..." title="正在加载..." /><span>正在加载数据...</span>
    </div>
    <%--如果不是当前学期，则不允许添加实验大类，add-experiment-div需要隐藏--%>
    <div id="add-experiment-div">
        <h3 class="title flip">
            添加实验大类</h3>
        <form class="AddSort" action="ExperimentManage.aspx" method="post" enctype="multipart/form-data">
        <div class="addbox">
            <span class="addItem">实验大类名称：</span>
            <input class="inputArea" type="text" name="Name" />
        </div>
        <div class="addbox">
            <span class="addItem">上传图片：</span>
            <input class="AddFile" type="file" name="Photo" value="选择文件" accept="image/*" />
        </div>
        <input class="submit" type="submit" value="添加" />
        </form>
    </div>
    <%--获取实验大类列表--%>
    <script type="text/javascript">
        $(function () {
            $(document).ready(function () {
                $("#ajax_div1").hide();
            })
            //var term=$("#term").val();
            //$.get("RefreshExperiment.ashx", { termId: term }, refresh_experiment, 'json');

            $("#term").change(function () {

                $("#ajax_div1").show();
                $("#experiment-list thead").siblings().children().remove();
                var term = $("#term").val();
                $.get("RefreshExperiment.ashx", { termId: term }, refresh_experiment, 'json');
            });

            function refresh_experiment(data) {
                $("#ajax_div1").hide();
                //alert(data);
                var tr, td;
                for (var i = 0; i < data.length; i++) {
                    tr = $('<tr></tr>');

                    for (var key in data[i]) {
                        if (key == 'Name')
                            td = $('<td>' + data[i][key] + '</td>');
                        else
                            td = $('<td><a href="CourseManage.aspx?id=' + data[i][key] + '">实验课程管理</a></td><td><a href="PackageManage.aspx?id=' + data[i][key] + '">课程包管理</a></td><td><a href="ExperimentDetails.aspx?id=' + data[i][key] + '">详情</a></td>');
                        td.appendTo(tr).hide().fadeIn(400);
                    }

                    $("#experiment-list tbody").append(tr);
                }
            }
        });
    </script>
    <script type="text/javascript">
        $(function () {
            var url = "DeleteTerm.ashx"
            id = $("#term").val();
            $("#deleteTerm").click(function () {
                if (confirm("确定要删除么？所有此实验大类下的实验及预约信息将同时被删除！")) {
                    $.get(url, { id: id }, deleteCallback);
                }

            });
            function deleteCallback(data) {
                alert(data);
                window.location = "../Manage/ExperimentManage.aspx";
            }

        });
    </script>
    <%--下拉效果--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".flip").click(function () {
                $(".AddSort").slideToggle("slow");
            });
        });
    </script>
</asp:Content>
