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
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="register">
                <p><label for="email">Weight</label>
                <input type="input" class="form-control" id="email" placeholder="Enter weight" name="email"></p>
                
                <p><label for="password">Height</label>
                <input type="input" class="form-control" id="password" placeholder="Enter height" name="password"></p>
                
                <p><label for="firstName">Goal Weight</label>
                <input type="input" class="form-control" id="firstName" placeholder="Enter goal weight" name="firstName"></p>
                
                <p><label for="activityLevel">Activity Level</label>
                <select name="activityLevel">
                    <option value="NoExercise">No Exercise</option>
                    <option value="LightExercise">Light Exercise 1-3 days/week</option>
                    <option value="ModerateExercise">Moderate Exercise 3-5 days/week</option>
                    <option value="HardExercise">Hard Exercise 6-7 days/week</option>
                    <option value="VeryHardExercise">Very Hard Exercise with Physical Job</option>
                </select></p>
                
                <p><label for="activityLevel">Activity Level (with tracking)</label>
                <select name="activityLevel">
                    <option value="NoExercise">Sedentary</option>
                    <option value="ModerateExercise">Active Lifestyle</option>
                </select></p>
                
                <p><label for="goal">Goal</label>
                <select name="goal">
                    <option value="Gain">Gain Weight</option>
                    <option value="Lose">Lose Weight</option>
                    <option value="Maintain">Maintain Weight</option>
                </select></p>
                
                <p><label for="activityLevel">Goal Speed</label>
                <select name="activityLevel">
                    <option value="Slow">Slow 0.225kg/week</option>
                    <option value="Average">Average 0.45kg/week</option>
                    <option value="Aggressive">Aggressive 0.9kg/week</option>
                </select></p>
                
                <p><a href="register.jsp" class="btn btn-info" role="button">Back</a>
                <button type="submit" class="btn btn-primary">Submit</button></p>
            </form>
    </body>
</html>
