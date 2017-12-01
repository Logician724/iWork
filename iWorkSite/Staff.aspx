<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Staff.aspx.cs" Inherits="Staff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <link rel="stylesheet" type="text/css" href="Content/bootstrap.css"/>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Button CssClass="btn btn-primary" ID="Button2" runat="server" Text="Check In" OnClick="CheckIn" />
        <div class="text-center mt-2 font-weight-bold text-danger" id="checkin_response" runat="server"></div>
        
        <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="Check Out" OnClick="CheckOut" />
        <div class="text-center mt-2 font-weight-bold text-danger" id="checkout_response" runat="server"></div>

    </form>
</body>
</html>
