<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.Master" AutoEventWireup="true"
    CodeBehind="ExperimentDetails.aspx.cs" Inherits="LabBook.Manage.ExperimentDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h3 class="title">
            <%=Experiment.Name %></h3>
        <%if (Experiment.PhotoUrl == null)
          { %>
        <img  src="../Datas/Photos/Experiment/暂时没有图片.jpg" />
        <%}
          else
          {%>
        <img src="<%=Experiment.PhotoUrl %>" alt="<%=Experiment.Name %>" title="<%=Experiment.Name %>" />
        <%} %>
    </div>
    <form action="DeleteExperiment.ashx" method="post" id="deleteExperimentForm">
    <input type="hidden" value="<%=Experiment.Id %>" id="hiddenId" />
    <input type="submit" value="删除" id="deleteExperiment" />
    </form>
    <script type="text/javascript">
        $(function () {
            var url = $("#deleteExperimentForm").attr("action"),
            id = $("#hiddenId").val();
            $("#deleteExperiment").click(function () {
                if (confirm("确定要删除么？所有本学期下的全部实验及预约信息将同时被删除！")) {
                    $.get(url, { id: id }, deleteCallback);
                }
                return false;
            });
            function deleteCallback() {
                alert("删除成功！");
                window.location = "../Manage/ExperimentManage.aspx";
            }

        });
    
    </script>
</asp:Content>
