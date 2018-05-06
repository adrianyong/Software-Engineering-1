<%-- 
    Document   : goals
    Created on : 20-Apr-2018, 17:46:42
    Author     : Bento
--%>

<%@page import="model.Goal"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Goals</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class="container">
            <%
                //Redirect to login page if user session is invalid
                HttpSession httpSession = request.getSession();
                String email = (String) httpSession.getAttribute("email");
                String password = (String) httpSession.getAttribute("password");
                if(email == null){
                    response.sendRedirect("userLogin.jsp");
                }

                User user = PersistanceController.getUser(email, password);
                Goal goal = user.getGoal();
                String goalWeight = Double.toString(goal.getGoalWeight());
                String goalType = goal.getType().toString();
                String goalSpeed = goal.getGoalSpeed().toString();
            %>
            <div>
                <p>Goal Weight: <%=goalWeight%></p>
                <p>Goal Type: <%=goalType%></p>
                <p>Goal Speed: <%=goalSpeed%></p>
                <br>
            </div>
            <p><a href="profile.jsp" class="btn btn-info" role="button">Back</a></p>
        </div>
    </body>
</html>
