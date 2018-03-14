<%-- 
    Document   : response
    Created on : 10-Mar-2018, 10:50:17
    Author     : Bento
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class=col-auto>
        <form action="${pageContext.request.contextPath}/NewUser" method="post">
            <p>Email       
                <input type="text" name="email" /></p>
            
            <p>Password       
                <input type="password" name="password" /></p>
            
            <p>First Name       
                <input type="text" name="firstName" /></p>
            
            <p>Last Name      
                <input type="text" name="lastName" /></p>

            <p>Date of Birth
                <input type="date" name="dob" required pattern="[0-9]{4}/[0-9]{2}-[0-9]{2}"></p>
            
            <p>Sex      
                <input type="radio" name="sex" value="Male" /> Male
                <input type="radio" name="sex" value="Female" /> Female</p>

            <p>Would you like to use metric units?
                <input type="checkbox" name="isMetric" /></p>
            
            <p>Would you like the track activity?
                <input type="checkbox" name="isTrackingActivity" /></p>

            <input type="submit" name="submit" value="Submit" /></p>
        </form>
        <h4><a href="/FitnessApp">Return</a></h4>
        </div>
    </body>
</html>
