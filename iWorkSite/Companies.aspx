<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostBack="true" CodeFile="Companies.aspx.cs" Inherits="Companies" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="Content/companies.css"/>
    <title>Home</title>
</head>
<body>

<div  class="main-container center-container" > 


   <form id="div_main" class="container" runat="server">
   <asp:TextBox CssClass="txtbox input-lg"  ID="txt_search" runat="server" placeholder="Search" ></asp:TextBox>
   <asp:Button CssClass="button btn btn-success" ID="btn_search_byname" runat="server" Text=  "Search"  onclick="searchCompaniesByName"  />
   </form>

</div>
   
</body>
</html>
