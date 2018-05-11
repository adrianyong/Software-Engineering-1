<%-- 
    Document   : goals
    Created on : 20-Apr-2018, 17:46:42
    Author     : Bento
--%>

<%@page import="model.HealthScore"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="model.Conversions"%>
<%@page import="model.Goal"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
		<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<title>Goals</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
        <%
            //Redirect to login page if user session is invalid
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            String password = (String) httpSession.getAttribute("password");
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            String name = (String) httpSession.getAttribute("name");
            User user = PersistanceController.getUser(email, password);

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

            HealthScore healthScore = new HealthScore(user);
            String healthScoreMsg = Integer.toString(healthScore.getHealthScore());
            
            Goal goal = user.getGoal();
            double goalWeightDouble = user.getGoal().getGoalWeight();
            String goalWeight = "";
            String goalWeight2 = "";
            String goalType = goal.getType().toString();
            String goalSpeed = goal.getGoalSpeed().toString();

            String weightUnit = user.getWeightUnit().toString();

            if("kg".equals(weightUnit)){
                goalWeight = Double.toString(goalWeightDouble);
            }
            else if("pound".equals(weightUnit)){
                goalWeight = Double.toString(Conversions.weightKgToPounds(goalWeightDouble));
            }
            else if("stonePound".equals(weightUnit)){
                goalWeight = Double.toString((int) Conversions.weightKgToStonePart(goalWeightDouble));
                goalWeight2 = Double.toString((int) Conversions.weightKgToPoundsPart(goalWeightDouble));
            }

            %>

    </head>
    <body height:100%; margin:0;padding:0>
        <div class="wrapper bg golbg">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
			
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
					
					<div class="form-group">
							<a href="foodLog.jsp" class="btn btn-info notpage" role="button">Food Log</a>
					</div>

					<div class="form-group">
						<a href="updateWeight.jsp" class="btn btn-info notpage" role="button">Weight Log</a>
					</div>
						
					<div class="form-group">
						<a href="goals.jsp" class="btn btn-info currentpage" role="button">Goals</a>
					</div>
						
					<div class="form-group">
						<a href="settings.jsp" class="btn btn-info notpage" role="button">Settings</a>
					</div>
						
				</form>
				
				<div class="container mainboxes">
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25 text-center align-items-center d-flex">
								<div class="container w-100 left-pad">
									<div class="form-group form-inline">
										<h2 class="w-50 no-margin text-left text-truncate">Goal Weight:</h2>
										<%if("kg".equals(weightUnit)){%>
											<h3 class="w-50 no-margin text-left text-truncate"><%=goalWeight%>kg</h3>
										<%}
										else if("pound".equals(weightUnit)){%>
											<h3 class="w-50 no-margin text-left text-truncate"><%=goalWeight%>lb</h3>
										<%}
										else if("stonePound".equals(weightUnit)){%>
											<h3 class="w-50 no-margin text-left text-truncate"><%=goalWeight%>st <%=goalWeight2%>lb</h3>
										<%}%>
									</div>
									<div class="form-group form-inline">
										<h2 class="w-50 no-margin text-left text-truncate">Goal Type</h2>
										<h3 class="w-50 no-margin text-left text-truncate"><%=goalType%></h3>
									</div>
									<div class="form-group form-inline">
										<h2 class="w-50 no-margin text-left text-truncate">Goal Speed</h2>
										<h3 class="w-50 no-margin text-left text-truncate"><%=goalSpeed%></h3>
									</div>
								</div>
							</div>
						
						<div class="col-xl bigbox rounded-0.25 d-flex align-items-center">
							<form class="form-mb4 w-100 side-pad-5" action="WebController">
								<input type="hidden" name="formType" value="goals">
								<div class="form-group">
									<label for="goalType" class="w-100 text-left">Goal:</label>
									<select name="goalType" class="form-control w-100 border-0 backgroundBlack2">
										<option value="GainWeight">Gain Weight</option>
										<option value="LoseWeight">Lose Weight</option>
										<option value="MaintainWeight">Maintain Weight</option>
									</select>
								</div>

								<%
								if("kg".equals(weightUnit)){%>
								<div class="form-group">
									<label for="goalWeight" class=" w-100 text-left">Weight (kg) </label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">
								</div><%}
								else if("pound".equals(weightUnit)){%>
								<div class="form-group">
									<label for="goalWeight" class="w-100 text-left">Weight (lb)</label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">
								</div><%}
								else if("stonePound".equals(weightUnit)){%>
								<div class="form-group form-inline">
									<label for="goalWeight" class=" w-100 text-left">Weight (st & lbs)</label>
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="goalWeight2" value="<%=goalWeight2%>" name="goalWeight2">
								</div><%}%>

								<div class="form-group">
									<label for="goalSpeed" class=" w-100 text-left">Goal Speed:</label>
									<select name="goalSpeed" class="form-control w-100 border-0 backgroundBlack2">
										<%if("kg".equals(weightUnit)){%>-->
											<option value="Slow">Slow 0.225kg/week</option>
											<option value="Average">Average 0.45kg/week</option>
											<option value="Aggressive">Aggressive 0.9kg/week</option>
										<%}
										else{%>
											<option value="Slow">Slow 0.5lb/week</option>
											<option value="Average">Average 1.0lb/week</option>
											<option value="Aggressive">Aggressive 2.0lb/week</option>
										<%}%>
									</select>
								</div>
								<button type="submit" class="btn btn-info w-100" onclick="return confirm('Are you sure?')">Update Goal</button></p>
							</form>
						
						</div>
					</div>
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25">
							
						</div>
					</div>
				</div>
			</div>
        </div>
    </body>
</html>
