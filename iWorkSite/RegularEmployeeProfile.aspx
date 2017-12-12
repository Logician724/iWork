<%@ page language="C#" autoeventwireup="true" codefile="RegularEmployeeProfile.aspx.cs" inherits="RegularEmployeeProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
</head>
<body class="jumbotron">
    <form runat="server">
        <nav class="navbar navbar-toggleable-md fixed-top navbar-inverse bg-primary">
            <div class="collapse navbar-collapse">
                <a class="navbar-brand vertical-ruler pr-3 display-1" href="companies">iWork</a>
                <ul id="nav_list_primary" class="navbar-nav mr-auto mt-2 mt-lg-0" runat="server">
                    <li class="nav-item active">
                        <a class="nav-link h6" href="companies">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link h6" href="Staff">Staff</a>
                    </li>
                </ul>
                <ul id="nav_list_secondary" class="navbar-nav mt-2 mt-lg-0" runat="server">
                    <li class="nav-item">
                        <a class="nav-link h6" onserverclick="SignOut" runat="server">Sign Out</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="container mt-5">
            <ul class="nav nav-tabs justify-content-center">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#personal_info">View Info</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#edit_info">Edit Info</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#viewproject_panel">View Projects</a>
                </li>
            </ul>
            <div class="tab-content">
                <div id="personal_info" class="tab-pane active" runat="server"></div>
                <div id="edit_info" class="tab-pane" runat="server">
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Password</label>
                        <div class="col-10">
                            <asp:TextBox CssClass="form-control" ID="txt_password" runat="server" TextMode="Password" placeholder="Change password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Personal Email</label>
                        <div class="col-10">
                            <asp:TextBox CssClass="form-control" ID="txt_personalemail" runat="server" placeholder="Change Personal Email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Birthdate</label>
                        <div class="col-10">
                            <asp:TextBox CssClass="form-control" ID="txt_birthdate" runat="server" placeholder="Change Birthdate (MM/DD/YY)"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Experience Years</label>
                        <div class="col-10">
                            <asp:TextBox CssClass="form-control" ID="txt_expyrs" runat="server" placeholder="Update Experience Years"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">First Name</label>
                        <div class="col-10">
                            <asp:TextBox CssClass="form-control" ID="txt_fn" runat="server" placeholder="Change First Name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Last Name</label>
                        <div class="col-10">
                            <asp:TextBox CssClass="form-control" ID="txt_ln" runat="server" placeholder="Change Last Name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="center-block">
                        <asp:Button CssClass="btn btn-primary" ID="btn_login" runat="server" Text="Apply Changes" OnClick="editPersonalInfo" />
                    </div>
                </div>
                <div id="viewproject_panel" class="tab-pane" runat="server">
                    <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="My Projects" OnClick="viewProjects" />
                    <div id="viewtasks_panel" runat="server">
                        <asp:TextBox CssClass="form-control" ID="proj_name" runat="server" placeholder="Enter Project Name"></asp:TextBox>
                        <asp:Button CssClass="btn btn-primary" ID="Button2" runat="server" Text="My Tasks" OnClick="viewTasks" />
                        <div class="text-center mt-2 font-weight-bold text-danger" id="tasks_response" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!--jquery-->
    <script type="text/javascript" src="Scripts/jquery-3.2.1.js"></script>
    <!--tether-->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.3/js/tether.min.js"></script>
    <!--bootstrap.js-->
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>
</body>
</html>
