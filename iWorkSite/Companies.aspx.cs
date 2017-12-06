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

public partial class Companies : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewCompaniesSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        HtmlGenericControl NationalDiv = new HtmlGenericControl("div");
        NationalDiv.Attributes["class"] = "mt-4 mb-3";
        AddHeading(NationalDiv, "National Companies", "text-muted h2");
        HtmlGenericControl InternationalDiv = new HtmlGenericControl("div");
        AddHeading(InternationalDiv, "International Companies", "text-muted h2");
        InternationalDiv.Attributes["class"] = "mt-4 mb-3";
        //initialize ID counters
        int CompanyCount = 0;
        int DepartmentCount = 0;
        while (rdr.Read())
        {

            //get company attributes
            string CompanyName = rdr.GetString(rdr.GetOrdinal("name"));
            string DomainName = rdr.GetString(rdr.GetOrdinal("domain_name"));
            string Address = rdr.GetString(rdr.GetOrdinal("address"));
            string Field = rdr.GetString(rdr.GetOrdinal("field"));
            string Type = rdr.GetString(rdr.GetOrdinal("type"));
            string Vision = rdr.GetString(rdr.GetOrdinal("vision"));
            string Email = rdr.GetString(rdr.GetOrdinal("email"));
            //initialize sql command for finding the company phones
            SqlCommand CompanyPhoneCmd = new SqlCommand("ViewCompanyPhonesSP", conn);
            CompanyPhoneCmd.CommandType = System.Data.CommandType.StoredProcedure;
            CompanyPhoneCmd.Parameters.Add(new SqlParameter("@companyDomain", DomainName));
            //initialize data reader
            SqlDataReader PhonesReader = CompanyPhoneCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            ArrayList Phones = new ArrayList();
            while (PhonesReader.Read())
            {
                string CompanyPhone = PhonesReader.GetString(PhonesReader.GetOrdinal("phone"));
                Phones.Add(CompanyPhone);
            }
            //initialize a company div
            HtmlGenericControl CompanyDiv = new HtmlGenericControl("div");
            //Add company info to the div
            AddCompany(DomainName, CompanyName, Field, Vision, Type, Address, Email, Phones, CompanyCount, CompanyDiv);
            //Initialize Department sql
            SqlCommand DeparmentViewQuery = new SqlCommand("ViewDepartmentsOfCompanySP", conn);
            DeparmentViewQuery.CommandType = System.Data.CommandType.StoredProcedure;
            DeparmentViewQuery.Parameters.Add(new SqlParameter("@companyDomain", DomainName));
            SqlDataReader DepartmentReader = DeparmentViewQuery.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            HtmlGenericControl DepartmentContainer = new HtmlGenericControl("div");
            DepartmentContainer.Attributes["id"] = "company" + CompanyCount;
            DepartmentContainer.Attributes["class"] = "collapse";
            while (DepartmentReader.Read())
            {
                // get department attributes
                string DepartmentName = DepartmentReader.GetString(DepartmentReader.GetOrdinal("name"));
                string DepartmentCode = DepartmentReader.GetString(DepartmentReader.GetOrdinal("department_code"));
                //initialize department div
                HtmlGenericControl DepartmentDiv = new HtmlGenericControl("div");
                //add a department
                AddDepartment(DepartmentCode, DomainName, DepartmentName, CompanyCount, DepartmentCount, DepartmentDiv);
                //initialize job sql
                SqlCommand JobsViewQuery = new SqlCommand("ViewJobsWithVacancySP", conn);
                JobsViewQuery.CommandType = System.Data.CommandType.StoredProcedure;
                JobsViewQuery.Parameters.Add(new SqlParameter("@companyDomain", DomainName));
                JobsViewQuery.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
                SqlDataReader JobReader = JobsViewQuery.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                HtmlGenericControl JobContainer = new HtmlGenericControl("div");
                JobContainer.Attributes["id"] = "department" + DepartmentCount;
                JobContainer.Attributes["class"] = "collapse";
                while (JobReader.Read())
                {
                    string JobTitle = JobReader.GetString(JobReader.GetOrdinal("job_title"));
                    string ApplicationDeadline = JobReader.GetValue(JobReader.GetOrdinal("application_deadline")).ToString();
                    string DetailedDescription = JobReader.GetString(JobReader.GetOrdinal("detailed_description"));
                    string MinYearsExperience = JobReader.GetValue(JobReader.GetOrdinal("min_years_experience")).ToString();
                    string Salary = JobReader.GetValue(JobReader.GetOrdinal("salary")).ToString();
                    string ShortDescription = JobReader.GetString(JobReader.GetOrdinal("short_description"));
                    string Vacancies = JobReader.GetValue(JobReader.GetOrdinal("vacancies")).ToString();
                    string WorkingHours = JobReader.GetValue(JobReader.GetOrdinal("working_hours")).ToString();
                    HtmlGenericControl JobDiv = new HtmlGenericControl("div");
                    JobDiv.Attributes["id"] = "department" + DepartmentCount;
                    AddJob(DepartmentCode, DomainName, JobTitle, ApplicationDeadline, Vacancies, DetailedDescription, ShortDescription, MinYearsExperience, Salary, WorkingHours, DepartmentCount, JobDiv);
                    JobContainer.Controls.Add(JobDiv);

                }
                DepartmentDiv.Controls.Add(JobContainer);
                DepartmentContainer.Controls.Add(DepartmentDiv);
                DepartmentCount++;

            }
            CompanyDiv.Controls.Add(DepartmentContainer);
            CompanyDiv.Controls.Add(new LiteralControl("<hr/>"));
            if (Type == "International")
            {
                InternationalDiv.Controls.Add(CompanyDiv);
            }
            if (Type == "National")
            {
                NationalDiv.Controls.Add(CompanyDiv);
            }

            CompanyCount++;
        }
        main_content.Controls.Add(InternationalDiv);
        main_content.Controls.Add(NationalDiv);
    }

    protected void SearchByAvgSalary(object sender, EventArgs e)
    {
        main_content.Controls.Clear();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewCompaniesSalariesSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            string CompanyDomain = rdr.GetString(rdr.GetOrdinal("company_domain"));
            string AverageSalary = rdr.GetValue(rdr.GetOrdinal("average_salary")).ToString();
            SqlCommand CompanyInfoCommand = new SqlCommand("ViewCompanySP", conn);
            CompanyInfoCommand.CommandType = System.Data.CommandType.StoredProcedure;
            CompanyInfoCommand.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
            SqlDataReader CompanyInfoReader = CompanyInfoCommand.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            CompanyBuild(CompanyInfoReader, conn);
        }
    }

    protected void searchCompaniesByName(Object sender, EventArgs e)
    {
        main_content.Controls.Clear();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand SearchCompanyCmd = new SqlCommand("SearchCompanyByNameSP", conn);
        SearchCompanyCmd.CommandType = System.Data.CommandType.StoredProcedure;
        string keyword = txt_search.Text;
        SearchCompanyCmd.Parameters.Add(new SqlParameter("@keyWord", keyword));
        conn.Open();
        SqlDataReader CompanyInfoReader = SearchCompanyCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        CompanyBuild(CompanyInfoReader, conn);
    }

    protected void searchCompaniesByAddress(Object sender, EventArgs e)
    {
        main_content.Controls.Clear();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand SearchCompanyCmd = new SqlCommand("SearchCompanyByAddressSP", conn);
        SearchCompanyCmd.CommandType = System.Data.CommandType.StoredProcedure;
        string keyword = txt_search.Text;
        SearchCompanyCmd.Parameters.Add(new SqlParameter("@keyWord", keyword));
        conn.Open();
        SqlDataReader CompanyInfoReader = SearchCompanyCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        CompanyBuild(CompanyInfoReader, conn);
    }//End of Method

    protected void searchCompaniesByType(Object sender, EventArgs e)
    {
        main_content.Controls.Clear();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand SearchCompanyCmd = new SqlCommand("SearchCompanyByTypeSP", conn);
        SearchCompanyCmd.CommandType = System.Data.CommandType.StoredProcedure;
        string keyword = txt_search.Text;
        SearchCompanyCmd.Parameters.Add(new SqlParameter("@keyWord", keyword));
        conn.Open();
        SqlDataReader rdr = SearchCompanyCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        CompanyBuild(rdr, conn);
    }

    protected void searchJob(Object sender, EventArgs e)
    {
        main_content.Controls.Clear();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand SearchJobCmd = new SqlCommand("SearchJobsSP", conn);
        SearchJobCmd.CommandType = System.Data.CommandType.StoredProcedure;
        string keywords = txt_search.Text;
        SearchJobCmd.Parameters.Add(new SqlParameter("@keywords", keywords));
        conn.Open();
        SqlDataReader JobsReader = SearchJobCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        while (JobsReader.Read())
        {
            string JobTitle = JobsReader.GetString(JobsReader.GetOrdinal("job_title"));
            string DepartmentCode = JobsReader.GetString(JobsReader.GetOrdinal("department_code"));
            string CompanyDomain = JobsReader.GetString(JobsReader.GetOrdinal("company_domain"));
            string ApplicationDeadline = JobsReader.GetOrdinal("application_deadline").ToString();
            string DetailedDescription = JobsReader.GetString(JobsReader.GetOrdinal("detailed_description"));
            string MinYearsExp = JobsReader.GetValue(JobsReader.GetOrdinal("min_years_experience")).ToString();
            string Salary = JobsReader.GetValue(JobsReader.GetOrdinal("salary")).ToString();
            string ShortDescription = JobsReader.GetString(JobsReader.GetOrdinal("short_description"));
            string Vacancies = JobsReader.GetValue(JobsReader.GetOrdinal("vacancies")).ToString();
            string WorkingHours = JobsReader.GetValue(JobsReader.GetOrdinal("working_hours")).ToString();
            string JobBuild = "<div class = \"card-block\">"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Job Title: </span>" + JobTitle + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Department code: </span>" + DepartmentCode + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Company Domain: </span>" + CompanyDomain + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Application Deadline: </span>" + ApplicationDeadline + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Detailed Description: </span>" + DetailedDescription + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Minimum Years Of Experience: </span>" + MinYearsExp + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Salary: </span>" + Salary + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Short Description: </span>" + ShortDescription + "</div>"
        + "<div class = \"card-text\"><span class = \"font-weight-bold\">Vacancies: </span>" + Vacancies + "</div>"
        + "<div class = \"card-text\"><span class=\"font-weight-bold\">Working Hours: </span>" + WorkingHours + "</div>"
        + "</div>";

            Panel Job = new Panel();
            Job.CssClass = "card";
            Job.Controls.Add(new LiteralControl(JobBuild));
            main_content.Controls.Add(Job);
        }


    }

    protected void SearchCompany(object sender, EventArgs e)
    {
        if (Request.Form["radio_search_company"] != null)
        {
            string SearchType = Request.Form["radio_search_company"];
            if (SearchType == "radio_search_name")
            {
                searchCompaniesByName(sender, e);
            }
            else
                if (SearchType == "radio_search_address")
                {
                    searchCompaniesByAddress(sender, e);
                }
                else
                    if (SearchType == "radio_search_type")
                    {
                        searchCompaniesByType(sender, e);
                    }
                    else
                        if (SearchType == "radio_search_avg_salary")
                        {
                            SearchByAvgSalary(sender, e);
                        }
        }
    }

    protected void AddCompany(string CompanyDomain, string CompanyName, string Field, string Vision, string Type, string Address, string Email, ArrayList Phones, int CompanyID, HtmlGenericControl CompanyDiv)
    {
        string PhonesBuild = "";
        for (int i = 0; i < Phones.Count; i++)
        {
            PhonesBuild += Phones[i] + " ";
        }
        string CompanyBuild = "<div class=\"mt-4 display-2 text-capitalize\">" + CompanyName + "</div>\r\n " +
            "           <div>\r\n" +
            "                <p class=\"mt-2 lead\">" + Vision + "</p>\r\n" +
            "            </div>\r\n" +
            "            <div class=\"row mb-4\">\r\n" +
            "                <div class=\"col-4 font-weight-bold font-italic\">Type</div>\r\n" +
            "                <div class=\"col-4 font-weight-bold font-italic\">Field</div>\r\n" +
            "                <div class=\"col-4 font-weight-bold font-italic\">Domain Name</div>\r\n" +
            "            </div>\r\n" +
            "            <div class=\"row\">\r\n" +
            "                <div class=\"col-4\">" + Type + "</div>\r\n" +
            "                <div class=\"col-4\">" + Field + "</div>\r\n" +
            "                <div class=\"col-4\">" + CompanyDomain + "</div>\r\n" +
            "            </div>\r\n" +
            "            <div class=\"row mt-5 mb-4\">\r\n" +
            "                <div class=\"col-4 font-weight-bold font-italic\">Email</div>\r\n" +
            "                <div class=\"col-4 font-weight-bold font-italic\">Address</div>\r\n" +
            "                <div class=\"col-4 font-weight-bold font-italic\">Phones</div>\r\n" +
            "            </div>\r\n" +
            "            <div class=\"row\">\r\n" +
            "                <div class=\"col-4\">" + Email + "</div>\r\n" +
            "                <div class=\"col-4 text-justify\">" + Address + "</div>\r\n" +
            "                <div class=\"col-4\">" + PhonesBuild + "</div>\r\n" +
            "            </div>\r\n" +
            "                <div class=\"mt-4 row\">\r\n" +
            "                    <div class=\"col-10 h4 text-muted font-comfortaa\">\r\n" +
            "                        <a data-toggle=\"collapse\" href=\"" + "#company" + CompanyID + "\" aria-expanded=\"false\">View Departments</a>\r\n" +
            "                    </div>\r\n" +
            "                </div>";

        CompanyDiv.Controls.Add(new LiteralControl(CompanyBuild));

    }

    protected void AddDepartment(string DepartmentCode, string CompanyDomain, string DepartmentName, int CompanyID, int DepartmentID, HtmlGenericControl DepartmentDiv)
    {
        string DepartmentBuild =
            "                    <div class=\"mt-3\">\r\n" +
            "                        <div class=\"display-3 text-capitalize\">" + DepartmentName + "</div>\r\n" +
            "                        <div class=\"lead\">\r\n" +
            "                            <p>" + DepartmentCode + "</p>\r\n" +
            "                        </div>\r\n" +
            "                    </div>" +
            "                    <div class=\"row\">\r\n" +
            "                        <div class=\"col-10 h4 text-muted font-comfortaa\">\r\n" +
            "                            <a data-toggle=\"collapse\" href=\"" + "#department" + DepartmentID + "\" aria-expanded=\"false\">View Jobs</a>\r\n" +
            "                        </div>\r\n" +
            "                     </div>\r\n";
        DepartmentDiv.Controls.Add(new LiteralControl(DepartmentBuild));
    }

    protected void AddJob(string DepartmentCode, string CompanyDomain, string JobTitle, string ApplicationDeadline, string Vacancies, string DetailedDescription, string ShortDescription, string MinYearsExp, string Salary, string WorkingHours, int DepartmentID, HtmlGenericControl JobDiv)
    {
        string JobBuild = "<div class=\"mt-3 row\">\r\n" +
            "                            <div class=\"offset-1 col-10 display-4 Capitalize\">" + JobTitle + "</div>\r\n" +
            "                        </div>\r\n" +
            "                        <div class=\"mt-2 lead offset-1\">\r\n" +
            "                            <p>" + ShortDescription + "</p>\r\n" +
            "                        </div>\r\n" +
            "                            <div class=\"offset-1 h4 mt-2 text-muted\">Description</div>\r\n" +
            "                            <div class=\"offset-1 lead mt-1\">" + DetailedDescription + "</div>\r\n" +
            "                            <div class=\"row mt-4 mb-3\">\r\n" +
            "                              <div class=\"offset-2 col-3 font-weight-bold font-italic\">Application Deadline</div>\r\n" +
            "                              <div class=\"col-3 font-weight-bold font-italic\">Years Of Experience</div>\r\n" +
            "                              <div class=\"col-3 font-weight-bold font-italic\">Salary</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-2 row\">\r\n" +
            "                              <div class=\"offset-2 col-3\">" + ApplicationDeadline + "</div>\r\n" +
            "                              <div class=\"col-3\">" + MinYearsExp + "</div>\r\n" +
            "                              <div class=\"col-3\">" + Salary + "</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"row mt-4\">\r\n" +
            "                              <div class=\"offset-2 col-3 font-weight-bold font-italic\">Vacancies</div>\r\n" +
            "                              <div class=\"offset-3 col-3 font-weight-bold font-italic\">Working Hours</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-3 row\">\r\n" +
            "                              <div class=\"offset-2 col-3\">" + Vacancies + "</div>\r\n";
        JobDiv.Controls.Add(new LiteralControl(JobBuild));
        Button ApplyButton = new Button();
        ApplyButton.CssClass = "btn btn-primary";
        ApplyButton.Click += new EventHandler((sender_apply, e_apply) => ApplyForJob(sender_apply, e_apply, JobTitle, DepartmentCode, CompanyDomain, Session["Username"].ToString(),JobDiv));
        ApplyButton.Text = "Apply Now!";
      
        if (Session["Username"] == null)
        {
            ApplyButton.Enabled = false;

            ApplyButton.ToolTip = "please login or register first";
        }
        else if (Session["Type"].ToString() != "Job Seeker")
        {
            ApplyButton.Visible = false;
        }
        else
        {
            ApplyButton.Enabled = true;
        }
        Panel ApplyPanel = new Panel();
        ApplyPanel.CssClass = "col-3 pb-4";
        ApplyPanel.Controls.Add(ApplyButton);
        JobDiv.Controls.Add(ApplyPanel);
        string JobBuild2 = "                              <div class=\"col-3\">" + WorkingHours + "</div>\r\n" +
            "                            </div>";
        JobDiv.Controls.Add(new LiteralControl(JobBuild2));

    }

    protected void CompanyBuild(SqlDataReader CompanyInfoReader, SqlConnection conn)
    {
        int CompanyCount = 0;
        int DepartmentCount = 0;
        while (CompanyInfoReader.Read())
        {
            string CompanyName = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("name"));
            string CompanyDomain = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("domain_name"));
            string Address = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("address"));
            string Field = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("field"));
            string Type = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("type"));
            string Vision = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("vision"));
            string Email = CompanyInfoReader.GetString(CompanyInfoReader.GetOrdinal("email"));
            //initialize sql command for finding the company phones
            SqlCommand CompanyPhoneCmd = new SqlCommand("ViewCompanyPhonesSP", conn);
            CompanyPhoneCmd.CommandType = System.Data.CommandType.StoredProcedure;
            CompanyPhoneCmd.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
            //initialize data reader
            SqlDataReader PhonesReader = CompanyPhoneCmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            ArrayList Phones = new ArrayList();
            while (PhonesReader.Read())
            {
                string CompanyPhone = PhonesReader.GetString(PhonesReader.GetOrdinal("phone"));
                Phones.Add(CompanyPhone);
            }
            HtmlGenericControl CompanyDiv = new HtmlGenericControl();
            AddCompany(CompanyDomain, CompanyName, Field, Vision, Type, Address, Email, Phones, CompanyCount, CompanyDiv);
            //initialize Department Sql
            SqlCommand DeparmentViewQuery = new SqlCommand("ViewDepartmentsOfCompanySP", conn);
            DeparmentViewQuery.CommandType = System.Data.CommandType.StoredProcedure;
            DeparmentViewQuery.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
            SqlDataReader DepartmentReader = DeparmentViewQuery.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            HtmlGenericControl DepartmentContainer = new HtmlGenericControl("div");
            DepartmentContainer.Attributes["id"] = "company" + CompanyCount;
            DepartmentContainer.Attributes["class"] = "collapse";
            while (DepartmentReader.Read())
            {
                // get department attributes
                string DepartmentName = DepartmentReader.GetString(DepartmentReader.GetOrdinal("name"));
                string DepartmentCode = DepartmentReader.GetString(DepartmentReader.GetOrdinal("department_code"));
                //initialize department div
                HtmlGenericControl DepartmentDiv = new HtmlGenericControl("div");
                //add a department
                AddDepartment(DepartmentCode, CompanyDomain, DepartmentName, CompanyCount, DepartmentCount, DepartmentDiv);
                //initialize job sql
                SqlCommand JobsViewQuery = new SqlCommand("ViewJobsWithVacancySP", conn);
                JobsViewQuery.CommandType = System.Data.CommandType.StoredProcedure;
                JobsViewQuery.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
                JobsViewQuery.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
                SqlDataReader JobReader = JobsViewQuery.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                HtmlGenericControl JobContainer = new HtmlGenericControl("div");
                JobContainer.Attributes["id"] = "department" + DepartmentCount;
                JobContainer.Attributes["class"] = "collapse";
                while (JobReader.Read())
                {
                    string JobTitle = JobReader.GetString(JobReader.GetOrdinal("job_title"));
                    string ApplicationDeadline = JobReader.GetValue(JobReader.GetOrdinal("application_deadline")).ToString();
                    string DetailedDescription = JobReader.GetString(JobReader.GetOrdinal("detailed_description"));
                    string MinYearsExperience = JobReader.GetValue(JobReader.GetOrdinal("min_years_experience")).ToString();
                    string Salary = JobReader.GetValue(JobReader.GetOrdinal("salary")).ToString();
                    string ShortDescription = JobReader.GetString(JobReader.GetOrdinal("short_description"));
                    string Vacancies = JobReader.GetValue(JobReader.GetOrdinal("vacancies")).ToString();
                    string WorkingHours = JobReader.GetValue(JobReader.GetOrdinal("working_hours")).ToString();
                    HtmlGenericControl JobDiv = new HtmlGenericControl("div");
                    JobDiv.Attributes["id"] = "department" + DepartmentCount;
                    AddJob(DepartmentCode, CompanyDomain, JobTitle, ApplicationDeadline, Vacancies, DetailedDescription, ShortDescription, MinYearsExperience, Salary, WorkingHours, DepartmentCount, JobDiv);
                    JobContainer.Controls.Add(JobDiv);

                }
                DepartmentDiv.Controls.Add(JobContainer);
                DepartmentContainer.Controls.Add(DepartmentDiv);
                DepartmentCount++;

            }
            CompanyDiv.Controls.Add(DepartmentContainer);
            main_content.Controls.Add(CompanyDiv);
        }
        CompanyCount++;
    }
    protected void AddHeading(HtmlGenericControl TargetDiv, string HeadingText, string HeadingCss)
    {
        Panel HeadingPanel = new Panel();
        Label HeadingLabel = new Label();
        HeadingLabel.Text = HeadingText;
        HeadingLabel.CssClass = HeadingCss;
        HeadingPanel.Controls.Add(HeadingLabel);
        TargetDiv.Controls.Add(HeadingPanel);
    }
    protected void ApplyForJob(object sender, EventArgs e, string JobTitle, string DepartmentCode, string CompanyDomain, string SeekerUsername, HtmlGenericControl JobDiv)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ApplyForJobSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@seekerUserName", SeekerUsername));
        cmd.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
        cmd.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
        cmd.Parameters.Add(new SqlParameter("@jobTitle", JobTitle));
        //output parameters
        SqlParameter operationstatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Int);
        operationstatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

      //  Label failed1 = new Label();
       // failed1.Text = "You already have a pending application for this job.";

//        Label failed2 = new Label();
  //      failed2.Text = "You don't have enough experience years for this job";

    //    Label passed = new Label();
      //  passed.Text = "Successfully Applied!";

        switch (operationstatus.Value.ToString())
        {
            case "1":
               // JobDiv.Controls.Add(failed1);
                break;
            case "2":
                //JobDiv.Controls.Add(failed2);
                break;
            case "3":
                //JobDiv.Controls.Add(passed);
                Response.Redirect("JobSeekerProfile",true);
                break;



        }
    }
}