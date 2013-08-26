<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="AllBulletins.aspx.cs" Inherits="LabBook.AllBulletins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>公告通知列表</title>
<link href="_props/CSS/AllBulletins.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h2 class="bulletinBoard">公告通知</h2>
    <table class="bulletinTable">
    <thead>
    <tr>
        <th class="BulletinTitle">标题</th>
        <th>发布者</th>
        <th>发布时间</th>
    </tr>
    </thead>
    
    <tbody>
    <% foreach (var item in BulletinList)
       { %>
       <tr>
       <td  class="BulletinTitle"><a href="Bulletin.aspx?id=<%=item.Id %>">
        <%=item.Title %></a> </td>
        <td class="Bulletiner">
        <%=item.Bulletiner %>
        </td>
        <td class="Data">
        <%=item.Date.ToShortDateString() %>
        </td>
        
        </tr>
    <%} %>
    </tbody>
    </table>
</asp:Content>
