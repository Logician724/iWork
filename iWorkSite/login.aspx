<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iWork Login</title>
    <link rel="stylesheet" type="text/css" href="css/login.css"/>
</head>
<body>
    
<form runat ="server">
  <div class="imgcontainer">
    <img src="" alt="logo" class="logo" />
  </div>

  <div class="container">
    <label>Username</label>
    <input type="text" placeholder="Enter Username" name="uname" required="" />
    <label>Password</label>
    <input type="password" placeholder="Enter Password" name="psw" required="" />
    <button  type="submit">Login</button>
  </div>
</form>

</body>
</html>
