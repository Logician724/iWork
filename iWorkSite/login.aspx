<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>iWork Login</title>
    <link rel="stylesheet" type="text/css" href="css/login.css"/>
</head>
<body>
    <div class="main-container">   
        <form runat ="server">
            <div class="imgcontainer">
                <img src="" alt="logo" class="logo" />
            </div>
            <div class="container">
                <label>Username</label>
                <asp:TextBox class="txtbox" ID="txt_username" runat="server" placeholder="Enter your username" ></asp:TextBox>
                <label>Password</label>
                <asp:TextBox class="txtbox" ID="TextBox1" runat="server" TextMode="Password" placeholder="Enter your password" ></asp:TextBox>
                <asp:Button class="submit-button" ID="log_start" runat="server" Text="Login" />
            </div>
        </form>
    </div>
</body>
</html>
