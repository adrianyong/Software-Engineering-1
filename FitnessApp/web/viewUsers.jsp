<%-- 
    Document   : viewUsers
    Created on : 03-Apr-2018, 16:06:22
    Author     : 100021268
--%>

<%@page import="java.io.Reader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="org.apache.tomcat.util.http.fileupload.IOUtils"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.io.InputStream"%>
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
            try {
                List<User> users = PersistanceController.loadUsers();
                for(User u : users){%>
                <p> <%= u.toString()%> </p>
            <%}
            }catch (Exception ex) { %>
                <p>No users found</p>
            <%}
        %>
        <p><a href="index.jsp" class="btn btn-info" role="button">Back Home</a></p>
    </body>
</html>
