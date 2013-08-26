<%@ Page Title="" Language="C#" MasterPageFile="~/IndividualCenter.master" AutoEventWireup="true"
    CodeBehind="OrderState.aspx.cs" Inherits="LabBook.OrderState" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headChild" runat="server">
    <title>预约状态</title>
    <link href="_props/CSS/orderState.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <form class="InfoContent third" action="OrderState.aspx" method="post">
    <!--实验课程预约统计-->
    <table class="BookStats">
        <thead>
            <tr>
                <th class="NameOfExpriment">实验名称</th>
                <th>时间</th>
                <th>地点</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <%foreach (var arrange in CourseArrangeList)
              {%>
            <tr>
                <td>
                    <%=arrange.CourseInfo.Name %>
                </td>
                <td>
                    第<%=arrange.Week%>周<br />
                    星期<%switch (arrange.WeekDay)
                        {
                            case 1:%>一
                    <%break;
                                case 2:%>二
                    <%break;
                                case 3:%>三
                    <%break;
                                case 4:%>四
                    <%break;
                                case 5:%>五
                    <%break;
                                case 6:%>六
                    <%break;
                                case 7:%>日
                    <%break;
                                default:
                      break;


                            }%>
                    第<%=arrange.BeginLesson %>-<%=arrange.EndLesson%>节
                </td>
                <td>
                    <%=arrange.CourseInfo.Address %>
                </td>
                <td>
                    <a href="CancelBooking.aspx?arrangeId=<%=arrange.Id%>&studentId=<%=Student.Id %>">取消预约</a>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    <!--课程包预约统计-->
    <table class="BookStats">
        <thead>
            <tr>
                <th class="NameOfExpriment">实验包名称</th>
                <th class="TimeOfExpriment">时间</th>
                <th class="PlaceOfExpriment">地点</th>
                <th class="Cancel">操作</th>
            </tr>
        </thead>
        <tbody>
            <%foreach (var arrange in PackageArrangeList)
              {%>
            <tr>
                <td>
                    <%=arrange.CoursePackage.Name %>
                </td>
                <td>
                    <%=arrange.CustomTime%>
                </td>
                <td>
                    <%=arrange.CoursePackage.Address %>
                </td>
                <td>
                    <a href="<%=arrange.Id %>" id="cancelPackageBook">取消预约</a>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
    </form>
    <%--取消课程包预约--%>
    <script type="text/javascript">
        $(function () {
            $("#cancelPackageBook").click(function () {
                event.preventDefault();
                if (confirm("确认取消预约吗？")) {
                    $.get("CancelPackageBook.ashx", { arrangeId: $(this).attr('href') }, deleteCallback);
                }
            });

            function deleteCallback(data) {
                if (data == "1") {
                    alert('取消成功！');
                    location.reload(true);
                }
                else {
                    alert('取消失败！请联系管理员');
                }
            }
        });
    </script>
</asp:Content>
