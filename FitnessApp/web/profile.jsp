<%-- 
    Document   : profile
    Created on : 22-Mar-2018, 18:30:07
    Author     : 100021268
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.HealthScore"%>
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
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body height:100%; margin:0;padding:0>
        <div class="wrapper bg profbg">
		
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
					HealthScore healthScore = new HealthScore(user);
					String healthScoreMsg = Integer.toString(healthScore.getHealthScore());
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
					String oldDate = null;
					try{
						oldDate = formatter.format(PersistanceController.getMostRecentHealthScore(email).getDateTime());
					}catch (Exception ex){
						oldDate = "";
					}
					String newDate = formatter.format(healthScore.getDateTime());
					if(!oldDate.equals(newDate))
						PersistanceController.addHealthScore(healthScore, email);

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
						<a href="profile.jsp" class="btn btn-info currentpage" role="button">Home</a>
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
						<a href="settings.jsp" class="btn btn-info notpage" role="button">Settings</a>
					</div>
					
				</form>
				
				<div class="container mainboxes">
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25">
							hi
						</div>
						
						<div class="col-xl bigbox rounded-0.25">
							hi
						</div>
					</div>
					
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25">
							hi
						</div>
						
						<div class="col-xl bigbox rounded-0.25">
							hi
						</div>
					</div>
				</div>
			
			</div>
        </div>
    </body>
</html>
