<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Application.aspx.cs" Inherits="Application" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" type="text/css" href="Content/bootstrap.css"/>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Panel ID="questions_panel" runat="server" > </asp:Panel>
        <asp:Panel ID="answers_panel" runat="server" > </asp:Panel>



         <div class="text-center mt-1">
              <asp:Button CssClass="btn btn-primary" ID="btn_Apply" runat="server" Text="Apply" OnClick="ApplyForJob" />
         </div>

    <div>
    
    </div>

       
    </form>

  

</body>
</html>
