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

        protected void staff(object sender, EventArgs e)
    {
        Session["Username"] = Session["Username"].ToString();
        Session["Type"] = Session["Type"].ToString();
        Response.Redirect("Staff", true);
    }
 
 //------------------------------------------------------------------------------------------------------------------



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

//------------------------------------------------------------------------------------------------------------------------------------------------
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

    protected void viewProjects(object sender, EventArgs e)
    {
        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewProjectsOfEmployeeSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        while (rdr.Read())
        {

            string ProjectName = rdr.GetString(rdr.GetOrdinal("project_name"));
            string ManagerUserName = rdr.GetString(rdr.GetOrdinal("manager_user_name"));
            string StartDate = rdr.GetValue(rdr.GetOrdinal("start_date")).ToString();
            string EndDate = rdr.GetValue(rdr.GetOrdinal("end_date")).ToString();


            string ProjectInfo = "<div class = \"card-block\">"
    + "<div class = \"card-text\"><span class = \"font-weight-bold\">Project: </span>" + ProjectName + "</div>"
    + "<div class = \"card-text\"><span class = \"font-weight-bold\">Manager's Username: </span>" + ManagerUserName + "</div>"
    + "<div class = \"card-text\"><span class = \"font-weight-bold\">Start Date: </span>" + StartDate + "</div>"
    + "<div class = \"card-text\"><span class = \"font-weight-bold\">End Date: </span>" + EndDate + "</div>"
    + "</div>";

          

            viewproject_panel.Controls.Add(new LiteralControl(ProjectInfo));


        }//end of while loop

    }//end of method 

    //--------------------------------------------------------------------------------------------------------------------------------------------------

    // View a list of tasks in a certain project assigned to him/her along with all of their information and status.

    protected void viewTasks(object sender, EventArgs e)
    {

        string Username = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewTasksInProjectSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;                      
        cmd.Parameters.Add(new SqlParameter("@userName", Username));
        string projectname = proj_name.Text;
        cmd.Parameters.Add(new SqlParameter("@projectName", projectname));
        //output parameterssub
        SqlParameter OperationStatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Bit);
        OperationStatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        string op= OperationStatus.Value.ToString();
        conn.Close();
        conn.Open();
        Label noTasks = new Label();
        noTasks.Text = "You have no tasks in this Project.";
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        switch (op)
        {
            case "False":
                tasks_response.Controls.Add(noTasks);
                break;
            case "True":


                while (rdr.Read())
                {

            
                    string TaskName = rdr.GetString(rdr.GetOrdinal("name"));
                    string Description = rdr.GetString(rdr.GetOrdinal("description"));
                    string Comments = rdr.GetString(rdr.GetOrdinal("comments"));
                    string Status = rdr.GetString(rdr.GetOrdinal("status"));
                    string Deadline= rdr.GetValue(rdr.GetOrdinal("deadline")).ToString();


                    string TasksInfo = "<div class = \"card-block\">"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Task Name: </span>" + TaskName + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Description: </span>" + Description + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Comments: </span>" + Comments + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Status: </span>" + Status + "</div>"
            + "<div class = \"card-text\"><span class = \"font-weight-bold\">Deadline: </span>" + Deadline + "</div>"
            + "</div>";



                    viewtasks_panel.Controls.Add(new LiteralControl(TasksInfo));





                }//end of while loop


                break;
        }

    }//end of method

//---------------------------------------------------------------------------------------------------------------------------------------------------



    }