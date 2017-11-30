<%@ page language="C#" autoeventwireup="true" maintainscrollpositiononpostback="true" codefile="Companies.aspx.cs" inherits="Companies" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/companies.css" />
    <title>Home</title>
</head>
<body>

    <div class="main-container center-container">


        <form class="container" runat="server">
            <asp:TextBox CssClass="txtbox input-lg" ID="txt_search" runat="server" placeholder="Search"></asp:TextBox>
            <asp:Button CssClass="button btn btn-success" ID="btn_search_byname" runat="server" Text="By Company Name" OnClick="searchCompaniesByName" />
            <asp:Button CssClass="button btn btn-success" ID="btn_search_byaddress" runat="server" Text="By Company Address" OnClick="searchCompaniesByAddress" />
            <asp:Button CssClass="button btn btn-success" ID="btn_search_bytype" runat="server" Text="By Company Type" OnClick="searchCompaniesByType" />
            <asp:Button CssClass="button btn btn-success" ID="btn_view_avg_sal" runat="server" Text="Categorize Companies By Avg Salaries" OnClick="viewCompaniesByAvgSalary" />
            <asp:Button CssClass="button btn btn-success" ID="btn_view_jobs" runat="server" Text="Search for job" OnClick="searchJob" />
            <div id="div_main" runat="server"></div>
        </form>

    </div>
</body>
</html>
