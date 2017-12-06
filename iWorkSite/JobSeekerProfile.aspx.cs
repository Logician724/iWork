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
        viewJobsStatus(sender, e);
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

            string Info =
        "<div class=\"mt-3 row\">\r\n" +
            "                            <div class=\"offset-1 col-10 display-4 Capitalize\">" + Username + "</div>\r\n" +
            "                        </div>\r\n" +
            "                        <div class=\"mt-2 lead offset-1\">\r\n" +
            "                            <p>" + PersonalEmail + "</p>\r\n" +
            "                        </div>\r\n" +
            "                            <div class=\"row mt-4 mb-3\">\r\n" +
            "                              <div class=\"offset-2 col-5 font-weight-bold font-italic\">Name</div>\r\n" +
            "                              <div class=\"col-5 font-weight-bold font-italic\">Years Of Experience</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-2 row\">\r\n" +
            "                              <div class=\"offset-2 col-5\">" + FirstName + " " + LastName + "</div>\r\n" +
            "                              <div class=\"col-5\">" + ExpYear + "</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"row mt-4\">\r\n" +
            "                              <div class=\"offset-2 col-5 font-weight-bold font-italic\">Birthdate</div>\r\n" +
            "                              <div class=\"col-5 font-weight-bold font-italic\">Age</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-3 row\">\r\n" +
            "                              <div class=\"offset-2 col-5\">" + Birthdate + "</div>\r\n" +
            "                               <div class=\"col-5\">" + Age + "</div>\r\n </div>\r\n";
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


            string viewStatus =
            "<div class=\"mt-3 row\">\r\n" +
    "                            <div class=\"offset-1 col-10 display-4 Capitalize\">" + JobTitle + "</div>\r\n" +
    "                        </div>\r\n" +
    "                        <div class=\"mt-2 lead offset-1\">\r\n" +
    "                            <p>" + CompanyDomain + "/" + DepartmentCode + "</p>\r\n" +
    "                        </div>\r\n" +
    "                            <div class=\"row mt-4\">\r\n" +
    "                              <div class=\"offset-2 col-5 font-weight-bold font-italic\">Score</div>\r\n" +
    "                              <div class=\"col-5 font-weight-bold font-italic\">Application Status</div>\r\n" +
    "                            </div>\r\n" +
    "                            <div class=\"mt-3 row\">\r\n" +
    "                               <div class=\"offset-2 col-5\">" + Score + "</div>\r\n" +
    "                               <div class=\"col-5\">" + AppStatus + "</div>\r\n" +
    "                            <div class=\"row mt-4\"\r\n" +
    "                               <div class=\"offset-2 col-3\"";
            Button deleteApp = new Button();
            deleteApp.Text = "Delete";
            deleteApp.CssClass = "btn btn-danger";
            string viewStatus2 = "</div>" +
    "</div>\r\n"; "

            applications.Controls.Add(new LiteralControl(viewStatus));

        }

    }//End of Method

    //--------------------------------------------------------------------------------------------------------------------------------------




}

