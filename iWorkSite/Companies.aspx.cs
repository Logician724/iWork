using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;



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
        while (rdr.Read())
        {
            string CompanyName = rdr.GetString(rdr.GetOrdinal("name"));
            string DomainName = rdr.GetString(rdr.GetOrdinal("domain_name"));
            string Address = rdr.GetString(rdr.GetOrdinal("address"));
            string Field = rdr.GetString(rdr.GetOrdinal("field"));
            string Type = rdr.GetString(rdr.GetOrdinal("type"));
            string Vision = rdr.GetString(rdr.GetOrdinal("vision"));
            string Email = rdr.GetString(rdr.GetOrdinal("email"));
            string Phone = rdr.GetString(rdr.GetOrdinal("phone"));
            //string CardDiv = "<div class=\"card\">"
            //+ "<div class=\"card-block\">"
            //+ "<asp:Label class=\"card-title text-muted\">" + CompanyName + "</div>"
            //+ "<div class=\"card-text \"><span class =\"font-weight-bold\" >Field: </span>" + Field + "</div>"
            //+ "<div class=\"card-text \"><span class =\"font-weight-bold\" >Type: </span>" + Type + "</div>"
            //+ "<div class=\"card-text \"><span class =\"font-weight-bold\" >Vision: </span>" + Vision + "</div>"
            //+ "<div class=\"card-text \"><span class =\"font-weight-bold\" >Domain Name: </span>" + DomainName + "</div>"
            //+ "<div class=\"card-text \"><span class =\"font-weight-bold\" >Email: </span>" + Email + "</div>"
            //+ "<div class=\"card-text \"><span class =\"font-weight-bold\" >Address: </span>" + Address + "</div>"
            //+ "<a href = \"#\" class=\"btn btn-primary\">Kill me please</a>"
            //+ "</div>"
            //+ "</div>";
            //div_main.Controls.Add(new LiteralControl(CardDiv));

            //holder labels
            Label FieldHolder = new Label();
            Label TypeHolder = new Label();
            Label AddressHolder = new Label();
            Label EmailHolder = new Label();
            Label VisionHolder = new Label();
            Label CompanyDomainHolder = new Label();
            Label PhoneHolder = new Label();
            //holder labels attr
            FieldHolder.CssClass = "font-weight-bold";
            FieldHolder.Text = "Field: ";
            TypeHolder.CssClass = "font-weight-bold";
            TypeHolder.Text = "Type: ";
            AddressHolder.CssClass = "font-weight-bold";
            AddressHolder.Text = "Address: ";
            EmailHolder.CssClass = "font-weight-bold";
            EmailHolder.Text = "Email: ";
            VisionHolder.CssClass = "font-weight-bold";
            VisionHolder.Text = "Vision: ";
            CompanyDomainHolder.CssClass = "font-weight-bold";
            CompanyDomainHolder.Text = "Domain Name: ";
            PhoneHolder.CssClass = "font-weight-bold";
            PhoneHolder.Text = "Phone(s):";
            //company info labels
            Label CompanyDomainLabel = new Label();
            Label CompanyNameLabel = new Label();
            Label EmailLabel = new Label();
            Label TypeLabel = new Label();
            Label FieldLabel = new Label();
            Label VisionLabel = new Label();
            Label AddressLabel = new Label();
            Label PhoneLabel = new Label();
            //company info labels attr
            CompanyDomainLabel.Text = DomainName;
            CompanyNameLabel.Text = CompanyName;
            CompanyNameLabel.CssClass = " text-muted font-weight-bold";
            EmailLabel.Text = Email;
            TypeLabel.Text = Type;
            FieldLabel.Text = Field;
            VisionLabel.Text = Vision;
            AddressLabel.Text = Address;
            PhoneLabel.Text = Phone;
            //company info panels
            Panel CompanyNamePanel = new Panel();
            Panel CompanyDomainPanel = new Panel();
            Panel TypePanel = new Panel();
            Panel VisionPanel = new Panel();
            Panel EmailPanel = new Panel();
            Panel FieldPanel = new Panel();
            Panel AddressPanel = new Panel();
            Panel PhonePanel = new Panel();
            Panel CardBlockPanel = new Panel();
            Panel CardPanel = new Panel();
            //add action panel
            Panel ActionPanel = new Panel();
            //company info panels attr
            CompanyNamePanel.CssClass = "card-title";           
            CompanyDomainPanel.CssClass = "card-text";
            TypePanel.CssClass = "card-text";
            VisionPanel.CssClass = "card-text";
            EmailPanel.CssClass = "card-text";
            FieldPanel.CssClass = "card-text";
            AddressPanel.CssClass = "card-text";
            PhonePanel.CssClass = "card-text";
            CardPanel.CssClass = "card";
            CardBlockPanel.CssClass = "card-block";
            //add action panel attr
            ActionPanel.CssClass = "card-block flex-row flex-wrap";
            //add actions form
            Button DepartmentButton = new Button();
            DepartmentButton.Text = "View Departments";
            DepartmentButton.CssClass = "btn btn-primary";
           
             DepartmentButton.Click += new EventHandler((sender_dep_btn, e_dep_btn) => ViewDepartments(sender_dep_btn, e_dep_btn, DomainName,CardBlockPanel));
            //add sub panels to the main panel
            CompanyNamePanel.Controls.Add(CompanyNameLabel);
            CompanyDomainPanel.Controls.Add(CompanyDomainHolder);
            CompanyDomainPanel.Controls.Add(CompanyDomainLabel);
            EmailPanel.Controls.Add(EmailHolder);
            EmailPanel.Controls.Add(EmailLabel);
            VisionPanel.Controls.Add(VisionHolder);
            VisionPanel.Controls.Add(VisionLabel);
            TypePanel.Controls.Add(TypeHolder);
            TypePanel.Controls.Add(TypeLabel);
            FieldPanel.Controls.Add(FieldHolder);
            FieldPanel.Controls.Add(FieldLabel);
            AddressPanel.Controls.Add(AddressHolder);
            AddressPanel.Controls.Add(AddressLabel);
            PhonePanel.Controls.Add(PhoneHolder);
            PhonePanel.Controls.Add(PhoneLabel);
            ActionPanel.Controls.Add(DepartmentButton);
            CardBlockPanel.Controls.Add(CompanyNamePanel);
            CardBlockPanel.Controls.Add(FieldPanel);
            CardBlockPanel.Controls.Add(TypePanel);
            CardBlockPanel.Controls.Add(VisionPanel);
            CardBlockPanel.Controls.Add(CompanyDomainPanel);
            CardBlockPanel.Controls.Add(EmailPanel);
            CardBlockPanel.Controls.Add(AddressPanel);
            CardBlockPanel.Controls.Add(PhonePanel);
            CardBlockPanel.Controls.Add(ActionPanel);
            CardPanel.Controls.Add(CardBlockPanel);
            div_main.Controls.Add(CardPanel);            
        }
        
    }

    protected void ViewDepartments(Object sender, EventArgs e, string DomainName, Panel TargetPanel)
    {
       
            
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewDepartmentsOfCompanySP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@companyDomain", DomainName));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        Panel CardPanel = new Panel();
        CardPanel.CssClass = "card";
        while (rdr.Read())
        {
            string DepartmentName = rdr.GetString(rdr.GetOrdinal("name"));
            string DepartmentCode = rdr.GetString(rdr.GetOrdinal("department_code"));
            //holder labels
            Label DepartmentNameHolder = new Label();
            Label DepartmentCodeHolder = new Label();
            //holder label attr
            DepartmentNameHolder.Text = "Deaprtment Name: ";
            DepartmentNameHolder.CssClass = "font-weight-bold";
            DepartmentCodeHolder.Text = "Department Code: ";
            DepartmentCodeHolder.CssClass = "font-weight-bold";
            //department info labels
            Label DepartmentNameLabel = new Label();
            Label DepartmentCodeLabel = new Label();
            //department info label attributes
            DepartmentNameLabel.Text = DepartmentName;
            DepartmentCodeLabel.Text = DepartmentCode;
            //department info panels
            Panel DepartmentNamePanel = new Panel();
            Panel DepartmentCodePanel = new Panel();
            //add action panel
            Panel ActionPanel = new Panel();
            //add panel styles
            DepartmentNamePanel.CssClass = "card-text";
            DepartmentCodePanel.CssClass = "card-text";
            //add action panel styles
            ActionPanel.CssClass = "card-block flex-row flex-wrap";
            //add labels to correct panels
            DepartmentNamePanel.Controls.Add(DepartmentNameHolder);
            DepartmentNamePanel.Controls.Add(DepartmentNameLabel);
            DepartmentCodePanel.Controls.Add(DepartmentCodeHolder);
            DepartmentCodePanel.Controls.Add(DepartmentCodeLabel);
            //add main panels
            Panel CardBlockPanel = new Panel();
            //add main panels attr
            CardBlockPanel.CssClass = "card-block";
           

            //add actions form
            Button JobsButton = new Button();
            JobsButton.Text = "View Available Jobs";
            JobsButton.CssClass = "btn btn-primary";

            JobsButton.Click += new EventHandler((sender_job_btn, e_job_btn) => ViewJobs(sender_job_btn, e_job_btn, DomainName,DepartmentCode, CardBlockPanel));
           

            //add sub-panels to main panel
            CardBlockPanel.Controls.Add(DepartmentNamePanel);
            CardBlockPanel.Controls.Add(DepartmentCodePanel);
            ActionPanel.Controls.Add(JobsButton);
            CardBlockPanel.Controls.Add(ActionPanel);
            CardPanel.Controls.Add(CardBlockPanel);
        }
        TargetPanel.Controls.Add(CardPanel);



    }

    protected void ViewJobs(Object sender, EventArgs e, string DomainName,string DepartmentCode, Panel TargetPanel)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewJobsWithVacancySP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@companyDomain", DomainName));
        cmd.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        Panel CardPanel = new Panel();
        CardPanel.CssClass = "card";
        while (rdr.Read())
        {

            string JobTitle = rdr.GetString(rdr.GetOrdinal("job_title"));
            string ApplicationDeadline = rdr.GetString(rdr.GetOrdinal("application_deadline"));
            string DetailedDescription = rdr.GetString(rdr.GetOrdinal("detailed_description"));
            string MinYearsExperience = rdr.GetString(rdr.GetOrdinal("min_years_experience"));
            string Salary = rdr.GetString(rdr.GetOrdinal("salary"));
            string ShortDescription = rdr.GetString(rdr.GetOrdinal("short_description"));
            string Vacancies = rdr.GetString(rdr.GetOrdinal("vacancies"));
            string WorkingHours = rdr.GetString(rdr.GetOrdinal("working_hours"));
            //holder labels
            Label JobTitleHolder = new Label();
            Label ApplicationDeadlineHolder = new Label();
            Label DetailedDescriptionHolder = new Label();
            Label MinYearsExperienceHolder = new Label();
            Label SalaryHolder = new Label();
            Label ShortDescriptionHolder = new Label();
            Label VacanciesHolder = new Label();
            Label WorkingHoursHolder = new Label();
            //holder label attr
            JobTitleHolder.Text = "Job Title: ";
            JobTitleHolder.CssClass = "font-weight-bold";

            ApplicationDeadlineHolder.Text = "Applicaiton Deadline: ";
            ApplicationDeadlineHolder.CssClass = "font-weight-bold";

            DetailedDescriptionHolder.Text = "Detailed Description: ";
            DetailedDescriptionHolder.CssClass = "font-weight-bold";

            MinYearsExperienceHolder.Text = "Minimum Years of Experience: ";
            MinYearsExperienceHolder.CssClass = "font-weight-bold";

            SalaryHolder.Text = "Salary: ";
            SalaryHolder.CssClass = "card-text font-weight-bold";

            ShortDescriptionHolder.Text = "Short Description: ";
            ShortDescriptionHolder.CssClass = "font-weight-bold";

            VacanciesHolder.Text = "Vacancies: ";
            VacanciesHolder.CssClass = "font-weight-bold";

            WorkingHoursHolder.Text = "Working Hours: ";
            WorkingHoursHolder.CssClass = "font-weight-bold";
            //add job info labels
            Label JobTitleLabel = new Label();
            Label DepartmentCodeLabel = new Label();
            Label CompanyDomainLabel = new Label();
            Label ApplicationDeadlineLabel = new Label();
            Label DetailedDescriptionLabel = new Label();
            Label MinYearsExperienceLabel = new Label();
            Label SalaryLabel = new Label();
            Label ShortDescriptionLabel = new Label();
            Label VacanciesLabel = new Label();
            Label WorkingHoursLabel = new Label();

            //job info panels
            Panel JobTitlePanel = new Panel();
            Panel ApplicationDeadlinePanel = new Panel();
            Panel DetailedDescriptionPanel = new Panel();
            Panel MinYearsExperiencePanel = new Panel();
            Panel SalaryPanel = new Panel();
            Panel ShortDescriptionPanel = new Panel();
            Panel VacanciesPanel = new Panel();
            Panel WorkingHoursPanel = new Panel();
            //add panel styles
            JobTitlePanel.CssClass = "card-text";
            ApplicationDeadlinePanel.CssClass = "card-text";
            DetailedDescriptionPanel.CssClass = "card-text";
            MinYearsExperiencePanel.CssClass = "card-text";
            SalaryPanel.CssClass = "card-text";
            ShortDescriptionPanel.CssClass = "card-text";
            VacanciesPanel.CssClass = "card-text";
            WorkingHoursPanel.CssClass = "card-text";
            

            //add labels to correct panels
            JobTitlePanel.Controls.Add(JobTitleHolder);
            JobTitlePanel.Controls.Add(JobTitleLabel);


            ApplicationDeadlinePanel.Controls.Add(ApplicationDeadlineHolder);
            ApplicationDeadlinePanel.Controls.Add(ApplicationDeadlineLabel);

            DetailedDescriptionPanel.Controls.Add(DetailedDescriptionHolder);
            DetailedDescriptionPanel.Controls.Add(DetailedDescriptionLabel);

            MinYearsExperiencePanel.Controls.Add(MinYearsExperienceHolder);
            MinYearsExperiencePanel.Controls.Add(MinYearsExperienceLabel);

            SalaryPanel.Controls.Add(SalaryHolder);
            SalaryPanel.Controls.Add(SalaryLabel);

            ShortDescriptionPanel.Controls.Add(ShortDescriptionHolder);
            ShortDescriptionPanel.Controls.Add(ShortDescriptionLabel);

            VacanciesPanel.Controls.Add(VacanciesHolder);
            VacanciesPanel.Controls.Add(VacanciesLabel);

            WorkingHoursPanel.Controls.Add(WorkingHoursHolder);
            WorkingHoursPanel.Controls.Add(WorkingHoursLabel);

           

            //add main panels
            Panel CardBlockPanel = new Panel();
            
            //add main panels attr
            CardBlockPanel.CssClass = "card-block";

            //add sub-panels to main panel
            CardBlockPanel.Controls.Add(JobTitlePanel);
            CardBlockPanel.Controls.Add(ApplicationDeadlinePanel);
            CardBlockPanel.Controls.Add(DetailedDescriptionPanel);
            CardBlockPanel.Controls.Add(MinYearsExperiencePanel);
            CardBlockPanel.Controls.Add(SalaryPanel);
            CardBlockPanel.Controls.Add(ShortDescriptionPanel);
            CardBlockPanel.Controls.Add(VacanciesPanel);
            CardBlockPanel.Controls.Add(WorkingHoursPanel);
            CardPanel.Controls.Add(CardBlockPanel);

        }//end of while loop

        TargetPanel.Controls.Add(CardPanel);

       
    } //end of method 


    protected void searchCompaniesByName(Object sender, EventArgs e)
    {
        div_main.Controls.Clear();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmdname = new SqlCommand("SearchCompanyByNameSP", conn);
        cmdname.CommandType = System.Data.CommandType.StoredProcedure;
        string keyword = txt_search.Text;
        cmdname.Parameters.Add(new SqlParameter("@keyWord",keyword));
        conn.Open();
        SqlDataReader rdr = cmdname.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        while (rdr.Read())
        {
            string CompanyName = rdr.GetString(rdr.GetOrdinal("name"));
            string DomainName = rdr.GetString(rdr.GetOrdinal("domain_name"));
            string Address = rdr.GetString(rdr.GetOrdinal("address"));
            string Field = rdr.GetString(rdr.GetOrdinal("field"));
            string Type = rdr.GetString(rdr.GetOrdinal("type"));
            string Vision = rdr.GetString(rdr.GetOrdinal("vision"));
            string Email = rdr.GetString(rdr.GetOrdinal("email"));
            string Phone = rdr.GetString(rdr.GetOrdinal("phone"));



            //holder labels
            Label FieldHolder = new Label();
            Label TypeHolder = new Label();
            Label AddressHolder = new Label();
            Label EmailHolder = new Label();
            Label VisionHolder = new Label();
            Label CompanyDomainHolder = new Label();
            Label PhoneHolder = new Label();
            //holder labels attr
            FieldHolder.CssClass = "font-weight-bold";
            FieldHolder.Text = "Field: ";
            TypeHolder.CssClass = "font-weight-bold";
            TypeHolder.Text = "Type: ";
            AddressHolder.CssClass = "font-weight-bold";
            AddressHolder.Text = "Address: ";
            EmailHolder.CssClass = "font-weight-bold";
            EmailHolder.Text = "Email: ";
            VisionHolder.CssClass = "font-weight-bold";
            VisionHolder.Text = "Vision: ";
            CompanyDomainHolder.CssClass = "font-weight-bold";
            CompanyDomainHolder.Text = "Domain Name: ";
            PhoneHolder.CssClass = "font-weight-bold";
            PhoneHolder.Text = "Phone(s):";
            //company info labels
            Label CompanyDomainLabel = new Label();
            Label CompanyNameLabel = new Label();
            Label EmailLabel = new Label();
            Label TypeLabel = new Label();
            Label FieldLabel = new Label();
            Label VisionLabel = new Label();
            Label AddressLabel = new Label();
            Label PhoneLabel = new Label();
            //company info labels attr
            CompanyDomainLabel.Text = DomainName;
            CompanyNameLabel.Text = CompanyName;
            CompanyNameLabel.CssClass = " text-muted font-weight-bold";
            EmailLabel.Text = Email;
            TypeLabel.Text = Type;
            FieldLabel.Text = Field;
            VisionLabel.Text = Vision;
            AddressLabel.Text = Address;
            PhoneLabel.Text = Phone;
            //company info panels
            Panel CompanyNamePanel = new Panel();
            Panel CompanyDomainPanel = new Panel();
            Panel TypePanel = new Panel();
            Panel VisionPanel = new Panel();
            Panel EmailPanel = new Panel();
            Panel FieldPanel = new Panel();
            Panel AddressPanel = new Panel();
            Panel PhonePanel = new Panel();
            Panel CardBlockPanel = new Panel();
            Panel CardPanel = new Panel();
            //add action panel
            Panel ActionPanel = new Panel();
            //company info panels attr
            CompanyNamePanel.CssClass = "card-title";
            CompanyDomainPanel.CssClass = "card-text";
            TypePanel.CssClass = "card-text";
            VisionPanel.CssClass = "card-text";
            EmailPanel.CssClass = "card-text";
            FieldPanel.CssClass = "card-text";
            AddressPanel.CssClass = "card-text";
            PhonePanel.CssClass = "card-text";
            CardPanel.CssClass = "card";
            CardBlockPanel.CssClass = "card-block";
            //add action panel attr
            ActionPanel.CssClass = "card-block flex-row flex-wrap";

            //add sub panels to the main panel
            CompanyNamePanel.Controls.Add(CompanyNameLabel);
            CompanyDomainPanel.Controls.Add(CompanyDomainHolder);
            CompanyDomainPanel.Controls.Add(CompanyDomainLabel);
            EmailPanel.Controls.Add(EmailHolder);
            EmailPanel.Controls.Add(EmailLabel);
            VisionPanel.Controls.Add(VisionHolder);
            VisionPanel.Controls.Add(VisionLabel);
            TypePanel.Controls.Add(TypeHolder);
            TypePanel.Controls.Add(TypeLabel);
            FieldPanel.Controls.Add(FieldHolder);
            FieldPanel.Controls.Add(FieldLabel);
            AddressPanel.Controls.Add(AddressHolder);
            AddressPanel.Controls.Add(AddressLabel);
            PhonePanel.Controls.Add(PhoneHolder);
            PhonePanel.Controls.Add(PhoneLabel);
            CardBlockPanel.Controls.Add(CompanyNamePanel);
            CardBlockPanel.Controls.Add(FieldPanel);
            CardBlockPanel.Controls.Add(TypePanel);
            CardBlockPanel.Controls.Add(VisionPanel);
            CardBlockPanel.Controls.Add(CompanyDomainPanel);
            CardBlockPanel.Controls.Add(EmailPanel);
            CardBlockPanel.Controls.Add(AddressPanel);
            CardBlockPanel.Controls.Add(PhonePanel);
            CardBlockPanel.Controls.Add(ActionPanel);
            CardPanel.Controls.Add(CardBlockPanel);
            div_main.Controls.Add(CardPanel);





        }//End of While Loop
                                   

    }//End of Method







}