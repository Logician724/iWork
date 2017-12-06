<%@ page language="C#" autoeventwireup="true" codefile="JobSeekerProfile.aspx.cs" inherits="JobSeekerProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
</head>
<body class="jumbotron">
    <div class="container">

        <form runat="server">
            <ul class="nav nav-tabs justify-content-center">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#personal_info">View Info</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#edit_info">Edit Info</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#applications">View Applications</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="personal_info" runat="server"></div>
                <div class="tab-pane" id="edit_info" runat="server">
                    <div class="form-group mt-5 row">
                        <label class="font-weight-bold col-2 col-form-label">Password</label>
                        <div class="col-8">
                            <asp:TextBox CssClass="form-control" ID="txt_password" runat="server" TextMode="Password" placeholder="Change password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Personal Email</label>
                        <div class="col-8">
                            <asp:TextBox CssClass="form-control" ID="txt_personalemail" runat="server" placeholder="Change Personal Email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Birthdate</label>
                        <div class="col-8">
                            <asp:TextBox CssClass="form-control" ID="txt_birthdate" runat="server" placeholder="Change Birthdate (MM/DD/YY)"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Experience Years</label>
                        <div class="col-8">
                            <asp:TextBox CssClass="form-control" ID="txt_expyrs" runat="server" placeholder="Update Experience Years"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">First Name</label>
                        <div class="col-8">
                            <asp:TextBox CssClass="form-control" ID="txt_fn" runat="server" placeholder="Change First Name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label">Last Name</label>
                        <div class="col-8">
                            <asp:TextBox CssClass="form-control" ID="txt_ln" runat="server" placeholder="Change Last Name"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <asp:Button CssClass="btn btn-primary" ID="apply_edit" runat="server" Text="Apply Changes" OnClick="editPersonalInfo" />
                    </div>
                </div>
                
                <div class="tab-pane" id="applications" runat="server"></div>
            </div>
        </form>
    </div>
    <!--jquery-->
    <script type="text/javascript" src="Scripts/jquery-3.2.1.js"></script>
    <!--tether-->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.3/js/tether.min.js"></script>
    <!--bootstrap.js-->
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>
</body>
</html>
