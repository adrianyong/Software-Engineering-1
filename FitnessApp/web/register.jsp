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
	
			<h2 class="container text-center">Registration</h2>
			<div style="background:transparent !important" class="jumbotron d-flex align-items-center">
				<div class="container text-center leftmid">
					<form class="form-mb4" action="WebController">
						<input type="hidden" name="formType" value="register">
						<p><label for="email" class="sr-only">Email:</label>
						<input type="email" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="email" placeholder="Enter email" name="email"></p>
						
						<p><label for="password" class="sr-only">Password:</label>
						<input type="password" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="password" placeholder="Enter password" name="password"></p>
						
						<p><label for="firstName" class="sr-only">First Name: </label>
						<input type="input" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="firstName" placeholder="Enter first name" name="firstName"></p>
						
						<p><label for="lastName" class="sr-only">Last Name: </label>
						<input type="input" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="lastName" placeholder="Enter last name" name="lastName"></p>
						
						<p><label for="dob" class="sr-only">Date of Birth: </label>
						<input type="date" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="dob" placeholder="Enter date of birth" name="dob"></p>
						
						<h6>Sex </h6>
						<div class="form-group">
							<div class="o-switch btn-group d-flex" data-toggle="buttons" role="sex">
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="sex" id="sex1" value="Male" autocomplete="off" checked> Male
							  </label>
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="sex" id="sex2" value="Female" autocomplete="off" checked> Female
							  </label>
							</div>
						</div>
						
						<h6>Height Preferences </h6>
						<div class="form-group">
							<div class="o-switch btn-group d-flex" data-toggle="buttons" role="height">
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="height" id="heightPref1" value="cm" autocomplete="off" checked> Cm
							  </label>
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="height" id="heightPref2" value="feet" autocomplete="off" checked> Feet
							  </label>
							</div>
						</div>
						
						<h6>Weight Preferences</h6>
						<div class="form-group">
							<div class="o-switch btn-group d-flex" data-toggle="buttons" role="height">
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="weight" id="weightPref1" value="kg" autocomplete="off" checked> Kg
							  </label>
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="weight" id="weightPref2" value="stone" autocomplete="off" checked> Stone
							  </label>
							</div>
						</div>
						
						<h6>Would you like to Track Activity?</h6>
						<div class="form-group">
							<div class="o-switch btn-group d-flex" data-toggle="buttons" role="height">
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="tracking" id="tracking1" value="True" autocomplete="off" checked> Yes
							  </label>
							  <label class="btn btn-secondary w-100">
								<input type="radio" class= "form-control" name="tracking" id="tracking2" value="False" autocomplete="off" checked> No
							  </label>
							</div>
						</div>
						
						<div class="form-check">
						</div>
						<button type="submit" class="btn btn-primary">Next</button>
						
					</form>
					
					<!--
					<p><a href="index.jsp" class="btn btn-info" role="button">Back Home</a></p>
					-->
					<div class="bottom-but">
						<p><a href="userLogin.jsp" class="btn btn-info" role="button">Back to User Login</a></p>
					</div>
					
				</div>
			</div>
		
		</div>
</html>

