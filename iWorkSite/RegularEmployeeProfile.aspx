<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegularEmployeeProfile.aspx.cs" Inherits="RegularEmployeeProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css"/>
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <form runat="server">

                  <asp:Panel ID="personal_info" runat="server" ></asp:Panel>
                  <asp:Panel ID="edit_info" runat="server" >

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
                  </asp:Panel>

                <asp:Panel ID="viewproject_panel" runat="server" >
                    <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="My Projects" OnClick="viewProjects" />
                 </asp:Panel>

                 <asp:Panel ID="viewtasks_panel" runat="server" >
                     <asp:TextBox CssClass="form-control" ID="proj_name" runat="server" placeholder="Enter Project Name"></asp:TextBox>
                     <asp:Button CssClass="btn btn-primary" ID="Button2" runat="server" Text="My Tasks" OnClick="viewTasks" />
                     <div class="text-center mt-2 font-weight-bold text-danger" id="tasks_response" runat="server"></div>
                 </asp:Panel>

                 <asp:Button CssClass="btn btn-primary" ID="Button3" runat="server" Text="Staff Member" OnClick="staff" />

            </form>
        </div>
    </div>
</body>
</html>