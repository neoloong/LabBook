<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="LabBook.Index" %>

<%@ Import Namespace="System.Linq" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>光电学院实验预约系统首页</title>
    <link href="_props/css/Index.css" rel="Stylesheet" type="text/css" />
    <script src="_props/js/jquery-1.6.3.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="middle">
        <div class="slider-wrapper">
            <div class="slider">
                <ul class="items">
                    <li>
                        <img src="_props/images/slider-img1.jpg" alt="" />
                    </li>
                    <li>
                        <img src="_props/images/slider-img2.jpg" alt="" />
                    </li>
                    <li>
                        <img src="_props/images/slider-img3.jpg" alt="" />
                    </li>
                    <li>
                        <img src="_props/images/slider-img4.jpg" alt="" />
                    </li>
                </ul>
            </div>
            <ul class="pagination">
                <li class="item-1"><strong>01</strong></li>
                <li class="item-2"><strong>02</strong></li>
                <li class="item-3"><strong>03</strong></li>
                <li class="item-4"><strong>04</strong></li>
            </ul>
        </div>
    </div>
    <div class="mainOfContent">
        <div class="news">
            <h3 class="hnews">
                通知公告</h3>
            <p class="more">
                <a href="AllBulletins.aspx">more>></a></p>
            <%foreach (var bul in BulletinList)
              {%>
            <p class="newsList">
                <a href="Bulletin.aspx?id=<%=bul.Id %>" title="<%=bul.Title %>">
                   <span class="newsDate">
                    <%=bul.Date.ToString("MM.dd") %>
                </span> <span><%=bul.Title.Length > 12 ? bul.Title.Substring(0, 11)+"…" : bul.Title%></span></a>
            </p>
            <%} %>
        </div>
        <div class="ExperimentSort">
            <h3 class="expriment">
                实验大类</h3>
            <ul class="ExprimentItem">
                <%
                    if (presentTerm != null && ExperimentList.ToList().Count != 0)
                    {
                        foreach (var exp in ExperimentList)
                        {%>
                <li class="listTitle"><a href="SelectCourse.aspx?id=<%=exp.Id%>">
                    <%=exp.Name%></a></li>
                <%}
            } %>
            </ul>
        </div>
    </div>
    <script type="text/javascript">
        var defaultOpts = { interval: 4000, fadeInTime: 500, fadeOutTime: 500 };
        var _titles = $(".pagination li");
        var _bodies = $(".items li");
        var _count = _titles.length;
        var _current = 0;
        var _intervalID = null;
        var stop = function () { window.clearInterval(_intervalID); };
        var slide = function (opts) {
            if (opts) {
                _current = opts.current || 0;
            } else {
                _current = (_current >= (_count - 1)) ? 0 : (++_current);
            };
            _bodies.filter(":visible").fadeOut(defaultOpts.fadeOutTime, function () {
                _bodies.eq(_current).fadeIn(defaultOpts.fadeInTime);
            });

        };
        var go = function () {
            stop();
            _intervalID = window.setInterval(function () { slide(); }, defaultOpts.interval);
        };
        var itemMouseOver = function (target, items) {
            stop();
            var i = $.inArray(target, items);
            slide({ current: i });
        };
        _titles.hover(function () { if ($(this).attr('class') != 'on') { itemMouseOver(this, _titles); } else { stop(); } }, go);
        _bodies.hover(stop, go);
        go();
    </script>
</asp:Content>
