<%-- 
    Document   : index
    Created on : 10-Mar-2018, 10:45:13
    Author     : Bento
--%>

<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<html>
    <head>
    <title>Home</title>   
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class="jumbotron text-center bg-success">
        <h1>Front page</h1>
        <p>test front page</p> 
        </div>

        <div class="container">
          <div class="row">
            <div class="col-sm-4">
              <h3>Login stuff</h3>
              <p><a href="userLogin.jsp" class="btn btn-info" role="button">Click here</a></p>
            </div>
            <div class="col-sm-4">
              <h3>View Users</h3>
              <p><a href="viewUsers.jsp" class="btn btn-info" role="button">View Users</a></p>
              
            </div>
            <div class="col-sm-4">
              <h3>Log data</h3>        
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
            </div>
          </div>
        </div>

    </body>
</html> 
