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
            System.out.println("attempting test");
            InputStream inputStream = application.getResourceAsStream("WEB-INF/userdata.json");
            System.out.println("test result");
            System.out.println(inputStream.available());
            Reader reader = null;
            reader = new InputStreamReader(inputStream, "UTF-8");
            System.out.println(reader.toString());
            List<User> users = PersistanceController.loadUsers();
            for(User u : users){%>
                <p> <%= u.toString()%> </p>
          <%}
        %>
        <p><a href="index.jsp" class="btn btn-info" role="button">Back Home dawg</a></p>
    </body>
</html>
