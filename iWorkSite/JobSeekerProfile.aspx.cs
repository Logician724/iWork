﻿using System;
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
        viewPersonalInfo(sender, e);

        //-----------PLACE HOLDERS FOR EDITING INFO------------------------------------------------
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewUserInfoSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        if (rdr.Read())
        {


            string PersonalEmail = rdr.GetString(rdr.GetOrdinal("personal_email"));
            string Birthdate = (rdr.GetValue(rdr.GetOrdinal("birth_date")).ToString()).Split(null)[0];
            string ExpYear = rdr.GetValue(rdr.GetOrdinal("exp_year")).ToString();
            string FirstName = rdr.GetString(rdr.GetOrdinal("first_name"));
            string LastName = rdr.GetString(rdr.GetOrdinal("last_name"));
            string Age = rdr.GetValue(rdr.GetOrdinal("age")).ToString();

            txt_password.Attributes.Add("placeholder", "**********");
            txt_personalemail.Attributes.Add("placeholder", PersonalEmail);
            txt_birthdate.Attributes.Add("placeholder", Birthdate);
            txt_expyrs.Attributes.Add("placeholder", ExpYear);
            txt_fn.Attributes.Add("placeholder", FirstName);
            txt_ln.Attributes.Add("placeholder", LastName);
        }

    }

    //-------------------------------------------------------------------------------------------------------------------
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

        if (rdr.Read())
        {

            string PersonalEmail = rdr.GetString(rdr.GetOrdinal("personal_email"));
            string Birthdate = (rdr.GetValue(rdr.GetOrdinal("birth_date")).ToString()).Split(null)[0];
            string ExpYear = rdr.GetValue(rdr.GetOrdinal("exp_year")).ToString();
            string FirstName = rdr.GetString(rdr.GetOrdinal("first_name"));
            string LastName = rdr.GetString(rdr.GetOrdinal("last_name"));
            string Age = rdr.GetValue(rdr.GetOrdinal("age")).ToString();

            string Info = "<div class = \"card-block\">"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Username: </span>" + Username + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Personal Email: </span>" + PersonalEmail + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Birthdate: </span>" + Birthdate + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Experience Years: </span>" + ExpYear + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">First Name: </span>" + FirstName + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Last Name: </span>" + LastName + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Age: </span>" + Age + "</div>"
+ "</div>";
            personal_info.Controls.Add(new LiteralControl(Info));

        }


    }//End of method 

    //--------------------------------------------------------------------------------------------------------------------------


    protected void editPersonalInfo(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("EditPersonalInfoSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));




        string password = txt_password.Text;
        string personalemail = txt_personalemail.Text;
        string birthdate = txt_birthdate.Text;
        string expyearTemp = txt_expyrs.Text;
        int expyear = 0;
        if (expyearTemp == "")
            expyear = Convert.ToInt32(txt_expyrs.Attributes["placeholder"]);
        else
            expyear = Convert.ToInt32(txt_expyrs.Text);
        string firstname = txt_fn.Text;
        string lastname = txt_ln.Text;

        if (string.IsNullOrEmpty(password))
        {
            cmd.Parameters.Add(new SqlParameter("@password", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@password", password));
        }
        if (string.IsNullOrEmpty(personalemail))
        {
            cmd.Parameters.Add(new SqlParameter("@personalEmail", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@personalEmail", personalemail));
        }
        if (string.IsNullOrEmpty(birthdate))
        {
            cmd.Parameters.Add(new SqlParameter("@birthDate", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@birthDate", birthdate));
        }
        if (string.IsNullOrEmpty(txt_expyrs.Text))
        {
            cmd.Parameters.Add(new SqlParameter("@expYear", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@expYear", expyear));
        }
        if (string.IsNullOrEmpty(firstname))
        {
            cmd.Parameters.Add(new SqlParameter("@firstname", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@firstname", firstname));
        }
        if (string.IsNullOrEmpty(lastname))
        {
            cmd.Parameters.Add(new SqlParameter("@lastname", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@lastname", lastname)); 
        }
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);


    } // End of Method


    //--------------------------------------------------------------------------------------------------------------------------------

    protected void viewJobsStatus(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewJobsStatusSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);


        while (rdr.Read())
        {
            string JobTitle = rdr.GetString(rdr.GetOrdinal("job_title"));
            string DepartmentCode = rdr.GetString(rdr.GetOrdinal("department_code"));
            string CompanyDomain = rdr.GetString(rdr.GetOrdinal("company_domain"));
            string Score = rdr.GetValue(rdr.GetOrdinal("score")).ToString();
            string AppStatus = rdr.GetString(rdr.GetOrdinal("app_status"));


            string viewStatus = "<div class = \"card-block\">"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Job Title: </span>" + Username + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Department Code: </span>" + DepartmentCode + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Company Domain: </span>" + CompanyDomain + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Score: </span>" + Score + "</div>"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">Application Status: </span>" + AppStatus + "</div>"
+ "</div>";

            task_status.Controls.Add(new LiteralControl(viewStatus));

        }

    }//End of Method

    //--------------------------------------------------------------------------------------------------------------------------------------




}

