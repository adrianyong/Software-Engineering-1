<%-- 
    Document   : settings
    Created on : 25-Apr-2018, 11:30:54
    Author     : dad15gwu
--%>

<%@page import="model.User"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.HealthData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
	
		<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings</title>
		
    </head>
	
    <body height:100%; margin:0;padding:0>
		
		
        <div class="wrapper bg setbg">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
			
				<%
					//Redirect to login page if user session is invalid
					HttpSession httpSession = request.getSession();
					String email = (String) httpSession.getAttribute("email");
					String password = (String) httpSession.getAttribute("password");
					if(email == null){
						response.sendRedirect("userLogin.jsp");
					}

					User user = PersistanceController.getUser(email, password);
					System.out.println(user);
					User.ActivityLevel activityLevel = user.getActivityLevel();
					System.out.println(activityLevel);
					String activityLevelString = activityLevel.toString();
					

				%>
				
				<div class="container text-center h-100 d-flex align-items-center lefty">
					<h4>Good <%= timeOfDay%>, <%= name%>!</h4>
				</div>
				
				<div class="container text-center align-items-center">
					<h1>healthBot</h1>
					<h5>your personal fitness assistant </h5>
				</div>
					
				<div class="container text-center h-100 align-items-center righty">
					<form class="form form-inline floatright" action="WebController">
						<input type="hidden" name="formType" value="logout">
						<button type="submit" class="btn btn-info nobg"><h4>Sign out</h4></button>
					</form>
				</div>

			</div>	
				
			<div style="background:transparent !important" class="jumbotron jumbomainprof d-flex align-items-center">
                
				<form class="sidebar">
					<label class="floatleft">Health Score :  <%= healthScoreMsg%></label>
					<div class="form-group">
						<a href="profile.jsp" class="btn btn-info notpage" role="button">Home</a>
					</div>
					
					<div class="form-group">
						<a href="exerciseLog.jsp" class="btn btn-info notpage" role="button">Exercise Log</a>
					</div>
					
				   <!--<p><a href="foodLog.jsp" class="btn btn-info" role="button">Food Log</a></p>-->
				   
					<div class="form-group">
						<a href="updateWeight.jsp" class="btn btn-info notpage" role="button">Weight Log</a>
					</div>
					
					<div class="form-group">
						<a href="goals.jsp" class="btn btn-info notpage" role="button">Goals</a>
					</div>
					
					<div class="form-group">
						<a href="settings.jsp" class="btn btn-info currentpage" role="button">Settings</a>
					</div>
					
				</form>
				
				<div class="container mainboxes">
					<div class="row h-100">
						<div class="col-xl bigbox rounded-0.25">
							<form class="form-inline" action="WebController">
								<input type="hidden" name="formType" value="settings">
								<% boolean tracking = user.isTrackingActivity();
								if(!tracking){
									%>
								<label for="activityLevel">Activity Level</label>
								<select name="activityLevel">
									<option value="NoExercise" <%if (activityLevelString.equals("NoExercise")){%>
											selected
											<%}%>>No Exercise</option>
									<option value="LightExercise" <%if (activityLevelString.equals("LightExercise")){%>
											selected
											<%}%>>Light Exercise</option>
									<option value="ModerateExercise" <%if (activityLevelString.equals("ModerateExercise")){%>
											selected
											<%}%>>Moderate Exercise</option>
									<option value="HardExercise" <%if (activityLevelString.equals("HardExercise")){%>
											selected
											<%}%>>Hard Exercise</option>
									<option value="VeryHardExercise"<%if (activityLevelString.equals("VeryHardExercise")){%>
											selected
											<%}%>>Very Hard Exercise</option>
								</select>
								<%}
								else{%>
								<label for="activityLevel">Activity Level (outside exercise)</label>
								<select name="activityLevel">
									<option value="NoExercise" <%if (activityLevelString.equals("NoExercise")){%>
											selected
											<%}%>>No Exercise</option>
									<option value="LightExercise" <%if (activityLevelString.equals("LightExercise")){%>
											selected
											<%}%>>Light Exercise</option>
								</select>
								<%}%>

								<button type="submit" class="btn btn-primary">Save</button>
							</form>
						</div>
						

					</div>
				
				</div>
			</div>


        </div>
    </body>
</html>
