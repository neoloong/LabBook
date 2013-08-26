<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="Bulletin.aspx.cs" Inherits="LabBook.Bulletin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>公告通知</title>
    <link href="_props/CSS/Bulletin.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="BullinMain">
        <h2 class="bulletinTitle"><%=bulletin.Title %></h2>
        <div class="releaser fix">
        
        <div class="data">
            <%=bulletin.Bulletiner %>发布于<%=bulletin.Date.ToString("yyyy年MM月dd日 hh:mm:ss") %>
        </div>
        <div class="bulletinContent">
            <p><%=bulletin.Content %></p>
        </div>
        </div>
    </div>
</asp:Content>
