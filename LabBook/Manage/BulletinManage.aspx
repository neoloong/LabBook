<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="BulletinManage.aspx.cs" Inherits="LabBook.Manage.BulletinManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>通知公告@后台管理</title>
    <link href="../_props/css/BulletinManage.css" rel="stylesheet" type="text/css" />
    <script src="../_props/JS/delete_bulletin.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">
        公告列表</h3>
    <span class="publish"><a href="AddBulletin.aspx">发布新公告</a></span>
    <table class="bulletinTable">
        <thead>
            <tr>
                <th class="BulletinTitle">标题</th>
                <th>发布时间</th>
                <th> 发布人</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
        </thead>
        <tbody>
            <%foreach (var bulletin in AllBulletin)
              {%>
            <tr id="<%=bulletin.Id %>">
                <td>
                    <a href="../Bulletin.aspx?id=<%=bulletin.Id %>">
                        <%=bulletin.Title%></a>
                </td>
                <td>
                    <%=bulletin.Date%>
                </td>
                <td>
                    <%=bulletin.Bulletiner%>
                </td>
                <td>
                    <a href="ModifyBulletin.aspx?id=<%=bulletin.Id %>">修改</a>
                </td>
                <td>
                    <%--<a href="DeleteBulletin.aspx?id=<%=bulletin.Id %>">删除</a>--%>
                    <a href="#" onclick="post(<%=bulletin.Id %>)">删除</a>
                </td>
            </tr>
            <%} %>
        </tbody>
    </table>
</asp:Content>
