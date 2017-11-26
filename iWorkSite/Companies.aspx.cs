using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
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
            //company info labels
            Label CompanyDomainLabel = new Label();
            Label CompanyNameLabel = new Label();
            Label EmailLabel = new Label();
            Label TypeLabel = new Label();
            Label FieldLabel = new Label();
            Label VisionLabel = new Label();
            Label AddressLabel = new Label();
            //company info labels attr
            CompanyDomainLabel.Text = DomainName;
            CompanyNameLabel.Text = CompanyName;
            CompanyNameLabel.CssClass = " text-muted font-weight-bold";
            EmailLabel.Text = Email;
            TypeLabel.Text = Type;
            FieldLabel.Text = Field;
            VisionLabel.Text = Vision;
            AddressLabel.Text = Address;
            //company info panels
            Panel CompanyNamePanel = new Panel();
            Panel CompanyDomainPanel = new Panel();
            Panel TypePanel = new Panel();
            Panel VisionPanel = new Panel();
            Panel EmailPanel = new Panel();
            Panel FieldPanel = new Panel();
            Panel AddressPanel = new Panel();
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
            ActionPanel.Controls.Add(DepartmentButton);
            CardBlockPanel.Controls.Add(CompanyNamePanel);
            CardBlockPanel.Controls.Add(FieldPanel);
            CardBlockPanel.Controls.Add(TypePanel);
            CardBlockPanel.Controls.Add(VisionPanel);
            CardBlockPanel.Controls.Add(CompanyDomainPanel);
            CardBlockPanel.Controls.Add(EmailPanel);
            CardBlockPanel.Controls.Add(AddressPanel);
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
        while (rdr.Read())
        {
            string DepartmentName = rdr.GetString(rdr.GetOrdinal("name"));
            string DepartmentCode = rdr.GetString(rdr.GetOrdinal("department_code"));
            //holder labels
            Label DepartmentNameHolder = new Label();
            Label DepartmentCodeHolder = new Label();
            //holder label attr
            DepartmentNameHolder.Text = "Deaprtment Name: ";
            DepartmentNameHolder.CssClass = "card-text font-weight-bold";
            DepartmentCodeHolder.Text = "Department Code: ";
            DepartmentCodeHolder.CssClass = "card-text font-weight-bold";
            //department info labels
            Label DepartmentNameLabel = new Label();
            Label DepartmentCodeLabel = new Label();
            //department info label attributes
            DepartmentNameLabel.Text = DepartmentName;
            DepartmentNameLabel.CssClass = "card-text";
            DepartmentCodeLabel.Text = DepartmentCode;
            DepartmentCodeLabel.CssClass = "card-text";
            //department info panels
            Panel DepartmentNamePanel = new Panel();
            Panel DepartmentCodePanel = new Panel();
            //add labels to correct panels
            DepartmentNamePanel.Controls.Add(DepartmentNameHolder);
            DepartmentNamePanel.Controls.Add(DepartmentNameLabel);
            DepartmentCodePanel.Controls.Add(DepartmentCodeHolder);
            DepartmentCodePanel.Controls.Add(DepartmentCodeLabel);
            //add main panels
            Panel CardBlockPanel = new Panel();
            
            //add main panels attr
            CardBlockPanel.CssClass = "card-block";
            CardPanel.CssClass = "card";
            //add sub-panels to main panel
            CardBlockPanel.Controls.Add(DepartmentNamePanel);
            CardBlockPanel.Controls.Add(DepartmentCodePanel);
            CardPanel.Controls.Add(CardBlockPanel);
        }
        TargetPanel.Controls.Add(CardPanel);



    }
}