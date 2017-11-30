using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


public partial class JobSeekerProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void edit(object sender, EventArgs e)
    {
        Response.Redirect("EditPersonalInfo", true);
    }

    protected void viewPersonalInfo(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewUserInfoSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        while (rdr.Read())
        {
           
            string Password = rdr.GetString(rdr.GetOrdinal("password"));
            string PersonalEmail = rdr.GetString(rdr.GetOrdinal("password"));
            string Birthdate = rdr.GetString(rdr.GetOrdinal("password"));
            string Password = rdr.GetString(rdr.GetOrdinal("password"));
            string Password = rdr.GetString(rdr.GetOrdinal("password"));
            string Password = rdr.GetString(rdr.GetOrdinal("password"));
            string Password = rdr.GetString(rdr.GetOrdinal("password"));

        }



    }
}