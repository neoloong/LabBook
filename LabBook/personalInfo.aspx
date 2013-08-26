<%@ Page Title="" Language="C#" MasterPageFile="~/IndividualCenter.master" AutoEventWireup="true"
    CodeBehind="personalInfo.aspx.cs" Inherits="LabBook.personalInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headChild" runat="server">
    <title>个人资料</title>
    <link href="_props/CSS/personalInfo.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="Information">
        <form class="InfoContent" action="personalInfo.aspx" method="post">
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
        <input class="button" type="submit" value="保存修改"/><span class="errmsg" id="checked"><%=Message %></span>
        </form>
    </div>

 <%--表单信息验证--%>
 <script type="text/javascript">
     $(function () {
         $(".button").bind("click", function (event) {
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
            $(".button").bind("click", function (event) {
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
</asp:Content>