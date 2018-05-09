<%-- 
    Document   : goals
    Created on : 20-Apr-2018, 17:46:42
    Author     : Bento
--%>

<%@page import="model.Conversions"%>
<%@page import="model.Goal"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Goals</title>
<!--        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
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
                double goalWeightDouble = user.getGoal().getGoalWeight();
                String goalWeight = "";
                String goalWeight2 = "";
                String goalType = goal.getType().toString();
                String goalSpeed = goal.getGoalSpeed().toString();
                
                String weightUnit = user.getWeightUnit().toString();
                
                if("kg".equals(weightUnit)){
                    goalWeight = Double.toString(goalWeightDouble);
                }
                else if("pound".equals(weightUnit)){
                    goalWeight = Double.toString(Conversions.weightKgToPounds(goalWeightDouble));
                }
                else if("stonePound".equals(weightUnit)){
                    goalWeight = Double.toString((int) Conversions.weightKgToStonePart(goalWeightDouble));
                    goalWeight2 = Double.toString((int) Conversions.weightKgToPoundsPart(goalWeightDouble));
                }
                
            %>
            <div>
                <h2>Current Goal</h2>
                <%if("kg".equals(weightUnit)){%>
                <p>Goal Weight: <%=goalWeight%>kg</p>
                <%}
                else if("pound".equals(weightUnit)){%>
                <p>Goal Weight: <%=goalWeight%>lb</p>
                <%}
                else if("stonePound".equals(weightUnit)){%>
                <p>Goal Weight: <%=goalWeight%>st <%=goalWeight2%>lb</p>
                <%}%>
                <p>Goal Type: <%=goalType%></p>
                <p>Goal Speed: <%=goalSpeed%></p>
                <br>
            </div>
            <div>
                <h2>Change Goal</h2>
                <form class="form-inline" action="WebController">
                    <input type="hidden" name="formType" value="goals">
                    <p><label for="goalType">Goal</label>
                    <select name="goalType">
                        <option value="GainWeight">Gain Weight</option>
                        <option value="LoseWeight">Lose Weight</option>
                        <option value="MaintainWeight">Maintain Weight</option>
                    </select></p>

                    <%
                    if("kg".equals(weightUnit)){%>
                    <p>
                        <label for="goalWeight">Weight</label>
                        <input type="number" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">kg
                    </p><%}
                    else if("pound".equals(weightUnit)){%>
                    <p>
                        <label for="goalWeight">Weight</label>
                        <input type="number" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">lbs
                    </p><%}
                    else if("stonePound".equals(weightUnit)){%>
                    <p>
                        <label for="goalWeight">Weight</label>
                        <input type="number" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">st
                        <input type="number" id="goalWeight2" value="<%=goalWeight2%>" name="goalWeight2">lbs
                    </p><%}%>

                    <p><label for="goalSpeed">Goal Speed</label>
                    <select name="goalSpeed">
                        <%if("kg".equals(weightUnit)){%>
                            <option value="Slow">Slow 0.225kg/week</option>
                            <option value="Average">Average 0.45kg/week</option>
                            <option value="Aggressive">Aggressive 0.9kg/week</option>
                        <%}
                        else{%>
                            <option value="Slow">Slow 0.5lb/week</option>
                            <option value="Average">Average 1.0lb/week</option>
                            <option value="Aggressive">Aggressive 2.0lb/week</option>
                        <%}%>
                    </select></p>
                    <button type="submit" class="btn btn-primary">Save</button></p>
                </form>
            </div>
            <p><a href="profile.jsp" class="btn btn-info" role="button">Back</a></p>
        </div>
    </body>
</html>
