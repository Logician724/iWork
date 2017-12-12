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



public partial class InterviewQuestions : System.Web.UI.Page
{

    public static int score;
    protected void Page_Load(object sender, EventArgs e)
    {
        viewQuestions(sender, e);
    }


    //while applying for the job, the job seeker views the interview questions related to the job he/she is
    //applying for. Once he/she provides answers for all questions, the score is then calculated, displayed
    //and saved in the database.

    /* GO
 CREATE PROC ViewQuetionsInInterviewSP
 @jobTitle VARCHAR(150),
 @departmentCode VARCHAR(30),
 @companyDomain VARCHAR(150)
 AS
 SELECT q.question_title,q.question_id
 FROM Questions q INNER JOIN Jobs_Have_Questions jq
 ON jq.question_id = q.question_id
 WHERE (jq.job_title = @jobTitle AND jq.department_code = @departmentCode AND jq.company_domain = @companyDomain) */


    protected void viewQuestions(object sender, EventArgs e)
    {
        string CompanyDomain = Session["CompanyDomain"].ToString();
        string DepartmentCode = Session["DepartmentCode"].ToString();
        string JobTitle = Session["JobTitle"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ViewQuetionsInInterviewSP", conn);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@jobTitle", JobTitle));
        cmd.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
        cmd.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        int counter = 0;
        String labelQues = "";

        while (rdr.Read())
        {
            counter++;
            labelQues = "Question " + counter;
            string QuestionTitle = rdr.GetString(rdr.GetOrdinal("question_title"));


            string Questions = "<div class = \"card-block\">"
+ "<div class = \"card-text\"><span class = \"font-weight-bold\">" + labelQues + " </span>" + QuestionTitle + "</div>"
+ "</div>";

            TextBox answer = new TextBox();
            answer.Visible = true;
            //answer.ID = counter.ToString();
            answer.ID = rdr.GetValue(rdr.GetOrdinal("answer")).ToString() + counter.ToString();
            questions_panel.Controls.Add(new LiteralControl(Questions));
            questions_panel.Controls.Add(answer);
            Console.Write("Hi");
            System.Diagnostics.Debug.WriteLine(answer.ID);


        }
    }

    protected void ApplyForJob(object sender, EventArgs e)
    {
        foreach (Control c in questions_panel.Controls)
        {
            if (c is TextBox)
            {
                TextBox textBox = (TextBox)c;
                if ((textBox.Text == "Yes" && c.ID[0] == 'T') || (textBox.Text == "No" && c.ID[0] == 'F'))
                    score += 10;
            }
        }
        string Score = score + "";
        string SeekerUsername = Session["Username"].ToString();
        string CompanyDomain = Session["CompanyDomain"].ToString();
        string DepartmentCode = Session["DepartmentCode"].ToString();
        string JobTitle = Session["JobTitle"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iWorkDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("ApplyForJobSP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@seekerUserName", SeekerUsername));
        cmd.Parameters.Add(new SqlParameter("@companyDomain", CompanyDomain));
        cmd.Parameters.Add(new SqlParameter("@departmentCode", DepartmentCode));
        cmd.Parameters.Add(new SqlParameter("@jobTitle", JobTitle));
        cmd.Parameters.Add(new SqlParameter("@score", Score));
        //output parameters
        SqlParameter operationstatus = cmd.Parameters.Add("@operationStatus", SqlDbType.Int);
        operationstatus.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Label failed1 = new Label();
        failed1.Text = "You already have a pending application for this job.";
        Label failed2 = new Label();
        failed2.Text = "You don't have enough experience years for this job";
        Label passed = new Label();
        passed.Text = "Successfully Applied!";
        switch (operationstatus.Value.ToString())
        {
            case "1":
                apply_response.Controls.Add(failed1);
                break;
            case "2":
                apply_response.Controls.Add(failed2);
                break;
            case "3":
                apply_response.Controls.Add(passed);
                Response.Redirect("JobSeekerProfile", true);
                break;
        }
    }
}
