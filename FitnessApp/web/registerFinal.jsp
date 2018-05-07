<%-- 
    Document   : registerFinal
    Created on : 25-Apr-2018, 12:05:32
    Author     : dad15gwu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Final Registration</title>
<!--        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
    </head>
    <body>
        <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="register2">
                <%
                    HttpSession httpSession = request.getSession();
                    String trackingS = (String) httpSession.getAttribute("tracking");
                    boolean tracking = Boolean.parseBoolean(trackingS);
                    if(!tracking){
                %>
                
                <p><label for="activityLevel">Activity Level</label>
                <select name="activityLevel">
                    <option value="NoExercise">No Exercise</option>
                    <option value="LightExercise">Light Exercise 1-3 days/week</option>
                    <option value="ModerateExercise">Moderate Exercise 3-5 days/week</option>
                    <option value="HardExercise">Hard Exercise 6-7 days/week</option>
                    <option value="VeryHardExercise">Very Hard Exercise with Physical Job</option>
                </select></p>
                <%}
                else{%>
                <p><label for="activityLevel">Activity Level (with tracking)</label>
                <select name="activityLevel">
                    <option value="NoExercise">Sedentary</option>
                    <option value="ModerateExercise">Active Lifestyle</option>
                </select></p>
                <%}%>
                
                <h2>Goal stuff</h2>
                
                <p><label for="goalType">Goal</label>
                <select name="goalType">
                    <option value="GainWeight">Gain Weight</option>
                    <option value="LoseWeight">Lose Weight</option>
                    <option value="MaintainWeight">Maintain Weight</option>
                </select></p>
                
                <%
                String weightUnit = (String) httpSession.getAttribute("weightUnit");
                String heightUnit = (String) httpSession.getAttribute("heightUnit");
                if("kg".equals(weightUnit)){%>
                <p>
                    <label for="goalWeight">Weight</label>
                    <input type="number" id="goalWeight" name="goalWeight">kg
                </p><%}
                else if("pound".equals(weightUnit)){%>
                <p>
                    <label for="goalWeight">Weight</label>
                    <input type="number" id="goalWeight" name="goalWeight">lbs
                </p><%}
                else if("stonePound".equals(weightUnit)){%>
                <p>
                    <label for="goalWeight">Weight</label>
                    <input type="number" id="goalWeight" name="goalWeight">st
                    <input type="number" id="goalWeight2" name="goalWeight2">lbs
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
                
                <h2>Initial weight and height</h2>
                <div>
                <%if("kg".equals(weightUnit)){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="" name="weight">kg
                </p><%}%>
                <%if("pound".equals(weightUnit)){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="" name="weight">lbs
                </p><%}%>
                <%if("stonePound".equals(weightUnit)){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" name="weight">st
                    <input type="number" class="form-control" id="weight2" name="weight2">lbs
                </p><%}%>

                <%if("cm".equals(heightUnit)){%>
                <p>
                    <label for="height">Height:</label>
                    <input type="number" class="form-control" id="height" name="height">cm
                </p><%}%>
                <%if("feetInches".equals(heightUnit)){%>
                <p>
                    <label for="height">Height:</label>
                    <input type="number" class="form-control" id="height" name="height">ft
                    <input type="number" class="form-control" id="height2" name="height2">in
                </p><%}%>
                
                <p><a href="register.jsp" class="btn btn-info" role="button">Back</a>
                <button type="submit" class="btn btn-primary">Register</button></p>
            </form>
    </body>
</html>
