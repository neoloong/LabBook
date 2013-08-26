<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="IndividualCenter.aspx.cs" Inherits="LabBook.IndividualCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>个人中心</title>
    <link href="_props/CSS/IndividualCenter.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="Information">
        <!--====================================修改个人资料=====================================-->
        <h3 class="topic" id="one">
            <a href="#one">个人资料</a></h3>
        <form class="InfoContent" action="IndividualCenter.aspx?id=1" method="post">
        <%if (Student != null)
          { %>
        <div class="num m">
            <label class="InfoTitle">
                学号：</label><%=Student.Id%>
        </div>
        <div class="name m">
            <label class="InfoTitle">
                姓名：</label><%=Student.Name%>

        </div>
        <div class="sex m">
            <label class="InfoTitle">
                性别：</label>
            男<input name="Sex" type="radio" value="male" <%=Student.Sex != null && Student.Sex==true ? "checked":"" %> />
            女<input name="Sex" type="radio" value="female" <%=Student.Sex != null && Student.Sex==false ? "checked":"" %> />
        </div>
        <div class="major m">
            <label class="InfoTitle">
                院系：</label><%=Student.College%>
        </div>
        <div class="class m">
            <label class="InfoTitle">
                班级：</label><%=Student.Class%>
        </div>
        <div class="tel m">
            <label class="InfoTitle">
                电话：</label><input type="text" class="tel" id="tel" value="<%=Student.PhoneNumber%>"
                    name="PhoneNumber" />
            <span class="errmsg1" id="error1"></span>
        </div>
        <div class="mailBox m">
            <label class="InfoTitle">
                邮箱：</label><input type="text" class="email" id="email" value="<%=Student.Email%>"
                    name="Email" /><span class="errmsg" id="error2"></span>
            <%}
          else
          {%>
            <h1>
                您所使用的用户没有与您关联！请联系管理员</h1>
            <%}%>
        </div>
        <%--<input class="button1" type="submit" value="保存修改" onclick="sAlert('<%=Message %>');" />--%>
        <input class="button1" type="submit" value="保存修改" />
        </form>
        <!--====================================修改密码======================================-->
        <h3 class="topic" id="two">
            <a href="#two">修改密码</a></h3>
        <form class="InfoContent" id="ChangePassword" action="IndividualCenter.aspx?id=2"
        method="post">
        <div class="CurrentPwd m">
            <label class="InfoTitle">
                当前密码：</label>
            <input type="password" name="OldPwd" />
        </div>
        <div class="NewPwd m">
            <label class="InfoTitle">
                新密码：</label>
            <input type="password" id="password" name="NewPwd" />
        </div>
        <div class="ConfirmPwd m">
            <label class="InfoTitle">确认密码：</label>
            <input type="password" id="confirm" name="ConfirmPwd" />
            <span class="errmsg3" id="error3"></span>
        </div>
        <%--<input class="button2" type="submit" value="确认修改" onclick="sAlert('<%=Message %>');" />--%>
        <input class="button2" type="submit" value="确认修改"  /><span class="errmsg4" id="Span1"></span>
        </form>
        <!--====================================预约统计======================================-->
        <h3 class="topic" id="three">
            <a href="#three">预约统计</a></h3>
        <form class="InfoContent third" action="IndividualCenter.aspx?id=3" method="post">
        <!--实验课程预约统计-->
        <table class="BookStats">
            <thead>
                <tr>
                    <th class="NameOfExpriment">实验名称</th>
                    <th class="TimeOfExpriment">时间</th>
                    <th class="PlaceOfExpriment">地点</th>
                    <th class="Cancel">操作</th>
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
                    <td><%=arrange.CoursePackage.Name %></td>
                    <td><%=arrange.CustomTime%></td>
                    <td><%=arrange.CoursePackage.Address %></td>
                    <td><a href="<%=arrange.Id %>" id="cancelPackageBook">取消预约</a></td>
                </tr>
                <%} %>
            </tbody>
        </table>
        </form>
    </div>
    
    <%--下拉滑动效果--%>
    <script type="text/javascript">
        $(document).ready(function () {
            var info_head = $('.Information> .topic'),
				info_body = $('.Information >.InfoContent');
            info_head.last().addClass('active').next().slideDown('normal');
            info_head.on('click', function (event) {
                event.preventDefault();
                if ($(this).attr('class') != 'active') {
                    info_body.slideUp('normal');
                    $(this).next().stop(true, true).slideToggle('normal');
                    info_head.removeClass('active');
                    $(this).addClass('active');
                }
            });
        });
    </script>

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


    <%--表单信息验证--%>
    <script type="text/javascript">
        $(function () {
            $(".button1").bind("click", function (event) {
                var str = $("#tel").val();
                if (str.length != 11) {
                    $(".errmsg1").html("电话应为11位号码！");
                    $("#error1").show();
                    event.preventDefault();

                }
            })
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $(".button1").bind("click", function (event) {
                var email = $("#email").val();
                var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
                if (!reg.test(email)) {
                    $(".errmsg").html("邮箱格式不正确！");
                    $("#error2").show();
                    event.preventDefault();
                }
                else { return true; }
            })
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $(".button2").bind("click", function (event) {
                var password = $("#password").val();
                var confirm = $("#confirm").val();
                if (password != confirm) {
                    $(".errmsg3").html("两次输入密码不同.");
                    $("#error3").show();
                    event.preventDefault();
                }
            })
        })
    </script>
 
</asp:Content>
