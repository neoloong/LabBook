<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="BookPackage.aspx.cs" Inherits="LabBook.BookPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>预约实验课程包</title>
    <link href="_props/CSS/BookPackage.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="Box">
        <h3 class="HeadOfContent">
            课程包简介</h3>
        <div class="DescriptionContent fix">
            <div class="description">
            <span>指导老师</span> <%=Package.TeacherId==null?"暂无":Package.TeacherInfo.Name %>
                <span>包含课程：</span>
                <ul>
                    <%foreach (var course in Package.PackagedCourse)
                      { %>
                    <li>
                        <%=course.CourseInfo.Name %>
                    </li>
                    <%} %>
                </ul>
            </div>
            <a class="more" href="#">注意事项</a>
        </div>
    </div>
    <div class="Box fix" id="book-fix">
        <h3 class="HeadOfContent">
            预约</h3> <%if (IsBooked(Student, Package))
                      { %>
            <span class="isbooked">已预约</span>
            <% }%>
        <%foreach (var arrange in Package.PackageArrange)
          { %>
        <div class="BookBox">
            <span>状态：</span>
            <%if (arrange.PackageBookInfo.Count < arrange.Capacity)
              {%>
            <span class="canBook">可以预约</span>
            <%}
              else
              { %>
            <span class="canBook">已约满</span>
            <%} %>


            <span>时间：</span><span><%=arrange.CustomTime %></span> <span>容量：</span><span><%=arrange.Capacity%></span>
            <span>已预约：</span><span><%=arrange.PackageBookInfo.Count %></span>
            <%if (CanBeBooked(arrange, Student))
              {%>
            <span class="bookingbutton"><a onclick="booking(<%=arrange.Id %>)">预约</a></span>
            <%} %>
        </div>
        <%} %>
    </div>

    <div class="Box">
        <h3 class="HeadOfContent">
            留言板</h3>
        <div class="MessageBoard">
            <div class="massage fix">
               
                <!-- UY BEGIN -->
                <div id="uyan_frame">
                </div>
                <script type="text/javascript" id="UYScript" src="http://v1.uyan.cc/js/iframe.js?UYUserId=1637236"
                    async=""></script>
                <!-- UY END -->
            </div>
           
        </div>
    </div>
    <%-- <script type="text/javascript">
        $(function () {
            window.onunload = function () {
                alert(getFlashMessageFromCookie());
                deleteFlashMessageCookie();
            };


            function getFlashMessageFromCookie() {
                return $.cookie("FlashMessage");
            }

            function deleteFlashMessageCookie() {
                $.cookie("FlashMessage", null, { path: '/' });
            }
        });


        
    </script>--%>
    <%--  <script type="text/javascript">
      $(function () {
          $(document).ready(function () {
              do_refresh();


          });

          function do_refresh() {
              
              var id = $.getUrlParam('id'); //获取课程Id 

              $("#book-fix").children().remove();
              $.get("RefreshPackageArranges.ashx", { pacakgeId:id} , refresh_arranges, 'json');
          }

          function refresh_arranges(data) {
              for (var i = 0; i < data.length; i++) {
                  var div = $('<div class="BookBox"></div>');

                  var condition = data[i]['Capacity'] > data[i]['HaveBookedNum'] ? 1 : 0;

                  if (condition == 1) {
                      div.append($('<span>状态：</span><span>可以预约</span>'));
                  }
                  else {
                      div.append($('<span>状态：</span><span style="color:red">已约满 </span>'));
                  }


                  var time = parseInt(data[i]["BeginLesson"]) + '-' + data[i]["EndLesson"] + '节';

                  var spans = $('<span>时间：</span><span>' + time + '</span><span>容量：</span><span>' + data[i]['Capacity'] + '</span><span>已预约：</span><span>' + data[i]['HaveBookedNum'] + '</span>');
                  div.append(spans);
                  if (condition == 1) {
                      div.append('<span class="BookingChaining"><a class="book"  onclick="booking(' + data[i]['Id'] + ')">预约</a></span>')
                  }
                  div.appendTo($('#book-fix'));
              }


          }

          //获取Url参数。
          $.getUrlParam = function (name) {
              var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); var r = window.location.search.substr(1).match(reg);
              if (r != null) return unescape(r[2]); return null;
          }

      });
    --%>
    <%--预约数据传输--%>
    <script type="text/javascript">


        //实验预约按钮点击事件
        function booking(arrangeid) {
            $.get("BookingPackage.ashx", { arrangeid: arrangeid }, booked);
        }

        function booked(data) {
            if (data == '1') {
                alert('预约成功！请在个人中心查看！');
                location.reload(true);
            }
            else {
                alert(data);
            }
        }
    </script>
</asp:Content>
