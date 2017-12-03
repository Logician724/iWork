using System;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void register(object sender, EventArgs e)
    {
        Response.Redirect("Register", true);
    }

    protected void login(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("UserLoginSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = txt_username.Text;

        string password = txt_password.Text;
        cmd.Parameters.Add(new SqlParameter("@userName", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));
        //output parameters
        SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
        type.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Label failed = new Label();
        failed.Text = "Failed to login please check your username and password";
        switch (type.Value.ToString())
        {
            case "0":
                login_response.Controls.Add(failed);
                break;
            case "1":
                Session["Type"] = "Job Seeker";
                Session["Username"] = username;
                Response.Redirect("JobSeekerProfile", true);
                break;
            case "2":
                Session["Type"] = "Manager";
                Session["Username"] = username;
                Response.Redirect("ManagerControl", true);
                break;
            case "3":
                Session["Type"] = "HR";
                Session["Username"] = username;
                Response.Redirect("HRControl", true);
                break;
            case "4":
                Session["Type"] = "Regular";
                Session["Username"] = username;
                Response.Redirect("RegularEmployeeProfile", true);
                break;
        }
    }
}