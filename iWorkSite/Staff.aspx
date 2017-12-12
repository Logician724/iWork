<%@ page language="C#" autoeventwireup="true" codefile="Staff.aspx.cs" inherits="Staff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Staff Profile</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
</head>
<body class="jumbotron">
    <nav id="main_nav" class="navbar fixed-top navbar-toggleable-md navbar-inverse bg-primary" runat="server">
        <a class="navbar-brand pr-3 display=1 vertical-ruler" href="Companies">iWork</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto" id="nav_list_primary" role="tablist" runat="server">
                <li class="nav-item">
                    <a class="nav-link h6" id="profile_link" runat="server">Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link h6 active" data-toggle="tab" href="#attendance_content" role="tab">Attendance</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link h6" data-toggle="tab" href="#email_content" role="tab">Email</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link h6" data-toggle="tab" href="#announcement_content" role="tab">Announcements</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link h6" data-toggle="tab" href="#request_content" role="tab">Requests</a>
                </li>
            </ul>
        </div>
        <ul class="navbar-nav" id="nav_list_secondary" runat="server">
            <li class="nav-item">
                <a class="nav-link h6 text-nowrap" onserverclick="SignOut" runat="server">Sign Out</a>
            </li>
        </ul>
    </nav>
    <form runat="server" class="mt-5">
        <div id="response_div" class="text-center text-danger font-weight-bold" runat="server"></div>
        <div class="tab-content">
            <div id="attendance_content" class="tab-pane active">
                <div class="text-center mt-2 mb-2 font-weight-bold text-danger" id="checkout_response" runat="server"></div>
                <div class="text-center mt-2 font-weight-bold text-danger" id="checkin_response" runat="server"></div>
                <asp:Button CssClass="btn btn-primary" ID="Button2" runat="server" Text="Check In" OnClick="CheckIn" />
                <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="Check Out" OnClick="CheckOut" />
                <div id="viewattendance_panel" runat="server">
                    <div class="form-group row ">
                        <label class="font-weight-bold col-2 col-form-label offset-3">From</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="txt_from" runat="server" placeholder="YY/MM/DD"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label offset-3">To</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="txt_to" runat="server" placeholder="YY/MM/DD"></asp:TextBox>
                        </div>
                    </div>

                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="btn" runat="server" Text="View Attendance" OnClick="viewAttendance" />
                    </div>

                    <div class="text-center mt-2 font-weight-bold text-danger" id="attendance_response" runat="server"></div>
                </div>

            </div>
            <div id="announcement_content" class="tab-pane">
                <div id="announcement_panel" runat="server">
                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="Button4" runat="server" Text="View Announcements" OnClick="viewAnnouncements" />
                    </div>
                </div>
            </div>
            <div id="request_content" class="tab-pane">
                <div id="viewrequests_panel" runat="server">
                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="Button3" runat="server" Text="View Requests" OnClick="viewRequests" />
                    </div>
                    <div class="text-center mt-2 font-weight-bold text-danger" id="requests_response" runat="server"></div>
                </div>
                <div id="ApplyForRequest_Panel" runat="server">
                    <asp:DropDownList ID="DropDownList_Replacers" runat="server"></asp:DropDownList>
                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="Button7" runat="server" Text="Send Email" OnClick="sendEmail" />
                    </div>
                    <div class="text-center mt-2 font-weight-bold text-danger" id="Div1" runat="server"></div>
                </div>
            </div>
            <div id="email_content" class="tab-pane">
                <div id="sendemail_panel" runat="server">
                    <div class="form-group row ">
                        <label class="font-weight-bold col-2 col-form-label offset-3">From</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="sendemail_txt" runat="server" placeholder="Enter Your Email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label offset-3">To</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="recipusername_txt" runat="server" placeholder="Enter recipient's username"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label offset-3">To</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="recipemail_txt" runat="server" placeholder="Enter recipient's email"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label offset-3">Subject</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="subject_txt" runat="server" placeholder="Enter Subject"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-2 col-form-label offset-3">Body</label>
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control" ID="body_txt" runat="server" placeholder="Enter Body"></asp:TextBox>
                        </div>
                    </div>
                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="Button5" runat="server" Text="Send Email" OnClick="sendEmail" />
                    </div>
                    <div class="text-center mt-2 font-weight-bold text-danger" id="send_response" runat="server"></div>
                </div>
                <div id="inbox_panel" runat="server">
                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="Button6" runat="server" Text="Check Inbox" OnClick="viewEmails" />
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
