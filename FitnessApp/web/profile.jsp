<%-- 
    Document   : profile
    Created on : 22-Mar-2018, 18:30:07
    Author     : 100021268
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class="container">
            <br>
            <%
            String messageType = (String)request.getAttribute("messageType");
            String message = (String)request.getAttribute("message"); 
            String name = (String)request.getAttribute("firstName"); 
            if(message!=null){
                String messageCSS = "alert";
                switch(messageType){
                case "Success":
                    messageCSS = "alert alert-success";
                    break;
                case "Error":
                    messageCSS = "alert alert-danger";
                    break;
                }            
                %>
                <div class="<%= messageCSS%>">
                    <strong><%= messageType%>!</strong> <%= message%>
                </div>
                <p> Welcome, <%= name%>! </p>
            <%}%>
            <p><a href="profile.jsp" class="btn btn-info" role="button">Home</a></p>
            <p><a href="exerciseLog.jsp" class="btn btn-info" role="button">Exercise Log</a></p>
            <p><a href="foodLog.jsp" class="btn btn-info" role="button">Food Log</a></p>
            <p><a href="updateWeight.jsp" class="btn btn-info" role="button">Weight Log</a></p>
            <p><a href="goals.jsp" class="btn btn-info" role="button">Goals</a></p>
        </div>
    </body>
</html>
