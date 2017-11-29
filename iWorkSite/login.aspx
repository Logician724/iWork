<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iWork Login</title>
    <link rel="stylesheet" type="text/css" href="content/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="content/login.css"/>
</head>
<body>
    <div class="main-container center-container">   
        <form class="center-container" runat="server">
            <div class ="center-container" >
                <img class=" img-responsive logo "  src="http://via.placeholder.com/350x150" alt="logo" />
            </div>
            <div class="center-container">
                <label class ="label">Username</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_username" runat="server" placeholder="Enter your username" ></asp:TextBox>
                <label class="label">Password</label>
                <asp:TextBox CssClass="txtbox input-lg" ID="txt_password" runat="server" TextMode="Password" placeholder="Enter your password" ></asp:TextBox>
                <asp:Button CssClass="button btn btn-success" ID="btn_login" runat="server" Text="Login" onclick="login"/>
                <asp:Button CssClass="button btn btn-success" ID="btn_register" runat="server" Text="Register" onclick="register"/>
            </div>
        </form>
    </div>
</body>
</html>
