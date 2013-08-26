<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="BookCourse.aspx.cs" Inherits="LabBook.Reservation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>实验课程简介</title>
    <link href="_props/CSS/BookCourse.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="Box">
        <h3 class="HeadOfContent">
            实验简介</h3>
        <div class="DescriptionContent fix">
            <%-- <img class="PicOfExpriment" src="_props/images/Experiment_Pic_1.jpg" alt="" />--%>
            <img class="PicOfExpriment" src="<%=Course.PhotoUrl %>" alt="" />
            <div class="description">
                <p>
                    实验名称：<%=Course.Name %></p>
                <p>
                    指导老师：<a class="teacherLink" href="TeacherInfo.aspx"><%=Course.TeacherId==null?"暂无":Course.TeacherInfo.Name %></a></p>
                <p>
                    实验地点：<%=Course.Address %></p>
                <p>
                    学时：<%=Course.ClassHour %></p>
                <p class="intro">
                    简介：<%=Course.Introduction%></p>
            </div>
            <a class="more" href="<%=Course.Attention %>" target="_blank">注意事项</a>
        </div>
    </div>
    <h3 class="HeadOfContent" id="headOfBooking">
        预约</h3>
    <%if (IsBooked)
      { %>
    <span class="isbooked">你已预约此实验！</span>
    <%} %>
    <form class="BookingTime fix" action="BookCourse.aspx" method="get">
    <h4 class="HeadOfBookingTime">
        预约时间</h4>
    <select name="Week" class="select" id="week">
        <%
            for (var i = 1; i < 23; i++)
            { %>
        <option value="<%=i %>">第<%=i %>周</option>
        <%} %>
    </select>
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
    <div class="Book" id="book-fix">
        <%foreach (var arrange in Course.CourseArrange)
          {%>
        <div class="BookBox">
            <span>状态：</span><%if (arrange.Capacity > arrange.CourseBookInfo.Count)
                              { %>
            <span>未约满</span>
            <%}
                              else
                              { %>
            <span style="color: red">已约满 </span>
            <%} %>
            <span>时间：</span><span><%=arrange.Week%>周 星期<%=arrange.WeekDay %></span> <span>容量：</span><span><%=arrange.Capacity %></span>
            <span>已预约：</span><span><%=arrange.CourseBookInfo.Count %>/<%=arrange.Capacity %></span>
            <%if (!IsBooked && arrange.Capacity > arrange.CourseBookInfo.Count)
              {%>
            <span class="BookingChaining"><a class="book" id="<%=arrange.Id %>">预约</a></span>
            <%} %>
        </div>
        <%} %>
    </div>
    <h3 class="HeadOfContent" id="headOfMessage">
        留言板</h3>
    <div class="MessageBoard">
        <!-- UY BEGIN -->
        <div id="uyan_frame">
        </div>
        <script type="text/javascript" id="UYScript" src="http://v1.uyan.cc/js/iframe.js?UYUserId=1637236"
            async=""></script>
        <!-- UY END -->
    </div>
    <%--学号信息隐藏域--%>
    <%--warning!这里会被注入--%>
    <input type="hidden" value="<%=Student.Id %>" id="student" />
    <script type="text/javascript" src="_props/js/curvycorners.js"></script>
    <%--预约信息刷新--%>
    <script type="text/javascript">
        $(function () {
            $(document).ready(function () {
                //do_refresh();
                $(".book").on('click', function () {
                    booking($(this).attr('id'));
                  
                });
            });

            $("#search").click(function () {
                do_refresh();
            });


            //实验预约按钮点击事件
            function booking(arrangeid) {
                //alert(arrangeid);
                var studentid = $("#student").val();
                $.get("BookingCourse.ashx", { arrangeid: arrangeid, studentid: studentid }, booked);

            }

            function booked(data) {
                if (data == '1') {
                    alert('预约成功！请在个人中心查看！');
                    do_refresh();
                }
                else {
                    alert(data);
                }
            }


            function do_refresh() {
                var weekval = $("#week").val();
                var weekdayval = $("#weekday").val();
                var idval = $.getUrlParam('id'); //获取课程Id 

                $("#book-fix").children().remove();
                $.get("RefreshArranges.ashx", { id: idval, week: weekval, weekday: weekdayval }, function (data) {
                    refresh_arranges(data);
                    //预约按钮事件绑定。
                    $(".book").on('click', function () { booking($(this).attr('id')); });
                }, 'json');


            }

            function refresh_arranges(data) {
                for (var i = 0; i < data.length; i++) {
                    var div = $('<div class="BookBox"></div>');

                    var condition = data[i]['Capacity'] > data[i]['HaveBookedNum'] ? 1 : 0;

                    if (condition == 1) {
                        div.append($('<span>状态：</span><span>未约满</span>'));
                    }
                    else {
                        div.append($('<span>状态：</span><span style="color:red">已约满 </span>'));
                    }


                    var time = parseInt(data[i]["BeginLesson"]) + '-' + data[i]["EndLesson"] + '节';

                    var spans = $('<span>时间：</span><span>' + time + '</span><span>容量：</span><span>' + data[i]['Capacity'] + '</span><span>已预约：</span><span>' + data[i]['HaveBookedNum'] + '</span>');
                    div.append(spans);
                    if (data[i]['CanBook'] == true) {
                        //div.append('<span class="BookingChaining"><a class="book"  onclick="booking(' + data[i]['Id'] + ')">预约</a></span>');
                        div.append('<span class="BookingChaining"><a class="book"  id="' + data[i]['Id'] + '">预约</a></span>');
                    }
                    div.appendTo($('#book-fix'));
                }


            }


            //$(".book").live('click', booking($(this).attr('id')));


        });
        

    </script>
    <script type="text/javascript">
        $(function () {
            $("#textinput").bind("click", function (event) {
                $("#textinput").hide();
                $("#publish").show();
                $("#publishBox").focus();
            })
            $("#publishBox").onblur = function () {
                if (input === '') {
                    $("#publish").style.display = "block";
                }
            }

        })
        $(function () {
            $(".replay").bind("click", function (event) {
                $("#textinput").hide();
                $("#publish").show();
                $("#publishBox").focus();
            })
        })
    </script>
</asp:Content>
