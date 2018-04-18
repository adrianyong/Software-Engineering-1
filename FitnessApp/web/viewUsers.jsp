<%-- 
    Document   : viewUsers
    Created on : 03-Apr-2018, 16:06:22
    Author     : 100021268
--%>

<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Users</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <%
            List<User> users = PersistanceController.loadUsers();
            for(User u : users){%>
                <p> <%= u.toString()%> </p>
          <%}
        %>
        <p><a href="index.jsp" class="btn btn-info" role="button">Back Home dawg</a></p>
    </body>
</html>
