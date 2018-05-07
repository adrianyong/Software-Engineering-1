<%-- 
    Document   : exerciseLog
    Created on : 20-Apr-2018, 17:46:17
    Author     : Bento
--%>

<%@page import="model.Activity"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            String password = (String) httpSession.getAttribute("password");
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            User user = PersistanceController.getUser(email, password);
            user.addActivity("Weight Lifting: general", 11);
            user.addActivity("Aerobics: water", 10);
            for(Activity a: user.getActivityLog()){
                String output = a.toString();%>
                <p><%=output%></p>
                <%
            }
        %>
    </body>
</html>
