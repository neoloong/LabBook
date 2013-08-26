<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="TeacherInfo.aspx.cs" Inherits="LabBook.TeacherInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>教师介绍</title>
    <link href="_props/css/TeacherInfo.css" rel="Stylesheet" type="text/css" />
    <script src="_props/js/jquery-1.6.3.min.js" type="text/javascript"></script>
    <script src="_props/JS/fancybox/jquery.fancybox-1.3.4.pack.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="_props/JS/fancybox/jquery.fancybox-1.3.4.css"
        media="screen" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("a.special").fancybox({
                'overlayShow': false,
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'


//                'titleShow'     : false,
//                'transitionIn': 'elastic',
//                'transitionOut': 'elastic',
//                'easingIn'      : 'easeOutBack',
//                'easingOut'     : 'easeInBack'
            })

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="HeadOfTeacherInfo">
        教师信息</h2>
    <div class="teachers fix">
        <%foreach (var teacher in TeacherList)
          {%>
        <div class="teacherInfo">
            <div style="padding: 5px; background: #e4e6e0;">
                <a class="special" href="#details<%=teacher.Id %>">
                    <img class="photo" alt="photo" src="<%=teacher.PhotoUrl%>" /></a>
            </div>
            <p class="teacherName">
                <%=teacher.Name %></p>
            <div style="display: none;">
                <div id="details<%=teacher.Id %>" class="details">
                    <p class="info">
                        <span>姓名:</span>
                        <%=teacher.Name %></p>
                    <p class="info">
                        <span>性别:</span>
                        <%=teacher.Sex==true?"男":"女" %></p>
                    <p class="info">
                        <span>电话:</span>
                        <%=teacher.PhoneNumber %></p>
                    <p class="info">
                        <span>备注:</span>
                        <%=teacher.Remarks %></p>
                </div>
            </div>
        </div>
        <%} %>
    </div>
    <%--话说我还是觉得这个好--%>
    <%--<div class="teachers fix">
    <%foreach (var teacher in TeacherList)
      {%>
    <div class="teacherInfo">
        <a id="photo" href="<%=teacher.PhotoUrl%>" title=" "><img class="last" alt="photo" src="<%=teacher.PhotoUrl%>" /></a>
        <img class="photo" src="<%=teacher.PhotoUrl%>" alt="照片" title="<%=teacher.Name %>"/>
        <div class="details">
        <p class="info"><span>姓名:</span>
        <%=teacher.Name %></p>
        <p class="info"><span>性别:</span>
        <%=teacher.Sex==true?"男":"女" %></p>
        <p class="info"><span>电话:</span>
        <%=teacher.PhoneNumber %></p>
        <p class="info"><span>备注:</span>
        <%=teacher.Remarks %></p>
        </div>
    </div>
    <%} %>
</div>--%>
</asp:Content>
