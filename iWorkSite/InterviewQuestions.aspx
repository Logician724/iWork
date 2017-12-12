<%@ page language="C#" autoeventwireup="true" codefile="InterviewQuestions.aspx.cs" inherits="InterviewQuestions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Interview Questions</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
</head>
<body>
    <form runat="server">
        <nav class="navbar navbar-toggleable-md fixed-top navbar-inverse bg-primary">
            <div class="collapse navbar-collapse">
                <a class="navbar-brand vertical-ruler pr-3 display-1" href="companies">iWork</a>
                <ul id="nav_list_primary" class="navbar-nav mr-auto mt-2 mt-lg-0" runat="server">
                    <li class="nav-item active">
                        <a class="nav-link h6" href="companies">Home</a>
                    </li>
                </ul>
                <ul id="nav_list_secondary" class="navbar-nav mt-2 mt-lg-0">
                    <li id="identity_control_1" class="nav-item active" runat="server">
                        <a class="nav-link h6" href="login">Login</a>
                    </li>
                    <li id="identity_control_2" class="nav-item active" runat="server">
                        <a class="nav-link h6" href="register">Register</a>
                    </li>
                </ul>
            </div>
        </nav>
        <asp:Panel ID="questions_panel" runat="server"></asp:Panel>
        <asp:Panel ID="answers_panel" runat="server"></asp:Panel>
        <asp:Panel ID="apply_panel" runat="server">
            <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="Apply" OnClick="ApplyForJob" />
            <div class="text-center mt-2 font-weight-bold text-danger" id="apply_response" runat="server"></div>
        </asp:Panel>
        <div>
        </div>
    </form>
</body>
</html>
