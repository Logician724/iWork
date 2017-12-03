<%@ page language="C#" autoeventwireup="true" codefile="Login.aspx.cs" inherits="Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iWork Login</title>
    <link rel="stylesheet" type="text/css" href="content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="content/login.css" />
</head>
<body class="jumbotron">
    <div class="container">
        <div class="container">
            <h1 class="display-2 text-center">Login Here</h1>
            <p class="lead text-center">Your profile awaits!</p>
        </div>
        <div class="container">
            <form runat="server">
                <div class="form-group row ">
                    <label class="font-weight-bold col-2 col-form-label offset-3">Username</label>
                    <div class="col-3">
                        <asp:TextBox CssClass="form-control" ID="txt_username" runat="server" placeholder="Enter your username"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="font-weight-bold col-2 col-form-label offset-3">Password</label>
                    <div class="col-3">
                        <asp:TextBox CssClass="form-control" ID="txt_password" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="btn_login" runat="server" Text="Login" OnClick="login" />

                    </div>
                    <div class="text-center mt-1">
                        <asp:Button CssClass="btn btn-primary" ID="btn_register" runat="server" Text="Register" OnClick="register" />
                    </div>
                </div>
                <div class="text-center mt-2 font-weight-bold text-danger" id="login_response" runat="server"></div>
            </form>
        </div>
    </div>  
</body>
</html>
