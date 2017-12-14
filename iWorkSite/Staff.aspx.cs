using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class Staff : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Session["Username"] == null)
        {
            Response.Redirect("login");
        }
        else
        {
            ClearControls();
            ShowProfile(sender, e);
            populateDropDown(sender, e);
            viewRequests(sender, e);
            viewEmails(sender, e);
            ViewAnnouncements(sender, e);
        }
    }


    protected void CheckIn(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("CheckInSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        //output parameters
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();
        switch (op)
        {
            case "0":
                Label DayOff = new Label();
                DayOff.Text = "It's your day-off!";
                checkin_response.Controls.Add(DayOff);
                break;
            case "1":
                Label CheckedIn = new Label();
                CheckedIn.Text = "You are already Checked In";
                checkin_response.Controls.Add(CheckedIn);
                break;
            case "2":
                Label passed = new Label();
                passed.Text = "Successfully Checked In.";
                checkin_response.Controls.Add(passed);
                break;
        }


    }

    //---------------------------------------------------------------------------------------------------


    protected void CheckOut(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("CheckOutSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        //output parameters
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();
        switch (op)
        {
            case "0":
                Label DayOff = new Label();
                DayOff.Text = "It's your day-off !";
                checkout_response.Controls.Add(DayOff);
                break;
            case "1":
                Label CheckIn = new Label();
                CheckIn.Text = "You need to check in first!";
                checkout_response.Controls.Add(CheckIn);
                break;
            case "2" :
                Label CheckOut = new Label();
                CheckOut.Text = "Successfully Checked Out";
                checkout_response.Controls.Add(CheckOut);
                break;
        }


    }

    //-----------------------------------------------------------------------------------------------

    protected void viewAttendance(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewAttendanceSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));

        string startdate = txt_from.Text;
        string enddate = txt_to.Text;

        cmd.Parameters.Add(new SqlParameter("@periodStart", startdate));
        cmd.Parameters.Add(new SqlParameter("@periodEnd", enddate));

        //output parameterssub
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch(Exception ex)
        {
            Label DateErrorLabel = new Label();
            DateErrorLabel.Text = "incorrect date format, please try again";
            attendance_response.Controls.Clear();
            attendance_response.Controls.Add(DateErrorLabel);
            conn.Close();
            return;
        }
        string op = OperationStatus.Value.ToString();
        Label failed = new Label();
        failed.Text = "End date should be after start date.";
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        switch (op)
        {
            case "False":
                attendance_response.Controls.Add(failed);
                break;
            case "True":
                while (rdr.Read())
                {
                    string StartTime = rdr.GetValue(rdr.GetOrdinal("start_time")).ToString();
                    string LeaveTime = rdr.GetValue(rdr.GetOrdinal("leave_time")).ToString();
                    string Duration = rdr.GetValue(rdr.GetOrdinal("duration")).ToString();
                    string MissingHours = rdr.GetValue(rdr.GetOrdinal("missing_hours")).ToString();
                    string AttendanceInfo = "<div class = \"card-block\">"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Arrival Time: </span>" + StartTime + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Leave Time: </span>" + LeaveTime + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Duration: </span>" + Duration + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Missing Hours: </span>" + MissingHours + "</div>"
            + "</div>";
                    viewattendance_panel.Controls.Add(new LiteralControl(AttendanceInfo));
                }//end of while loop


                break;

        }



    }

    //------------------------------------------------------------------------------------------------------

    //View the status of all requests he/she applied for before (HR employee and Manager responses).

    protected void viewRequests(object sender, EventArgs e)
    {
        //clear the controls
        leave_request_view.Controls.Clear();
        trip_request_view.Controls.Clear();
        //initialize user name session
        string Username = Session["Username"].ToString();
        //initialize request status sql command
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand ReqStatusCmd = new SqlCommand("ViewRequestsStatusSP", conn);
        ReqStatusCmd.CommandType = CommandType.StoredProcedure;
        //add the username as a request status parameter
        ReqStatusCmd.Parameters.Add(new SqlParameter("@userName", Username));
        //output parameter
        SqlParameter OperationStatus = ReqStatusCmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        //open the connection to the database
        conn.Open();
        //excute the command once to get the output variable
        ReqStatusCmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        //initalize request status command reader
        SqlDataReader ReqStatusReader = ReqStatusCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        //clear the response div before starting a new opeation
        response_div.Controls.Clear();
        switch (op)
        {
            case "False":
                //notify the user in case no requests for the user were found
                Label failed = new Label();
                failed.Text = "No requests found";
                leave_request_view.Controls.Add(failed);
                trip_request_view.Controls.Add(failed);
                break;
            case "True":

                string HRResponse = null;
                string ManagerResponse = null;
                //start reading in case reqeusts exist
                while (ReqStatusReader.Read())
                {
                    //get general request info
                    string RequestID = ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("request_id")).ToString();
                    string StartDate = ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("start_date")).ToString().Split(null)[0];
                    string EndDate = ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("end_date")).ToString().Split(null)[0];
                    //replace DB null values with placeholder text
                    if (ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("hr_response_req")) == DBNull.Value)
                        HRResponse = "-";
                    else
                        HRResponse = ReqStatusReader.GetString(ReqStatusReader.GetOrdinal("hr_response_req"));

                    if (ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("manager_response_req")) == DBNull.Value)
                        ManagerResponse = "-";
                    else
                        ManagerResponse = ReqStatusReader.GetString(ReqStatusReader.GetOrdinal("manager_response_req"));
                    //get request type specific info
                    SqlCommand ReqInfoCmd = new SqlCommand("ShowRequestInfoSP", conn);
                    ReqInfoCmd.CommandType = CommandType.StoredProcedure;
                    ReqInfoCmd.Parameters.Add(new SqlParameter("@username", Username));
                    ReqInfoCmd.Parameters.Add(new SqlParameter("@requestID", RequestID));
                    //get the type of request using operation status procedure output
                    SqlParameter ShowInOp = ReqInfoCmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
                    ShowInOp.Direction = ParameterDirection.Output;
                    //execute the request info command to get the type of the requests through the request output
                    ReqInfoCmd.ExecuteNonQuery();
                    string TypeOp = ShowInOp.Value.ToString();
                    Panel RequestPanel = new Panel();
                    string RequestBuild = null;
                    SqlDataReader ReqInfoReader = ReqInfoCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    if (TypeOp == "False")
                    {
                        string LeaveType = "";
                        if (ReqInfoReader.Read())
                        {
                            LeaveType = ReqInfoReader.GetString(ReqInfoReader.GetOrdinal("type"));
                        }
                        RequestBuild = "<div class=\"row\">\r\n" +
               "    <div class=\"col-1 lead\">" + "Request: " + RequestID + "</div>\r\n" +
               "    <div class=\"col-1 lead\">\r\n" +
               "      <p>" + HRResponse + "</p>\r\n" +
               "    </div>\r\n" +
               "    <div class=\"col-1 lead\"><p>" + ManagerResponse + "</p></div>\r\n" +
               "    <div class=\"col-2 lead\">\r\n<p>" + LeaveType + "</p></div>\r\n" +
               "    <div class=\"col-2 lead\">\r\n<p>" + StartDate + "</p></div>\r\n" +
               "    <div class=\"col-2 lead\">\r\n<p>" + EndDate + "</p></div>\r\n";
                    }
                    else
                        if (TypeOp == "True")
                    {
                        string TripPurpose = "";
                        string TripDestination = "";
                        if (ReqInfoReader.Read())
                        {
                            TripDestination = ReqInfoReader.GetString(ReqInfoReader.GetOrdinal("trip_destination"));
                            TripPurpose = ReqInfoReader.GetString(ReqInfoReader.GetOrdinal("trip_purpose"));
                        }
                        RequestBuild = "<div class=\"row\">\r\n" +
                        "    <div class=\"col-1 lead\">" + "Request: " + RequestID + "</div>\r\n" +
                        "    <div class=\"col-1 lead\">\r\n" +
                        "      <p>" + HRResponse + "</p>\r\n" +
                        "    </div>\r\n" +
                        "    <div class=\"col-1 lead\"><p>" + ManagerResponse + "</p></div>\r\n" +
                        "    <div class=\"col-2 lead\"><p>" + TripDestination + "</p></div>\r\n" +
                        "    <div class=\"col-2 lead\"><p>" + TripPurpose + "</p></div>\r\n" +
                        "    <div class=\"col-2 lead\">\r\n<p>" + StartDate + "</p></div>\r\n" +
                        "    <div class=\"col-2 lead\">\r\n<p>" + EndDate + "</p></div>\r\n";
                    }
                    else
                    {
                        Label ErrorLabel = new Label();
                        ErrorLabel.Text = "Unexpected error, please contact the developer immediately";
                        response_div.Controls.Clear();
                        response_div.Controls.Add(ErrorLabel);
                    }
                    RequestPanel.Controls.Add(new LiteralControl(RequestBuild));
                    if (ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("hr_response_req")) == DBNull.Value && ReqStatusReader.GetValue(ReqStatusReader.GetOrdinal("manager_response_req")) == DBNull.Value)
                    {

                        Panel DeletePanel = new Panel();
                        DeletePanel.CssClass = "text-center";
                        if (TypeOp == "False")
                        {
                            DeletePanel.CssClass = "offset-2 col-1";
                        }
                        else
                            if (TypeOp == "True")
                        {
                            DeletePanel.CssClass = "col-1";
                        }
                        Button DeleteRequest = new Button();
                        DeleteRequest.Text = "Delete";
                        DeleteRequest.CssClass = "btn btn-danger";
                        DeleteRequest.Click += new EventHandler((sender_delete, e_delete) => DeleteRequests(sender_delete, e_delete, RequestID));
                        DeletePanel.Controls.Add(DeleteRequest);
                        RequestPanel.Controls.Add(DeletePanel);
                    }
                    RequestPanel.Controls.Add(new LiteralControl("<hr /></div>"));
                    if (TypeOp == "False")
                    {
                        leave_request_view.Controls.Add(RequestPanel);
                    }
                    else
                    {
                        trip_request_view.Controls.Add(RequestPanel);
                    }
                }//end of while loop


                break;

        }




    }


    //----------------------------------------------------------------------------------------------------------------------------

    //View announcements related to his/her company within the past 20 days.



    protected void ViewAnnouncements(object sender, EventArgs e)
    {
        //initialize the session variable
        string Username = Session["Username"].ToString();
        //identify connection and sql command
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewLatestAnnouncementsSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        //initialize the reader
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        //initialize HR user name value
        string HRUsername = null;
        int AnnouncementCounter = 0;
        //add user feedback in case no announcements are available
        if (!rdr.HasRows)
        {
            Panel NoAnnouncePanel = new Panel();
            NoAnnouncePanel.CssClass = "text-center text-danger font-weight-bold";
            Label NoAnnounceLabel = new Label();
            NoAnnounceLabel.Text = "No announcements available at the moment";
            NoAnnouncePanel.Controls.Add(NoAnnounceLabel);
            announcement_view.Controls.Add(NoAnnouncePanel);
        }
        else
            while (rdr.Read())
            {
                string Date = rdr.GetValue(rdr.GetOrdinal("date")).ToString();
                string CompanyDomain = rdr.GetString(rdr.GetOrdinal("company_domain"));
                string Title = rdr.GetString(rdr.GetOrdinal("title"));
                string Description = rdr.GetString(rdr.GetOrdinal("description"));
                string Type = rdr.GetString(rdr.GetOrdinal("type"));
                if (rdr.GetValue(rdr.GetOrdinal("hr_user_name")) == DBNull.Value)
                    HRUsername = "-";
                else
                    HRUsername = rdr.GetString(rdr.GetOrdinal("hr_user_name"));
                //initialize announcement panel
                Panel AnnouncementPanel = new Panel();
                string AnnouncementInfoBuild = "<div class=\"row\">\r\n" +
                    "    <div class=\"offset-2 col-2 lead\">" + Date + "</div>\r\n" +
                    "    <div class=\"col-2 lead\">\r\n" +
                    "      <p>" + Type + "</p>\r\n" +
                    "    </div>\r\n" +
                    "     <div class=\"col-2 lead\">" + Title + "</div>\r\n" +
                    "    <div class=\"col-2 lead\"><p>" + HRUsername + "</p></div>\r\n" +
                    "    <div clas=\"col-2 text-center\">\r\n" +
                    "      <a href=\"#" + "announce" + AnnouncementCounter + "\"" + " data-toggle=\"collapse\" class=\"btn btn-primary\">show</a>\r\n" +
                    "    </div>\r\n" +
                    "  </div>";
                string AnnouncementBodyBuild = " <div class=\"container\">\r\n" +
                    "    <div id=\"" + "announce" + AnnouncementCounter + "\" class=\"collapse lead text-justify text-center\">\r\n" +
                    "      <p>" + Description + "</p>\r\n" +
                    "    </div>\r\n" +
                    "  </div>";
                AnnouncementPanel.Controls.Add(new LiteralControl(AnnouncementInfoBuild));
                AnnouncementPanel.Controls.Add(new LiteralControl(AnnouncementBodyBuild));
                announcement_view.Controls.Add(AnnouncementPanel);
                AnnouncementCounter++;

            }
    }
    //----------------------------------------------------------------------------------------------------------


    protected void sendEmail(object sender, EventArgs e)
    {
        //initialize session variables
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand SendEmailCmd = new SqlCommand("SendEmailSP", conn);
        SendEmailCmd.CommandType = CommandType.StoredProcedure;
        SendEmailCmd.Parameters.Add(new SqlParameter("@senderUserName", Username));
        SqlCommand GetEmailCmd = new SqlCommand("GetStaffEmailSP", conn);
        GetEmailCmd.CommandType = CommandType.StoredProcedure;
        GetEmailCmd.Parameters.Add(new SqlParameter("@username", Username));
        conn.Open();
        SqlDataReader GetEmailReader = GetEmailCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        string SenderEmail = "";
        if (GetEmailReader.Read())
        {
            SenderEmail = GetEmailReader.GetString(GetEmailReader.GetOrdinal("company_email"));
        }
        string RecipEmail = recipemail_txt.Text;
        string RecipUsername = RecipEmail.Split('@')[0];
        string Subject = subject_txt.Text;
        string Body = body_txt.Text;
        SendEmailCmd.Parameters.Add(new SqlParameter("@senderEmail", SenderEmail));
        SendEmailCmd.Parameters.Add(new SqlParameter("@recipientUserName", RecipUsername));
        SendEmailCmd.Parameters.Add(new SqlParameter("@recipientEmail", RecipEmail));
        SendEmailCmd.Parameters.Add(new SqlParameter("@emailSubject", Subject));
        SendEmailCmd.Parameters.Add(new SqlParameter("@emailBody", Body));
        //output parameterssub
        SqlParameter OperationStatus = SendEmailCmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        SendEmailCmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();
        response_div.Controls.Clear();
        switch (op)
        {
            case "False":
                Label failed = new Label();
                failed.Text = "Sending Failed. Recipient is not in your company.";
                response_div.Controls.Add(failed);
                break;
            case "True":
                response_div.Attributes["class"] = "text-success text-center font-weight-bold";
                Label passed = new Label();
                passed.Text = "Email Sent";
                response_div.Controls.Add(passed);
                break;
        }
    }

    //-----------------------------------------------------------------------------------------------------

    protected void viewEmails(object sender, EventArgs e)
    {
        //initailze the sql command
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewReceivedEmailsSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", Username));
        conn.Open();
        //intialize reader
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        //initialize empty data holder
        string Subject = null;
        string Body = null;
        /// initalize generic id counters
        int EmailCounter = 0;
        // retrieve data from the database and build the front end structure
        while (rdr.Read())
        {
            //email attributes
            string TimeStamp = rdr.GetValue(rdr.GetOrdinal("time_stamp")).ToString();
            string SenderUsername = rdr.GetString(rdr.GetOrdinal("sender_user_name"));
            string SenderEmail = rdr.GetString(rdr.GetOrdinal("sender_email"));
            string RecipientEmail = rdr.GetString(rdr.GetOrdinal("recipient_email"));
            // if the subject is null render it as an empty string for the front end
            if (rdr.GetValue(rdr.GetOrdinal("email_subject")) == DBNull.Value)
                Subject = "";
            else
                Subject = rdr.GetString(rdr.GetOrdinal("email_subject"));
            //if the body is null render it as an empty string for the front end
            if (rdr.GetValue(rdr.GetOrdinal("email_body")) == DBNull.Value)
                Body = "";
            else
                Body = rdr.GetString(rdr.GetOrdinal("email_body"));

            //initilaize email div
            Panel EmailPanel = new Panel();
            string EmailInfoBuild = "<div class=\"row\">\r\n" +
                "    <div class=\"offset-2 col-2 lead\">" + SenderEmail + "</div>\r\n" +
                "    <div class=\"col-2 lead\">\r\n" +
                "      <p>" + Subject + "</p>\r\n" +
                "    </div>\r\n" +
                "    <div class=\"col-2 lead\"><p>" + TimeStamp + "</p></div>\r\n" +
                "    <div clas=\"col-2 text-center\">\r\n" +
                "      <a href=\"#" + "body" + EmailCounter + "\"" + " data-toggle=\"collapse\" class=\"btn btn-primary\">show</a>\r\n" +
                "    </div>\r\n" +
                "    <div class=\"col-2 text-center\">\r\n" +
                " <button type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#" + "reply" + EmailCounter + "\">Reply</button>" +
                "    </div>\r\n" +
                "  </div>";
            string EmailBodyBuild = " <div class=\"container\">\r\n" +
                "    <div id=\"" + "body" + EmailCounter + "\" class=\"collapse lead text-justify\">\r\n" +
                "      <p>" + Body + "</p>\r\n" +
                "    </div>\r\n" +
                "  </div>";
            string ReplyModalBuild = "  <div class=\"modal fade\" id=\"" + "reply" + EmailCounter + "\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"modal_title\" aria-hidden=\"true\">\r\n" +
                "  <div class=\"modal-dialog\" role=\"document\">\r\n" +
                "    <div class=\"modal-content\">\r\n" +
                "      <div class=\"modal-header\">\r\n" +
                "        <h5 class=\"modal-title\" id=\"modal_title\">Reply to Email</h5>\r\n" +
                "        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\r\n" +
                "          <span aria-hidden=\"true\">&times;</span>\r\n" +
                "        </button>\r\n" +
                "      </div>\r\n" +
                "      <div class=\"modal-body\">\r\n" +
                "        <form>\r\n" +
                "          <div class=\"form-group\">\r\n" +
                "            <label for=\"message-text\" class=\"form-control-label\">Reply:</label>\r\n";
            //initialize dynamic controls
            TextBox BodyBox = new TextBox();
            BodyBox.CssClass = "form-control";
            BodyBox.TextMode = TextBoxMode.MultiLine;
            BodyBox.Columns = 100;
            BodyBox.Rows = 7;
            string ReplyModalControlHolder = "          </div>\r\n" +
                "        </form>\r\n" +
                "      </div>\r\n" +
                "      <div class=\"modal-footer\">\r\n" +
                "        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>";
            Button ReplyEmailButton = new Button();
            ReplyEmailButton.Text = "Reply";
            ReplyEmailButton.CssClass = "btn btn-primary";
            ReplyEmailButton.Click += new EventHandler((o_reply, e_reply) => ReplyToEmail(o_reply, e_reply, RecipientEmail.Split('@')[0], SenderUsername, TimeStamp, Subject, BodyBox.Text));
            //finalize email panel build
            EmailPanel.Controls.Add(new LiteralControl(EmailInfoBuild));
            EmailPanel.Controls.Add(new LiteralControl(EmailBodyBuild));
            EmailPanel.Controls.Add(new LiteralControl(ReplyModalBuild));
            EmailPanel.Controls.Add(BodyBox);
            EmailPanel.Controls.Add(new LiteralControl(ReplyModalControlHolder));
            EmailPanel.Controls.Add(ReplyEmailButton);
            EmailPanel.Controls.Add(new LiteralControl("</div></div></div></div><hr />"));
            // add the email panel to the inbox panel
            inbox_panel.Controls.Add(EmailPanel);
            EmailCounter++;
        }

    }

    protected void populateDropDown(object sender, EventArgs e)
    {
        dropdownlist_leavetype.Items.Clear();
        replacer_leave.Items.Clear();
        replacer_trip.Items.Clear();
        //identify session variables
        string type = Session["Type"].ToString();
        string Username = Session["Username"].ToString();
        //popuplate the leave type dropdown list
        dropdownlist_leavetype.Items.Add("annual leave");
        dropdownlist_leavetype.Items.Add("accidental leave");
        dropdownlist_leavetype.Items.Add("sick leave");
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        conn.Open();
        if (type == "Regular")
        {
            SqlCommand RegularUsernamescmd = new SqlCommand("RegularUsernames", conn);
            RegularUsernamescmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader RegularUsernamesrdr = RegularUsernamescmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (RegularUsernamesrdr.Read())
            {
                string username = RegularUsernamesrdr.GetString(RegularUsernamesrdr.GetOrdinal("user_name"));
                ListItem UserItem = new ListItem(username, username);
                replacer_leave.Items.Add(UserItem);
                replacer_trip.Items.Add(UserItem);
            }
        }
        else
            if (type == "HR")
        {
            SqlCommand HRUsernamescmd = new SqlCommand("HRUsernames", conn);
            HRUsernamescmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader HRUsernamesrdr = HRUsernamescmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (HRUsernamesrdr.Read())
            {
                string username = HRUsernamesrdr.GetString(HRUsernamesrdr.GetOrdinal("user_name"));
                ListItem UserItem = new ListItem(username, username);
                replacer_leave.Items.Add(UserItem);
                replacer_trip.Items.Add(UserItem);
            }
        }
        else
        {
            SqlCommand ManagerUsernamescmd = new SqlCommand("ManagerUsernames", conn);
            ManagerUsernamescmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader ManagerUsernamesrdr = ManagerUsernamescmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (ManagerUsernamesrdr.Read())
            {
                string username = ManagerUsernamesrdr.GetString(ManagerUsernamesrdr.GetOrdinal("user_name"));
                ListItem UserItem = new ListItem(username, username);
                replacer_leave.Items.Add(UserItem);
                replacer_trip.Items.Add(UserItem);
            }

        }

    }

    protected void ApplyForRequest(object sender, EventArgs e, string Username, string Replacer, string type, string StartDate, string EndDate, string LeaveType, string TripDestination, string TripPurpose)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        conn.Open();
        SqlCommand ApplyRequestscmd = null;
        if (type == "Regular")
        {
            ApplyRequestscmd = new SqlCommand("ApplyRegularForRequestSP", conn);
            ApplyRequestscmd.CommandType = CommandType.StoredProcedure;
        }

        else if (type == "HR")
        {
            ApplyRequestscmd = new SqlCommand("ApplyHRForRequestSP", conn);
            ApplyRequestscmd.CommandType = CommandType.StoredProcedure;
        }
        else
        if (type == "Manager")
        {
            ApplyRequestscmd = new SqlCommand("ApplyManagerForRequestSP", conn);
            ApplyRequestscmd.CommandType = CommandType.StoredProcedure;
        }

        ApplyRequestscmd.Parameters.Add(new SqlParameter("@ownerUserName", Username));
        ApplyRequestscmd.Parameters.Add(new SqlParameter("@startDate", StartDate));
        ApplyRequestscmd.Parameters.Add(new SqlParameter("@endDate", EndDate));
        ApplyRequestscmd.Parameters.Add(new SqlParameter("@replacementUserName", Replacer));

        if (string.IsNullOrEmpty(LeaveType))
        {
            ApplyRequestscmd.Parameters.Add(new SqlParameter("@leaveType", DBNull.Value));
        }
        else
        {
            ApplyRequestscmd.Parameters.Add(new SqlParameter("@leaveType", LeaveType));
        }
        if (string.IsNullOrEmpty(TripPurpose))
        {
            ApplyRequestscmd.Parameters.Add(new SqlParameter("@tripPurpose", DBNull.Value));
        }
        else
        {
            ApplyRequestscmd.Parameters.Add(new SqlParameter("@tripPurpose", TripPurpose));
        }
        if (string.IsNullOrEmpty(TripDestination))
        {
            ApplyRequestscmd.Parameters.Add(new SqlParameter("@tripDestination", DBNull.Value));
        }
        else
        {
            ApplyRequestscmd.Parameters.Add(new SqlParameter("@tripDestination", TripDestination));
        }
        if (string.IsNullOrEmpty(StartDate) || string.IsNullOrEmpty(EndDate) || string.IsNullOrEmpty(Replacer) || (string.IsNullOrEmpty(LeaveType) && (string.IsNullOrEmpty(TripDestination) || string.IsNullOrEmpty(TripPurpose))))
        {
            Label failed3 = new Label();
            failed3.Text = "Please Enter All Info";
        }
        else
        {
            SqlParameter OperationStatus = ApplyRequestscmd.Parameters.Add("@operationStatus", SqlDbType.Int);
            OperationStatus.Direction = ParameterDirection.Output;
            try
            {
                ApplyRequestscmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Label DateErrorLabel = new Label();
                DateErrorLabel.Text = "incorrect date format, please try again";
                response_div.Controls.Clear();
                response_div.Controls.Add(DateErrorLabel);
                conn.Close();
                return;
            }
            conn.Close();
            Label failed = new Label();
            failed.Text = "You Exceeded Your Number of Annual Leaves.";

            Label failed1 = new Label();
            failed1.Text = "Your Dates are overlapping with another Request's Dates";
            switch (OperationStatus.Value.ToString())
            {
                case "1":
                    response_div.Controls.Add(failed);
                    break;

                case "2":
                    response_div.Controls.Add(failed1);
                    break;
                case "3":
                    response_div.Controls.Clear();
                    break;
            }
        }
    }

    protected void ApplyForLeaveRequests(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string Type = Session["Type"].ToString();
        string StartDate = leave_request_start_date.Text;
        string EndDate = leave_request_end_date.Text;
        string LeaveType = dropdownlist_leavetype.SelectedValue;
        string Replacer = replacer_leave.SelectedValue;
        //apply for request without any trip request parameters
        ApplyForRequest(sender, e, Username, Replacer, Type, StartDate, EndDate, LeaveType, null, null);
    }
    protected void ApplyForTripRequests(object sender, EventArgs e)
    {
        string Username = Session["username"].ToString();
        string Type = Session["Type"].ToString();
        string StartDate = trip_request_start_date.Text;
        string EndDate = trip_request_end_date.Text;
        string Replacer = replacer_trip.SelectedValue;
        string TripPurpose = trip_request_purpose.Text;
        string TripDestination = trip_request_destination.Text;
        //apply for request wihtout any leave request parameters
        ApplyForRequest(sender, e, Username, Replacer, Type, StartDate, EndDate, null, TripDestination, TripPurpose);
    }

    protected void DeleteRequests(object sender, EventArgs e, string RequestID)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("DeletePendingRequestsSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@requestID", RequestID));
        conn.Open();
        cmd.ExecuteNonQuery();
        response_div.Controls.Clear();
    }

    protected void ReplyToEmail(object sender, EventArgs e, string RecipientUsername, string SenderUsername, string Timestamp, string Subject, string Body)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand ReplyCmd = new SqlCommand("ReplyToEmailsSP", conn);
        ReplyCmd.CommandType = CommandType.StoredProcedure;
        ReplyCmd.Parameters.Add(new SqlParameter("@recipientUsername", RecipientUsername));
        ReplyCmd.Parameters.Add(new SqlParameter("@timestamp", Timestamp));
        ReplyCmd.Parameters.Add(new SqlParameter("@senderUsername", SenderUsername));
        ReplyCmd.Parameters.Add(new SqlParameter("@emailSubject", "RE:" + Subject));
        ReplyCmd.Parameters.Add(new SqlParameter("@emailBody", Body));
        conn.Open();
        ReplyCmd.ExecuteNonQuery();
        conn.Close();
    }
    //identity controls
    protected void ShowProfile(object sender, EventArgs e)
    {
        switch (Session["Type"].ToString())
        {
            case "Job Seeker":
                profile_link.Attributes["href"] = "JobSeekerProfile";
                break;
            case "Regular":
                profile_link.Attributes["href"] = "RegularEmployeeProfile";
                break;
            case "HR":
                profile_link.Attributes["href"] = "HrControl";
                break;
            case "Manager":
                profile_link.Attributes["href"] = "ManagerControl";
                break;
            default:
                Label ResponseLabel = new Label();
                ResponseLabel.Text = "Unexpected error occured, please login again and contact the developer";
                response_div.Controls.Add(ResponseLabel);
                break;
        }
    }
    protected void SignOut(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("companies");
    }

    private void ClearControls()
    {
        foreach (Control c in Page.Controls)
        {
            foreach (Control ctrl in c.Controls)
            {
                if (ctrl is TextBox)
                {
                    ((TextBox)ctrl).Text = string.Empty;
                }
            }
        }
    }

}