<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html>
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
                <asp:TextBox class="txtbox input-lg" ID="txt_username" runat="server" placeholder="Enter your username" ></asp:TextBox>
                <label class="label">Password</label>
                <asp:TextBox class="txtbox input-lg" ID="TextBox1" runat="server" TextMode="Password" placeholder="Enter your password" ></asp:TextBox>
                <asp:Button class="button btn btn-success" ID="log_start" runat="server" Text="Login" />
            </div>
        </form>
    </div>
</body>
</html>
