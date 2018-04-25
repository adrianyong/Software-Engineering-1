<%-- 
    Document   : updateWeight
    Created on : 20-Apr-2018, 17:50:22
    Author     : Bento
--%>

<%@page import="model.HealthData"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="controller.PersistanceController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Data</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <%
            //Redirect to login page if user session is invalid
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            HealthData healthData = PersistanceController.getMostRecentData(email);
            String lastWeight = Double.toString(healthData.getWeight());
            String lastHeight = Double.toString(healthData.getHeight());
        %>
        <form class="form-inline" action="WebController">
            <input type="hidden" name="formType" value="weightHeight">
            <p>
                <label for="weight">Weight</label><!--USER PREFERRED DATA TYPE I.E METRIC OR IMPERIAL-->
                <!--INPUT VALIDATION-->
                <input type="weight" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">
            </p>
            <p>
                <label for="height">Height:</label> <!--SESSION DATA USE HEIGHT FROM USER AS PLACEHOLDER-->
                <input type="height" class="form-control" id="height" value="<%=lastHeight%>" name="height">
            </p>
            <!--<p>
                <label for="activityLevel">Activity Level</label>
                <select name="activityLevel" selected="<%=lastActivityLevel%>">
                    <option value="NoExercise">No Exercise</option>
                    <option value="LightExercise">Light Exercise</option>
                    <option value="ModerateExercise">Moderate Exercise</option>
                    <option value="HardExercise">Hard Exercise</option>
                    <option value="VeryHardExercise">Very Hard Exercise</option>
                </select>
            </p>-->
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <%
                try {
                    List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                    for(HealthData hd : healthDatas){%>
                    <p> <%= hd.toString()%> </p>
                <%}
                }catch (Exception ex) { %>
                    <p>No existing entries found</p>
                <%}
            %>
            <p><a href="profile.jsp" class="btn btn-info" role="button">Back</a></p>
    </body>
</html>
