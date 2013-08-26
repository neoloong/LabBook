<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="LabBook.Booking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="_props/css/booking.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="sort">

<form>
<label>实验分类：</label>
<select name="cars">
<option value="volvo">光电信息技术实验1</option>
<option value="saab">光纤技术实验2</option>
<option value="fiat">课外开放</option>
<option value="audi">物理光学实验</option>
<option value="volvo">应用光学实验</option>
<option value="saab">工程硕士——激光原理与技术实验</option>
<option value="fiat">工程硕士——工程光学实验</option>
<option value="audi">工程硕士——光电探测技术实验</option>
<option value="fiat">光电信息技术实验2</option>
<option value="audi">光电子拓展试验</option>
<option value="volvo">激光实验</option>
<option value="saab">光纤技术实验1</option>
<option value="fiat">工程硕士——现代光学实验</option>
<option value="audi">工程硕士——光纤光学实验</option>
</select>
</form>
</div>
<div class="list">
<h3>实验列表</h3>
<div class="experimentList">
<div class="experiment">
<div></div>
</div>
</div>
</div>
</asp:Content>
