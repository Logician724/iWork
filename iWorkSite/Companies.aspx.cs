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
            Panel CompanyNamePanel = new Panel();
            CompanyNamePanel.CssClass = "card-title";
            Label CompanyNameLabel = new Label();
            CompanyNameLabel.Text = CompanyName;
            CompanyNameLabel.CssClass = " text-muted font-weight-bold";
            Panel CompanyDomainPanel = new Panel();
            CompanyDomainPanel.CssClass = "card-text";
            Label CompanyDomainLabel = new Label();
            CompanyDomainLabel.Text = DomainName;
            Label CompanyDomainHolder = new Label();
            CompanyDomainHolder.CssClass = "font-weight-bold";
            CompanyDomainHolder.Text = "Domain Name: ";
            Panel EmailPanel = new Panel();

            Label EmailLabel = new Label();
            EmailLabel.Text = Email;
            EmailLabel.CssClass = "card-text";
            Label EmailHolder = new Label();
            EmailHolder.CssClass = "font-weight-bold";
            EmailHolder.Text = "Email: ";
            Panel VisionPanel = new Panel();

            Label VisionLabel = new Label();
            VisionLabel.Text = Vision;
            VisionLabel.CssClass = "card-text";
            Label VisionHolder = new Label();
            VisionHolder.CssClass = "font-weight-bold";
            VisionHolder.Text = "Vision: ";
            Panel TypePanel = new Panel();
            Label TypeLabel = new Label();
            TypeLabel.Text = Type;
            TypeLabel.CssClass = "card-text";
            Label TypeHolder = new Label();
            TypeHolder.CssClass = "font-weight-bold";
            TypeHolder.Text = "Type: ";
            Panel FieldPanel = new Panel();
            Label FieldLabel = new Label();
            FieldLabel.Text = Field;
            FieldLabel.CssClass = "card-text";
            Label FieldHolder = new Label();
            FieldHolder.CssClass = "font-weight-bold";
            FieldHolder.Text = "Field: ";
            Panel AddressPanel = new Panel();
            Label AddressLabel = new Label();
            AddressLabel.Text = Address;
            AddressLabel.CssClass = "card-text";
            Label AddressHolder = new Label();
            AddressHolder.CssClass = "font-weight-bold";
            AddressHolder.Text = "Address: ";
            Panel CardPanel = new Panel();
            CardPanel.CssClass = "card";
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
            Panel CardBlockPanel = new Panel();
            CardBlockPanel.CssClass = "card-block";
            CardBlockPanel.Controls.Add(CompanyNamePanel);
            CardBlockPanel.Controls.Add(FieldPanel);
            CardBlockPanel.Controls.Add(TypePanel);
            CardBlockPanel.Controls.Add(VisionPanel);
            CardBlockPanel.Controls.Add(CompanyDomainPanel);
            CardBlockPanel.Controls.Add(EmailPanel);
            CardBlockPanel.Controls.Add(AddressPanel);
            CardPanel.Controls.Add(CardBlockPanel);
            div_main.Controls.Add(CardPanel);
        }
    }
}