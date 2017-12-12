using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;



public partial class JobSeekerProfile : System.Web.UI.Page
{





    protected void Page_Load(object sender, EventArgs e)
    {

        //----------------------------------------------------------------------------------------------------------------
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
        string Username = null;
        if (Session["Username"] != null)
        {
            Username = Session["Username"].ToString();
        }
        else
        {
            Response.Redirect("login");
        }

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

        int ApplicationCounter = 0;
        while (rdr.Read())
        {
            string JobTitle = rdr.GetString(rdr.GetOrdinal("job_title"));
            string DepartmentCode = rdr.GetString(rdr.GetOrdinal("department_code"));
            string CompanyDomain = rdr.GetString(rdr.GetOrdinal("company_domain"));
            string Score = rdr.GetValue(rdr.GetOrdinal("score")).ToString();
            string AppStatus = rdr.GetString(rdr.GetOrdinal("app_status"));
            string ViewStatus = "<div id=\"application" + ApplicationCounter + "\"" + ">\r\n" +
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
    "                            </div>" +
    "                            <div class=\"row mt-4\"\r\n>";

            Panel DeletePanel = new Panel();
            DeletePanel.CssClass = "offset-2 col-5";
            Button DeleteApp = new Button();
            DeleteApp.Text = "Delete";
            DeleteApp.CssClass = "btn btn-danger";
            DeleteApp.Click += new EventHandler((sender_delete, e_delete) => DeleteApplication(sender_delete, e_delete, JobTitle, DepartmentCode, CompanyDomain));

            if (AppStatus == "Pending")
            {

                DeleteApp.Enabled = true;
            }
            else
            {
                DeleteApp.Enabled = false;
                DeleteApp.ToolTip = "You can't delete the application unless it is pending";
            }
            DeletePanel.Controls.Add(DeleteApp);
            Panel ChooseJobPanel = new Panel();
            ChooseJobPanel.CssClass = "col-5";
            LinkButton ChooseJobLink = new LinkButton();
            ChooseJobLink.Text = "Choose Job";
            ChooseJobLink.CssClass = "btn btn-primary";
            ChooseJobLink.Attributes["data-toggle"] = "modal";
            ChooseJobLink.Attributes["href"] = "#" + "choose" + ApplicationCounter;

            if (AppStatus != "Accepted")
            {

                ChooseJobLink.CssClass = "btn btn-primary disabled";
                ChooseJobLink.ToolTip = "You can't choose this job unless your application is accepted";
            }
            ChooseJobPanel.Controls.Add(ChooseJobLink);
            applications.Controls.Add(new LiteralControl(ViewStatus));
            applications.Controls.Add(DeletePanel);
            applications.Controls.Add(ChooseJobPanel);
            applications.Controls.Add(new LiteralControl("</div>\r\n"));
            string ViewStatus2 = "</div>\r\n";
            applications.Controls.Add(new LiteralControl(ViewStatus2));
            string ChooseModalheader = "<div class=\"modal fade\" id=\"" + "choose" + ApplicationCounter + "\"" + " tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"exampleModalLabel\" aria-hidden=\"true\">\r\n" +
                "  <div class=\"modal-dialog\" role=\"document\">\r\n" +
                "    <div class=\"modal-content\">\r\n" +
                "      <div class=\"modal-header\">\r\n" +
                "        <h5 class=\"modal-title\" id=\"exampleModalLabel\">Choose Your Day Off</h5>\r\n" +
                "        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\r\n" +
                "          <span aria-hidden=\"true\">&times;</span>\r\n" +
                "        </button>\r\n" +
                "      </div>\r\n" +
                "      <div class=\"modal-body\">\r\n";
            applications.Controls.Add(new LiteralControl(ChooseModalheader));
            RadioButtonList DayOffList = new RadioButtonList();
            DayOffList.Items.Add(new ListItem("Saturday", "sat"));
            DayOffList.Items.Add(new ListItem("Sunday", "sun"));
            DayOffList.Items.Add(new ListItem("Monday", "mon"));
            DayOffList.Items.Add(new ListItem("Tuesday", "tue"));
            DayOffList.Items.Add(new ListItem("Wednesday", "wed"));
            DayOffList.Items.Add(new ListItem("Thursday", "thu"));
            DayOffList.AutoPostBack = false;
            applications.Controls.Add(DayOffList);
            string ChooseModalBody = "      </div>\r\n" +
                "      <div class=\"modal-footer\">\r\n" +
                "        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button>\r\n";
            applications.Controls.Add(new LiteralControl(ChooseModalBody));
            Button ChooseJobButton = new Button();
            ChooseJobButton.CssClass = "btn btn-primary";
            ChooseJobButton.Text = "Confirm";
            ChooseJobButton.Click += new EventHandler((sender_choose, e_choose) => ChooseJob(sender_choose, e_choose, Username, JobTitle, DepartmentCode, CompanyDomain, DayOffList));
            applications.Controls.Add(ChooseJobButton);
            string ChooseModalFooter = "      </div>\r\n" +
                 "    </div>\r\n" +
                 "  </div>\r\n" +
                 "</div>";
            applications.Controls.Add(new LiteralControl(ChooseModalFooter));
            ApplicationCounter++;
        }//End of while loop
    }//End of Method

    //--------------------------------------------------------------------------------------------------------------------------------------


    protected void Vacancies(object sender, EventArgs e)
    {

        Session["Username"] = Session["Username"].ToString(); ;
        Response.Redirect("Companies", true);

    }


    //-------------------------------------------------------------------------------------------------------------------

    protected void staff(object sender, EventArgs e)
    {
        Session["Username"] = Session["Username"].ToString();
        Session["Type"] = Session["Type"].ToString();
        Response.Redirect("Staff", true);
    }

    //------------------------------------------------------------------------------------------------------------------


    //Delete any job application he/she applied for as long as it is still in the review process.
    protected void DeleteApplication(object sender, EventArgs e, string JobTitle, string DepartmentCode, string CompanyDomain)

    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("DeletePendingApplicationSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@seekerUserName", Username));
        cmd.Parameters.Add(new SqlParameter("@jobTitle", JobTitle));
        cmd.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
        cmd.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
        conn.Open();
        cmd.ExecuteNonQuery();
    }

    protected void ChooseJob(Object sender, EventArgs e, string Username, string JobTitle, string DepartmentCode, string CompanyDomain, RadioButtonList DayOffList)
    {
        if (string.IsNullOrEmpty(DayOffList.SelectedValue))
        {
            Label ResponseLabel = new Label();
            ResponseLabel.Text = "You need to specify a day off first!";
            response.Controls.Add(ResponseLabel);
        }
        else
        {
            //format the values in the drop down list depending on the database format
            string DayOff = DayOffList.SelectedValue.ToString();
        }
    }
    protected void SignOut (object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("companies");
    }

}