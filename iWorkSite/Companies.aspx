<%@ page language="C#" autoeventwireup="true" maintainscrollpositiononpostback="true" codefile="Companies.aspx.cs" inherits="Companies" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/companies.css" />
    <script src="jquery-3.2.1.js"></script>
    <script src="bootstrap.js"></script>
    <title>Home</title>
</head>
<body class="jumbotron">
    <div class="container text-center">
        <div class="display-1">iWork</div>
        <p class="lead">We lighten your path</p>
    </div>
    <div class="container">
        <form runat="server">
            <div class="form-group" runat="server">
                <div class="row ">
                    <div class="col-7 offset-1">
                        <asp:TextBox CssClass="form-control" ID="txt_search" runat="server" placeholder="Search"></asp:TextBox>
                    </div>
                    <div class="col-2">
                        <asp:Button CssClass="btn btn-primary" ID="start_search" runat="server" Text="Search by company" OnClick="SearchCompany"/>
                    </div>
                    <div class="col-2">
                        <asp:Button CssClass="btn btn-primary" ID="btn_view_jobs" runat="server" Text="Search by job" OnClick="searchJob" />
                    </div>
                </div>
                <div class="row ml-2">
                    <p class="lead ">Search for company by: </p>
                </div>
                <div class="row">
                    <label class="custom-control custom-radio col-2 offset-1">
                        <input value="radio_search_name" name="radio_search_company" type="radio" class="custom-control-input" runat="server"/>
                        <span class="custom-control-indicator"></span>
                        <span class="custom-control-description">Name</span>
                    </label>
                    <label class="custom-control custom-radio col-2">
                        <input value="radio_search_address" name="radio_search_company" type="radio" class="custom-control-input" runat="server"/>
                        <span class="custom-control-indicator"></span>
                        <span class="custom-control-description">Address</span>
                    </label>
                    <label class="custom-control custom-radio col-2">
                        <input value="radio_search_type" name="radio_search_company" type="radio" class="custom-control-input" runat="server"/>
                        <span class="custom-control-indicator"></span>
                        <span class="custom-control-description">Type</span>
                    </label>
                    <label class="custom-control custom-radio col-2">
                        <input value="radio_search_avg_salary" name="radio_search_company" type="radio" class="custom-control-input" runat="server"/>
                        <span class="custom-control-indicator"></span>
                        <span class="custom-control-description">Average Salary</span>
                    </label>
                </div>
            </div>
            <div id="div_main" runat ="server"></div>
        </form>

    </div>
</body>
</html>
