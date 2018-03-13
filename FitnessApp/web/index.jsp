<%-- 
    Document   : index
    Created on : 10-Mar-2018, 10:45:13
    Author     : Bento
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<html>
    <head>
    <title>Example</title>
    </head>
    <body>
        <h4>Click here to go to <a href="WebController">Page</a></h4>
        <%
            String redirectURL = "WebController";
            response.sendRedirect(redirectURL);
        %>
    </body>
</html> 
