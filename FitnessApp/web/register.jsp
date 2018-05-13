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
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<link rel="stylesheet" type="text/css" href="css/registration.css">
    </head>
    <body height:100%; margin:0;padding:0>
		<div class="wrapper bg regbg">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
				<div class="container containermob text-center leftmid">
					<h1>healthBot</h1>
					<h5>your personal fitness assistant </h5>
				</div>
			</div>
			
		
			<div style="background:transparent !important" class="jumbotron jumbomain d-flex align-items-center">
				<div class="container containermob text-center leftmid">
					<form class="form-mb4" action="WebController">
						<input type="hidden" name="formType" value="register1">
						<label for="email" class="text-left w-100">Email</label>
						<input type="email" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="email" placeholder="Enter email" name="email" required>
						
						<label for="password" class="text-left w-100">Password</label>
						<input type="password" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="password" placeholder="Enter password" name="password" required>
						
						<label for="firstName" class="text-left w-100">First Name: </label>
						<input type="input" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="firstName" placeholder="Enter first name" name="firstName" required>
						
						<label for="lastName" class="text-left w-100">Last Name: </label>
						<input type="input" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="lastName" placeholder="Enter last name" name="lastName" required>
						
						<label for="dob" class="text-left w-100">Date of Birth: </label>
						<input type="date" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="dob" placeholder="Enter date of birth" name="dob" required>
						
						<div class="form-group form-inline">
								<label for="heightUnit" class="w-50 text-left">Height Preferences</label>
								<select name="heightUnit" class="form-control w-50 border-0 backgroundBlack">
									<option value="cm" id="heightpref1">Cm</option>
									<option value="feetInches" id="heightpref2">Feet</option>
								</select>
						</div>
						
						<div class="form-group form-inline">
								<label for="weightUnit" class="w-50 text-left">Weight Preferences</label>
								<select name="weightUnit" class="form-control w-50 border-0 backgroundBlack">
									<option value="kg" id="weightpref1">Kg</option>
                                                                        <option value="pound" id="weightpref2">Pound</option>
									<option value="stonePound" id="weightpref3">Stone</option>
								</select>
						</div>
						
						<div class="form-group form-inline">
								<label for="sex" class="w-50 text-left">Sex</label>
								<select name="sex" class="form-control w-50 border-0 backgroundBlack">
									<option value="Male" id="sex1">Male</option>
									<option value="Female" id="sex2">Female</option>
								</select>
						</div>
						
						
						<div class="form-group form-inline">
								<label for="tracking" class="w-50 text-left">Would you like to Track Activity?</label>
								<select name="tracking" class="form-control w-50 border-0 backgroundBlack">
									<option value="True" id="weightpref1">Yes</option>
									<option value="False" id="weightpref2">No</option>
								</select>
						</div>
						
						<div class="form-check">
						</div></p>
						<button type="submit" class="btn btn-info btn-block">Next</button></p>
						
					</form>
					
					<!--
					<p><a href="index.jsp" class="btn btn-info" role="button">Back Home</a></p>
					-->
					
				</div>
			</div>
			
			<div style="background:transparent !important" class="jumbotron jumbobot d-flex align-items-center">
				<div class="container containermob text-center leftmid">
					<a href="userLogin.jsp" class="btn btn-info" role="button">Back to User Login</a>
				</div>
			</div>
		
		</div>
</html>
