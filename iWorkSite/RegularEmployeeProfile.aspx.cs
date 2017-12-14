using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class RegularEmployeeProfile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
        {
            Response.Redirect("login");
        }
        else
        {
            ViewPersonalInfo(sender, e);
            ViewInfoEdit(sender, e);
            ViewProjects(sender, e);
        }
    }

    protected void ViewPersonalInfo(object sender, EventArgs e)
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
    protected void ViewInfoEdit(object sender, EventArgs e)
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
            txt_password.Attributes.Add("placeholder", "**********");
            txt_personalemail.Attributes.Add("placeholder", PersonalEmail);
            txt_birthdate.Attributes.Add("placeholder", Birthdate);
            txt_expyrs.Attributes.Add("placeholder", ExpYear);
            txt_fn.Attributes.Add("placeholder", FirstName);
            txt_ln.Attributes.Add("placeholder", LastName);
        }
    }

    //------------------------------------------------------------------------------------------------------------------------------------------------
    protected void editPersonalInfo(object sender, EventArgs e)
    {
        //initialize database command
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("EditPersonalInfoSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        //get textbox inputs
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

        if (password == "")
            password = null;
        if (personalemail == "")
            personalemail = null;
        if (birthdate == "")
            birthdate = null;
        if (firstname == "")
            firstname = null;
        if (lastname == "")
            lastname = null;


        cmd.Parameters.Add(new SqlParameter("@password", password));
        cmd.Parameters.Add(new SqlParameter("@personalEmail", personalemail));
        cmd.Parameters.Add(new SqlParameter("@birthDate", birthdate));
        cmd.Parameters.Add(new SqlParameter("@expYear", expyear));
        cmd.Parameters.Add(new SqlParameter("@firstname", firstname));
        cmd.Parameters.Add(new SqlParameter("@lastname", lastname));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);


    }

    //-----------------------------------------------------------------------------------------------------------------------------------
    // View a list of projects assigned to him/her along with all of their information.

    protected void ViewProjects(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewProjectsOfEmployeeSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        if (!rdr.HasRows)
        {
            Label NoProjectsLabel = new Label();
            NoProjectsLabel.Text = "You are not associated with any projects at the moment";
            project_response.Controls.Clear();
            project_response.Controls.Add(NoProjectsLabel);
        }
        else
        {
            int ProjectCounter = 0;
            while (rdr.Read())
            {
                string ProjectName = rdr.GetString(rdr.GetOrdinal("project_name"));
                string ManagerUserName = rdr.GetString(rdr.GetOrdinal("manager_user_name"));
                string StartDate = rdr.GetValue(rdr.GetOrdinal("start_date")).ToString().Split(null)[0];
                string EndDate = rdr.GetValue(rdr.GetOrdinal("end_date")).ToString().Split(null)[0];
                string ProjectInfoBuild =
                    "<div>\r\n" +
        "<div class=\"mt-3 row\">\r\n" +
            "                            <div class=\"offset-1 col-10 display-4 Capitalize\">" + ProjectName + "</div>\r\n" +
            "                        </div>\r\n" +
            "                        <div class=\"mt-2 lead offset-1\">\r\n" +
            "                            <p>Manger:  " + ManagerUserName + "</p>\r\n" +
            "                        </div>\r\n" +
            "                            <div class=\"row mt-4 mb-3\">\r\n" +
            "                              <div class=\"offset-2 col-5 font-weight-bold font-italic\">Start Date</div>\r\n" +
            "                              <div class=\"col-5 font-weight-bold font-italic\">End Date</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-2 row\">\r\n" +
            "                              <div class=\"offset-2 col-5\">" + StartDate + "</div>\r\n" +
            "                              <div class=\"col-5\">" + EndDate + "</div>\r\n" +
            "                            </div>\r\n";
                Panel TaskLinkPanel = new Panel();
                TaskLinkPanel.CssClass = "text-center";
                HyperLink TaskLink = new HyperLink();
                TaskLink.Text = "View Tasks";
                TaskLink.CssClass = "btn btn-primary";
                TaskLink.Attributes["data-toggle"] = "collapse";
                TaskLink.Attributes["href"] = "#project_" + ProjectCounter;
                TaskLinkPanel.Controls.Add(TaskLink);
                viewproject_panel.Controls.Add(new LiteralControl(ProjectInfoBuild));
                viewproject_panel.Controls.Add(TaskLinkPanel);
                ViewTasks(sender, e, ProjectName, ProjectCounter);
                viewproject_panel.Controls.Add(new LiteralControl("<hr /></div>"));
                ProjectCounter++;
            }//end of while loop
        }//end of if statement
    }//end of method 
    // View a list of tasks in a certain project assigned to him/her along with all of their information and status.
    protected void ViewTasks(object sender, EventArgs e, string ProjectName, int Count)
    {

        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewTasksInProjectSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));

        cmd.Parameters.Add(new SqlParameter("@projectName", ProjectName));
        //output parameterssub
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        string op = OperationStatus.Value.ToString();
        conn.Close();
        conn.Open();


        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        Label Failed = new Label();
        Failed.Text = "You have no tasks yet in this project.";

        switch (op)
        {

            case "False":
                viewtasks_response.Controls.Add(Failed);
                break;

            case "True":
                while (rdr.Read())
                {


                    string TaskName = rdr.GetString(rdr.GetOrdinal("name"));
                    string Description = rdr.GetString(rdr.GetOrdinal("description"));
                    string Comments = rdr.GetString(rdr.GetOrdinal("comments"));
                    string Status = rdr.GetString(rdr.GetOrdinal("status"));
                    string Deadline = rdr.GetValue(rdr.GetOrdinal("deadline")).ToString();


                    string TasksInfo = "<div class=\"collapse\" id=\"project_" + Count + "\"" + " > " +
                        "<div class = \"card-block\">"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Task Name: </span>" + TaskName + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Description: </span>" + Description + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Comments: </span>" + Comments + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Status: </span>" + Status + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Deadline: </span>" + Deadline + "</div>"
            + "</div>";
                    string TaskInfoBuild = "<div class=\"collapse\" id=\"project_" + Count + "\"" + " > " +
                        "<div class=\"mt-3 row\">\r\n" +
            "                            <div class=\"offset-1 col-10 display-4 Capitalize\">" + TaskName + "</div>\r\n" +
            "                        </div>\r\n" +
            "                        <div class=\"mt-2 lead offset-1\">\r\n" +
            "                            <p>" + Description + "</p>\r\n" +
            "                        </div>\r\n" +
            "                            <div class=\"row mt-4 mb-3\">\r\n" +
            "                              <div class=\"offset-2 col-5 font-weight-bold font-italic\">Status</div>\r\n" +
            "                              <div class=\"col-5 font-weight-bold font-italic\">Deadline</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-2 row\">\r\n" +
            "                              <div class=\"offset-2 col-5\">" + Status + "</div>\r\n" +
            "                              <div class=\"col-5\">" + Deadline + "</div>\r\n" +
            "                            </div>\r\n" +
            "                            <div class=\"mt-3 row\">\r\n" +
            "                              <div class=\" offset-2 col-5 font-weight-bold\">Comments</div>\r\n</div>\r\n" +
            "                            <div class=\"mt-1 mb-3 row\">\r\n" +
            "                               <div class=\"offset-2 col-5\">" + Comments + "</div>\r\n</div>\r\n";

                    Panel ChangeStatusAssigned = new Panel();
                    Panel ChangeStatusFixed = new Panel();
                    ChangeStatusAssigned.CssClass = "text-center";
                    ChangeStatusFixed.CssClass = "text-center";
                    if (Status == "Fixed")
                    {

                        Button toAssignedButton = new Button();
                        toAssignedButton.Text = "Change Status to Assigned";
                        toAssignedButton.CssClass = "text-center btn btn-primary";
                        toAssignedButton.Click += new EventHandler((sender_assigned, e_assigned) => changeTasksToAssigned(sender_assigned, e_assigned, Username, TaskName, ProjectName, Deadline));
                        ChangeStatusAssigned.Controls.Add(toAssignedButton);
                    }
                    else
                    if (Status == "Assigned")
                    {
                        Button toFixedButton = new Button();
                        toFixedButton.Text = "Change Status to Fixed";
                        toFixedButton.CssClass = "btn btn-primary";
                        toFixedButton.Click += new EventHandler((sender_fixed, e_fixed) => changeTasksToFixed(sender_fixed, e_fixed, Username, TaskName, ProjectName, Deadline));
                        ChangeStatusFixed.Controls.Add(toFixedButton);
                    }
                    viewproject_panel.Controls.Add(new LiteralControl(TaskInfoBuild));
                    viewproject_panel.Controls.Add(ChangeStatusFixed);
                    viewproject_panel.Controls.Add(ChangeStatusAssigned);
                    viewproject_panel.Controls.Add(new LiteralControl("</div>"));
                }//end of while loop
                break;
        }
    }//end of method


    //---------------------------------------------------------------------------------------------------------------------------------------------------


    protected void changeTasksToAssigned(object sender, EventArgs e, string Username, string TaskName, string ProjectName, string Deadline)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ChangeTaskStatusSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        cmd.Parameters.Add(new SqlParameter("@taskName", TaskName));
        cmd.Parameters.Add(new SqlParameter("@projectName", ProjectName));
        cmd.Parameters.Add(new SqlParameter("@deadline", Deadline));
        //output parameters
        SqlParameter op = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        op.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Label failed = new Label();
        failed.Text = "Deadline Passed";

        Label Changed = new Label();
        Changed.Text = "Status Changed";
        switch (op.Value.ToString())
        {
            case "False":
                viewproject_panel.Controls.Add(failed);
                break;

            case "True":
                viewproject_panel.Controls.Add(Changed);
                break;
        }

    }

    protected void changeTasksToFixed(object sender, EventArgs e, string Username, string TaskName, string ProjectName, string Deadline)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("FinalizeTaskSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        cmd.Parameters.Add(new SqlParameter("@taskName", TaskName));
        cmd.Parameters.Add(new SqlParameter("@projectName", ProjectName));
        cmd.Parameters.Add(new SqlParameter("@deadline", Deadline));

        //output parameters
        SqlParameter op = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        op.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Label failed = new Label();
        failed.Text = "Deadline Passed";

        Label Changed = new Label();
        Changed.Text = "Status Changed";
        switch (op.Value.ToString())
        {
            case "False":
                viewproject_panel.Controls.Add(failed);
                break;
            case "True":
                viewproject_panel.Controls.Add(Changed);
                break;
        }
    }
    protected void SignOut(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("companies");
    }
}