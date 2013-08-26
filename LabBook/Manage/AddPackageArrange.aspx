<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="AddPackageArrange.aspx.cs" Inherits="LabBook.Manage.AddPackageArrange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>课堂安排@后台管理</title>
<link href="../_props/CSS/AddPackageArrange.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="title">课堂安排</h3>
    <p class="PackageName"><%=Package.Name %></p>
    <form action="" method="post">
        <div class="addbox">
            <lable class="addItem">自定义课堂时间安排</lable>
            <textarea name="CustomTime" cols="30" rows="5"><%if (Arrange!=null) {%>  <%=Arrange.CustomTime %> <%} %></textarea>
        </div>
        <div class="addbox">
            <lable class="addItem">容量</lable>
            <select name="Capacity" style="width:200px;">
                <%if(Arrange!=null)
              { %>
                <option value="<%=Arrange.Capacity %>">
                    <%=Arrange.Capacity %>人 </option>
                <%} %>
                <%for (var i = 1; i < 60; i++)
                  { %>
                <option value="<%=i %>">
                    <%=i %>人</option>
                <%} %>
            </select>
        </div>
        <input type="submit" class="submit" value="提交" />
    </form>
</asp:Content>
