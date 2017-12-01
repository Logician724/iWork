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


}