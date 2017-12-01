<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Staff.aspx.cs" Inherits="Staff" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <link rel="stylesheet" type="text/css" href="Content/bootstrap.css"/>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Button CssClass="btn btn-primary" ID="Button2" runat="server" Text="Check In" OnClick="CheckIn" />
        <div class="text-center mt-2 font-weight-bold text-danger" id="checkin_response" runat="server"></div>
        
        <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="Check Out" OnClick="CheckOut" />
        <div class="text-center mt-2 font-weight-bold text-danger" id="checkout_response" runat="server"></div>




 <asp:Panel ID="viewattendance_panel" runat="server" >
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
</asp:Panel>


        <asp:Panel ID="viewrequests_panel" runat="server">
            <div class="text-center">
            <asp:Button CssClass="btn btn-primary" ID="Button3" runat="server" Text="View Requests" OnClick="viewRequests" />
            </div>
            <div class="text-center mt-2 font-weight-bold text-danger" id="requests_response" runat="server"></div>
        </asp:Panel>


    </form>
</body>
</html>
