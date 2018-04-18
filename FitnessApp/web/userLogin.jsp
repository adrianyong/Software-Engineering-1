<%-- 
    Document   : userLogin
    Created on : 22-Mar-2018, 17:08:57
    Author     : 100021268
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class="container">
            <h2>Login</h2>
            <p>Make the viewport larger than 576px wide to see that all of the form elements are inline and left-aligned. On small screens, the form groups will stack horizontally.</p>
            <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="login">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
                <label for="pwd">Password:</label>
                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pswd">
                <div class="form-check">
                <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" name="remember"> Remember me
                </label>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <p><a href="index.jsp" class="btn btn-info" role="button">Back Home</a></p>
            
            <p><a href="register.jsp" class="btn btn-info" role="button">Register New User</a></p>
        </div>
    </body>
</html>