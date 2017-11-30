<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <title></title>
</head>
<body>
      <div class="main-container center-container">   
        <form class="center-container" runat="server">
            <div class="center-container">
                <label class ="label">Username</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_username" runat="server" placeholder="Enter your username" ></asp:TextBox>
                <label class="label">Password</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_password" runat="server" TextMode="Password" placeholder="Enter your password" ></asp:TextBox>
                <label class="label">Email</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_email" runat="server" placeholder="Eg: example@example.com" ></asp:TextBox>
                <label class="label">Birthdate</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_birthdate" runat="server" placeholder="M/D/Y" ></asp:TextBox>
                <label class="label">Number of Experience Years</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_expyrs" runat="server" placeholder="Enter number" ></asp:TextBox>
                <label class="label">First Name</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_fn" runat="server" placeholder="Enter First Name" ></asp:TextBox>
                <label class="label">Last Name</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_ln" runat="server" placeholder="Enter Last Name" ></asp:TextBox>
                
                <asp:Button CssClass="button btn btn-success" ID="btn_login" runat="server" Text="Register" onclick="register"/>
            </div>
        </form>
    </div>
</body>
</html>
