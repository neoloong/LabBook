<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="TeacherModify.aspx.cs" Inherits="LabBook.Manage.TeacherModify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 >
        教师信息更改</h3>
    <form  action="TeacherModify.aspx?teacherId=<%=Teacher.Id %>" method="post" enctype="multipart/form-data">
    <div class="addbox">
        <span class="addItem">姓名：</span>
        <input class="inputArea" type="text" name="Name" value="<%=Teacher.Name %>" />
    </div>
    <div class="addbox">
        <span class="addItem">性别：</span> 男<input name="Sex" type="radio" value="male" <%=Teacher.Sex != null && Teacher.Sex==true ? "checked":"" %> />
        女<input name="Sex" type="radio" value="female" <%=Teacher.Sex != null && Teacher.Sex==false ? "checked":"" %> />
    </div>
    <div class="addbox">
        <span class="addItem">用户名：</span>
        <input class="inputArea" type="text" name="Account" value="<%=Teacher.Account.UserName %>"/>
    </div>
    <div class="addbox">
        <span class="addItem">密码：</span>
        <input class="inputArea" type="text" name="Password" />
    </div>
    <div class="addbox">
        <span class="addItem">电话：</span>
        <input class="inputArea" type="text" name="Tel" value="<%=Teacher.PhoneNumber %>"/>
    </div>
    <div class="addbox">
        <span class="addItem">备注：</span>
        <textarea rows="10" cols="48" name="Remarks"><%=Teacher.Remarks %></textarea>
    </div>
    <div class="addbox">
        <span class="addItem">上传照片：</span>
        <input type="file" name="Photo" accept="image/*" />
    </div>
    <input class="submit" type="submit" value="提交" id="submit" />
    </form>
</asp:Content>
