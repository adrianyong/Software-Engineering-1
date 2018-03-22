<%-- 
    Document   : register
    Created on : 22-Mar-2018, 17:39:20
    Author     : 100021268
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class="container">
            <h2>Register</h2>
            <p>Make the viewport larger than 576px wide to see that all of the form elements are inline and left-aligned. On small screens, the form groups will stack horizontally.</p>
            <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="register">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" placeholder="Enter password" name="password">
                <label for="firstName">First Name: </label>
                <input type="input" class="form-control" id="firstName" placeholder="Enter first name" name="firstName">
                <label for="lastName">Last Name: </label>
                <input type="input" class="form-control" id="lastName" placeholder="Enter last name" name="lastName">
                <div class="form-check">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <p><a href="index.jsp" class="btn btn-info" role="button">Back Home dawg</a></p>
            
            <p><a href="userLogin.jsp" class="btn btn-info" role="button">Back to User Login</a></p>
        </div>
</html>
