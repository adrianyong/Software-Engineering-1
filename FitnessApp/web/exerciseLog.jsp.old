<%-- 
    Document   : exerciseLog
    Created on : 20-Apr-2018, 17:46:17
    Author     : Bento
--%>

<%@page import="model.ActivityTemplate"%>
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
        <form class="form-inline" action="WebController">
            <input type="hidden" name="formType" value="activity">
            <div>
            <p>
                <label for="duration">Duration</label>
                <input type="number" class="form-control" id="duration" value="" name="duration" required> minutes
            </p>
            <p>
                <label for="activity">Activity</label>
                <select name="activity">
                    <%for(ActivityTemplate at : Activity.getActivityList()){
                        String name = at.getActivityName();
                    %>
                        <option value="<%=name%>"><%=name%></option>
                    <%}%>
                </select>
            </p>
            <p> <button type="submit" class="btn btn-primary">Submit</button> </p>
            </div>
        </form>
        <%
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            String password = (String) httpSession.getAttribute("password");
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            User user = PersistanceController.getUser(email, password);

            for(Activity a: user.getActivityLog()){
                String output = a.toString();%>
                <div><p><%=output%></p></div>
                <%
            }
        %>
        <p><a href="profile.jsp" class="btn btn-info" role="button">Back</a></p>
    </body>
</html>
