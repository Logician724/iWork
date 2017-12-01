using System;
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



                    viewattendance_panel.Controls.Add(new LiteralControl(requests));





                }//end of while loop


                break;

        }




    }


}