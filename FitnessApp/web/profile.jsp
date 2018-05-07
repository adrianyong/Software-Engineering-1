<%-- 
    Document   : profile
    Created on : 22-Mar-2018, 18:30:07
    Author     : 100021268
--%>

<%@page import="model.Calculations"%>
<%@page import="model.HealthData"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
        <!--<link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
    </head>
    <body>
        <div class="container">
            <br>
            <%
            //Redirect to login page if user session is invalid
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            String password = (String) httpSession.getAttribute("password");
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            User user = PersistanceController.getUser(email, password);
            
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
            <%}
                name = (String) httpSession.getAttribute("name");
                
                Date date = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                String timeOfDay = "morning";
                int hour = cal.get(Calendar.HOUR_OF_DAY);

                if (hour >= 12 && hour < 17) {
                    timeOfDay = "afternoon";
                }
                else if (hour >= 17) {
                    timeOfDay = "evening";
                }
            %>
                <p> Good <%= timeOfDay%>, <%= name%>!</p>
            <p><a href="profile.jsp" class="btn btn-info" role="button">Home</a></p>
            <p><a href="exerciseLog.jsp" class="btn btn-info" role="button">Exercise Log</a></p>
           <!--<p><a href="foodLog.jsp" class="btn btn-info" role="button">Food Log</a></p>-->
            <p><a href="updateWeight.jsp" class="btn btn-info" role="button">Weight Log</a></p>
            <%
                HealthData recentData = PersistanceController.getMostRecentData(email);
                if(recentData!=null){
                    String weight = Double.toString(recentData.getWeight());
                    String BMI = Double.toString(Calculations.BMI(recentData.getWeight(), recentData.getHeight()));
                    String BMIClass = Calculations.BMIClass(recentData.getWeight(), recentData.getHeight());
                    String BMR = Double.toString(Calculations.BMR(recentData.getWeight(), recentData.getHeight(), user.getAge(), user.getSex()));%>
                    <p>Weight: <%= weight%>kg</p>
                    <p>BMI: <%= BMI%> | <%= BMIClass%></p>
                    <p>BMR: <%= BMR%></p>
                <%}%>
            <p><a href="goals.jsp" class="btn btn-info" role="button">Goals</a></p>
            
            <a href="settings.jsp" class="btn btn-info" role="button">Settings</a>
            
            <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="logout">
                <button type="submit" class="btn btn-primary">Logout</button>
            </form>
        </div>
    </body>
</html>
