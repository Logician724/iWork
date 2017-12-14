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
                <div class="row">
                    <div class="offset-3 col-2">
                        <asp:Button CssClass="btn btn-success" runat="server" Text="Check In" OnClick="CheckIn" />
                    </div>
                    <div class="offset-2 col-2">
                        <asp:Button CssClass="btn btn-danger" runat="server" Text="Check Out" OnClick="CheckOut" />
                    </div>
                </div>
                <hr />
                <div id="viewattendance_panel" class="mt-5" runat="server">
                    <div class="form-group row ">
                        <label class="font-weight-bold col-1 text-center col-form-label offset-3">From</label>
                        <div class="offset-1 col-3">
                            <asp:TextBox CssClass="form-control" ID="txt_from" runat="server" placeholder="YY/MM/DD"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="font-weight-bold col-1 text-center col-form-label offset-3">To</label>
                        <div class="offset-1 col-3">
                            <asp:TextBox CssClass="form-control" ID="txt_to" runat="server" placeholder="YY/MM/DD"></asp:TextBox>
                        </div>
                    </div>

                    <div class="text-center">
                        <asp:Button CssClass="btn btn-primary" ID="btn" runat="server" AutoPostBack="false" Text="View Attendance" OnClick="viewAttendance" />
                    </div>

                    <div class="text-center mt-2 font-weight-bold text-danger" id="attendance_response" runat="server"></div>
                </div>

            </div>
            <div id="announcement_content" class="tab-pane">
                <div id="announcement_view" runat="server">
                </div>
            </div>
            <!---------------------------------------------------------------------------------------------------------------------------->
            <div id="request_content" class="tab-pane">
                <ul class="nav nav-tabs justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#leave_requests">Leave Requests</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#trip_requests">Business Trip Requests</a>
                    </li>
                </ul>
                <div class="tab-content mt-5">
                    <div id="leave_requests" class="tab-pane active" runat="server">
                        <div id="apply_leave_inputs" runat="server">
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Choose Replacer Username</label>
                                <asp:DropDownList CssClass="col-4 custom-select" ID="replacer_leave" AutoPostBack="false" runat="server"></asp:DropDownList>
                            </div>
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Start Date</label>
                                <asp:TextBox CssClass="col-4 form-control" placeholder="YYYY-MM-DD" ID="leave_request_start_date" runat="server"></asp:TextBox>
                            </div>
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">End Date</label>
                                <asp:TextBox CssClass="col-4 form-control" placeholder="YYYY-MM-DD" ID="leave_request_end_date" runat="server"></asp:TextBox>
                            </div>
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Leave Type</label>
                                <asp:DropDownList ID="dropdownlist_leavetype" CssClass="custom-select col-4" AutoPostBack="false" runat="server"></asp:DropDownList>
                            </div>
                            <div class="text-center">
                                <asp:Button CssClass="btn btn-primary" ID="apply_leave_request" runat="server" AutoPostBack="false" Text="Apply Now!" OnClick="ApplyForLeaveRequests" />
                            </div>
                        </div>
                        <hr />
                        <div id="leave_request_view" class="mt-5" runat="server"></div>
                    </div>
                    <div id="trip_requests" class="tab-pane">
                        <div id="apply_trip_requests" runat="server">
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Choose Replacer Username</label>
                                <asp:DropDownList CssClass="col-4 custom-select" ID="replacer_trip" AutoPostBack="false" runat="server"></asp:DropDownList>
                            </div>
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Start Date</label>
                                <asp:TextBox CssClass="col-4 form-control" placeholder="YYYY-MM-DD" ID="trip_request_start_date" runat="server"></asp:TextBox>
                            </div>
                            <div class="row form-group">
                                <label class="font-weight-bold col-2 col-form-label offset-3">End Date</label>
                                <asp:TextBox CssClass="col-4 form-control" placeholder="YYYY-MM-DD" ID="trip_request_end_date" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group row">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Trip Destination</label>
                                <asp:TextBox CssClass="form-control col-4" ID="trip_request_destination" runat="server" placeholder="Enter Trip Destination"></asp:TextBox>
                            </div>
                            <div class="form-group row">
                                <label class="font-weight-bold col-2 col-form-label offset-3">Trip Purpose</label>
                                <asp:TextBox CssClass="form-control col-4" ID="trip_request_purpose" runat="server" placeholder="Enter Trip Purpose"></asp:TextBox>
                            </div>
                            <div class="text-center">
                                <asp:Button CssClass="btn btn-primary" ID="Button3" runat="server" AutoPostBack="false" Text="Apply Now!" OnClick="ApplyForTripRequests" />
                            </div>
                        </div>
                        <hr />
                        <div id="trip_request_view" class="mt-5" runat="server"></div>
                    </div>
                </div>
            </div>
            <div id="email_content" class="tab-pane">
                <ul class="nav nav-tabs justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#sendemail_panel">Send Email</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#inbox_panel">inbox</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active mt-5" id="sendemail_panel" runat="server">
                        <div class="form-group row">
                            <!-- recipient email input-->
                            <label class="font-weight-bold col-2 col-form-label offset-3">To</label>
                            <div class="col-3">
                                <asp:TextBox CssClass="form-control" ID="recipemail_txt" runat="server" placeholder="Enter recipient's email"></asp:TextBox>
                            </div>
                        </div>
                        <!-- email subject input-->
                        <div class="form-group row">
                            <label class="font-weight-bold col-2 col-form-label offset-3">Subject</label>
                            <div class="col-3">
                                <asp:TextBox CssClass="form-control" ID="subject_txt" runat="server" placeholder="Enter Subject"></asp:TextBox>
                            </div>
                        </div>
                        <!-- email body input-->
                        <div class="form-group row">
                            <label class="font-weight-bold col-2 col-form-label offset-3">Body</label>
                            <div class="col-3">
                                <asp:TextBox CssClass="form-control" TextMode="MultiLine" Columns="60" Rows="20" ID="body_txt" runat="server" placeholder="Enter Body"></asp:TextBox>
                            </div>
                        </div>
                        <div class="text-center">
                            <asp:Button CssClass="btn btn-primary" ID="Button5" runat="server" Text="Send Email" OnClick="sendEmail" />
                        </div>
                        <div class="text-center mt-2 font-weight-bold text-danger" id="send_response" runat="server"></div>
                    </div>
                    <!--email view-->
                    <div class="tab-pane mt-5" id="inbox_panel" runat="server"></div>
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
