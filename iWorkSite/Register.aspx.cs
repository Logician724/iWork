using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
                  
    }

    protected void register(object sender, EventArgs e)
    {

        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("RegisterToWebsite", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = txt_username.Text;
        string password = txt_password.Text;
        string personalemail = txt_email.Text;
        string birthdate = txt_birthdate.Text;
        int expyear = Convert.ToInt32(txt_expyrs.Text);
        string firstname = txt_fn.Text;
        string lastname = txt_ln.Text;
        cmd.Parameters.Add(new SqlParameter("@userName", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));
        cmd.Parameters.Add(new SqlParameter("@personalEmail", personalemail));
        cmd.Parameters.Add(new SqlParameter("@birthDate", birthdate));
        cmd.Parameters.Add(new SqlParameter("@expYear", expyear));
        cmd.Parameters.Add(new SqlParameter("@firstname", firstname));
        cmd.Parameters.Add(new SqlParameter("@lastname", lastname));
        //output parameterssub
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        switch (OperationStatus.Value.ToString())
        {
            case "False":
                Response.Write("This username is already in use");
                break;
            case "True":
                Session["Username"] = username;
                Response.Write("Successfully Registered!");
                Response.Redirect("Companies", true);
                break;
        }

    }
}