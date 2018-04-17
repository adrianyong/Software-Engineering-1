<%-- 
    Document   : register
    Created on : 22-Mar-2018, 17:39:20
    Author     : 100021268
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <div class="container">
            <h2>Register</h2>
            <p>Make the viewport larger than 576px wide to see that all of the form elements are inline and left-aligned. On small screens, the form groups will stack horizontally.</p>
            <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="register">
                <p><label for="email">Email:</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email" name="email"></p>
                
                <p><label for="password">Password:</label>
                <input type="password" class="form-control" id="password" placeholder="Enter password" name="password"></p>
                
                <p><label for="firstName">First Name: </label>
                <input type="input" class="form-control" id="firstName" placeholder="Enter first name" name="firstName"></p>
                
                <p><label for="lastName">Last Name: </label>
                <input type="input" class="form-control" id="lastName" placeholder="Enter last name" name="lastName"></p>
                
                <p><label for="dob">Date of Birth: </label>
                <input type="date" class="form-control" id="dob" placeholder="Enter date of birth" name="dob"></p>
                
                <p><h4>Sex</h4>
                <label for="sex1">Male </label>
                <input type="radio" class="form-control" id="sex1" name="sex" value="Male">
                <label for="sex1">Female </label>
                <input type="radio" class="form-control" id="sex2" name="sex" value="Female"></p>
                
                <p><h4>Height Preferences</h4>
                <label for="heightPref1">cm </label>
                <input type="radio" class="form-control" id="heightPref1" name="height" value="cm">
                <label for="heightPref2">feet </label>
                <input type="radio" class="form-control" id="heightPref2" name="height" value="feet"></p>
                
                <p><h4>Weight Preferences</h4>
                <label for="weightPref1">kg </label>
                <input type="radio" class="form-control" id="weightPref1" name="weight" value="kg">
                <label for="weightPref2">stone </label>
                <input type="radio" class="form-control" id="weightPref2" name="weight" value="stone">
                <label for="weightPref3">pound </label>
                <input type="radio" class="form-control" id="weightPref3" name="weight" value="pound"></p>
                
                <p><h4>Would you like to Track Activity?</h4>
                <label for="tracking1">yes </label>
                <input type="radio" class="form-control" id="tracking1" name="tracking" value="True">
                <label for="tracking2">no </label>
                <input type="radio" class="form-control" id="tracking2" name="tracking" value="False"></p>
                
                <div class="form-check">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <p><a href="index.jsp" class="btn btn-info" role="button">Back Home</a></p>
            
            <p><a href="userLogin.jsp" class="btn btn-info" role="button">Back to User Login</a></p>
        </div>
</html>
