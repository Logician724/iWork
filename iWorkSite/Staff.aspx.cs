﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            ShowProfile(sender, e);
            populateDropDown(sender, e);
            viewRequests(sender, e);
            viewEmails(sender, e);
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

        Label failed = new Label();
        failed.Text = "It's your day-off !";
        Label passed = new Label();
        passed.Text = "Successfully Checked In.";

        switch (op)
        {
            case "False":
                checkin_response.Controls.Add(failed);
                break;
            case "True":
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

        Label failed = new Label();
        failed.Text = "It's your day-off !";
        Label passed = new Label();
        passed.Text = "Successfully Checked Out.";

        switch (op)
        {
            case "False":
                checkout_response.Controls.Add(failed);
                break;
            case "True":
                checkout_response.Controls.Add(passed);
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
        cmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();


        conn.Open();
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



                    string TasksInfo = "<div class = \"card-block\">"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Arrival Time: </span>" + StartTime + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Leave Time: </span>" + LeaveTime + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Duration: </span>" + Duration + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Missing Hours: </span>" + MissingHours + "</div>"
            + "</div>";



                    viewattendance_panel.Controls.Add(new LiteralControl(TasksInfo));





                }//end of while loop


                break;

        }



    }

    //------------------------------------------------------------------------------------------------------

    //View the status of all requests he/she applied for before (HR employee and Manager responses).

    protected void viewRequests(object sender, EventArgs e)
    {

        string Username = Session["Username"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewRequestsStatusSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));



        //output parameterssub
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();


        conn.Open();
        Label failed = new Label();
        failed.Text = "No requests found";
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);




        switch (op)
        {
            case "False":
                requests_response.Controls.Add(failed);
                break;
            case "True":

                string HRResponse = null;
                string ManagerResponse = null;
                while (rdr.Read())
                {
                    string RequestID = rdr.GetValue(rdr.GetOrdinal("request_id")).ToString();

                    if (rdr.GetValue(rdr.GetOrdinal("hr_response_req")) == DBNull.Value)
                        HRResponse = "-";
                    else
                        HRResponse = rdr.GetString(rdr.GetOrdinal("hr_response_req"));

                    if (rdr.GetValue(rdr.GetOrdinal("manager_response_req")) == DBNull.Value)
                        ManagerResponse = "-";
                    else
                        ManagerResponse = rdr.GetString(rdr.GetOrdinal("manager_response_req"));


                    string requests = "<div class = \"card-block\">"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Request ID: </span>" + RequestID + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">HR Response: </span>" + HRResponse + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Manager Response: </span>" + ManagerResponse + "</div>"
            + "</div>";

                    Panel DeletePanel = new Panel();
                    DeletePanel.CssClass = "offset-2 col-3";
                    Button DeleteRequest = new Button();
                    DeleteRequest.Text = "Delete";
                    DeleteRequest.CssClass = "btn btn-danger";
                    DeleteRequest.Click += new EventHandler((sender_delete, e_delete) => DeleteRequests(sender_delete, e_delete, RequestID));

                    if (rdr.GetValue(rdr.GetOrdinal("hr_response_req")) == DBNull.Value && rdr.GetValue(rdr.GetOrdinal("manager_response_req")) == DBNull.Value)
                    {

                        DeleteRequest.Enabled = true;
                    }
                    else
                    {
                        DeleteRequest.Enabled = false;
                        DeleteRequest.ToolTip = "You can't delete the Request unless it is pending";
                    }


                    DeletePanel.Controls.Add(DeleteRequest);

                    viewrequests_panel.Controls.Add(new LiteralControl(requests));
                    viewrequests_panel.Controls.Add(DeletePanel);




                }//end of while loop


                break;

        }




    }


    //----------------------------------------------------------------------------------------------------------------------------

    //View announcements related to his/her company within the past 20 days.



    protected void viewAnnouncements(object sender, EventArgs e)
    {

        string Username = Session["Username"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewLatestAnnouncementsSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        Label failed = new Label();
        failed.Text = "No requests found";
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);


        string HRUsername = null;
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



            string Info = "<div class = \"card-block\">"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Date: </span>" + Date + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Company Domain: </span>" + CompanyDomain + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Title: </span>" + Title + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Description: </span>" + Description + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Type: </span>" + Type + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">HR Username: </span>" + HRUsername + "</div>"
+ "</div>";
            announcement_panel.Controls.Add(new LiteralControl(Info));

        }


    }
    //----------------------------------------------------------------------------------------------------------


    protected void sendEmail(object sender, EventArgs e)
    {


        string Username = Session["Username"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("SendEmailSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@senderUserName", Username));

        string SenderEmail = sendemail_txt.Text;
        string RecipUsername = recipusername_txt.Text;

        string RecipEmail = recipemail_txt.Text;
        string Subject = subject_txt.Text;

        string Body = body_txt.Text;


        cmd.Parameters.Add(new SqlParameter("@senderEmail", SenderEmail));
        cmd.Parameters.Add(new SqlParameter("@recipientUserName", RecipUsername));
        cmd.Parameters.Add(new SqlParameter("@recipientEmail", RecipEmail));
        cmd.Parameters.Add(new SqlParameter("@emailSubject", Subject));
        cmd.Parameters.Add(new SqlParameter("@emailBody", Body));


        //output parameterssub
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();




        Label failed = new Label();
        failed.Text = "Sending Failed. Recipient is not in your company.";
        Label passed = new Label();
        passed.Text = "Email Sent";



        switch (op)
        {
            case "False":
                requests_response.Controls.Add(failed);
                break;
            case "True":
                requests_response.Controls.Add(passed);
                break;

        }

    }

    //-----------------------------------------------------------------------------------------------------

    protected void viewEmails(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewReceivedEmailsSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", Username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);


        string Subject = null;
        string Body = null;
        while (rdr.Read())
        {

            string TimeStamp = rdr.GetValue(rdr.GetOrdinal("time_stamp")).ToString();
            string SenderUsername = rdr.GetString(rdr.GetOrdinal("sender_user_name"));
            string SenderEmail = rdr.GetString(rdr.GetOrdinal("sender_email"));
            string RecipientEmail = rdr.GetString(rdr.GetOrdinal("recipient_email"));
            if (rdr.GetValue(rdr.GetOrdinal("email_subject")) == DBNull.Value)
                Subject = "";
            else
                Subject = rdr.GetString(rdr.GetOrdinal("email_subject"));
            if (rdr.GetValue(rdr.GetOrdinal("email_body")) == DBNull.Value)
                Body = "";
            else
                Body = rdr.GetString(rdr.GetOrdinal("email_body"));


            string Info = "<div class = \"card-block\">"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Date: </span>" + TimeStamp + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Sender Username: </span>" + SenderUsername + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Sender Email: </span>" + SenderEmail + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Recipient Email: </span>" + RecipientEmail + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Subject: </span>" + Subject + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Body: </span>" + Body + "</div>"
+ "</div>";
            inbox_panel.Controls.Add(new LiteralControl(Info));

        }

    }
    //-------------------------------------------------------------------------------------------------------------

    protected void populateDropDown(object sender, EventArgs e)
    {
        string type = Session["Type"].ToString();
        string Username = Session["Username"].ToString();


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
                ListItem userItem = new ListItem(username, username);
                dropdownlist_replacers.Items.Add(userItem);

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
                dropdownlist_replacers.Items.Add(username);

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
                dropdownlist_replacers.Items.Add(username);
            }

        }

    }


    //-----------------------------------------------------------------------------------------------------------------------------


    protected void ApplyForRequests(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string type = Session["Type"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        conn.Open();

        string TripPurpose = trip_purpose.Text;
        string TripDestination = trip_destination.Text;
        string StartDate = start_date.SelectedDate.ToShortDateString();
        string EndDate = end_date.SelectedDate.ToShortDateString();
        string LeaveType = dropdownlist_leavetype.SelectedValue;
        string Replacer = dropdownlist_replacers.SelectedValue;
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

            ApplyRequestscmd.ExecuteNonQuery();
            conn.Close();
            Label failed = new Label();
            failed.Text = "You Exceeded Your Number of Annual Leaves.";

            Label failed1 = new Label();
            failed1.Text = "Your Dates are overlapping with another Request's Dates";

            Label Passed = new Label();
            Passed.Text = "Requests Successfully Applied!";
            switch (OperationStatus.Value.ToString())
            {
                case "1":
                    apply_requests_response.Controls.Add(failed);
                    break;

                case "2":
                    apply_requests_response.Controls.Add(failed1);
                    break;
                case "3":
                    apply_requests_response.Controls.Add(Passed);
                    break;
            }

        }
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
    }

    protected void replyToEmail(object sender, EventArgs e, string RecipientUsername, string Timestamp, string SenderUsername)
    {
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

}