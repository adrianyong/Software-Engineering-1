<%-- 
    Document   : settings
    Created on : 25-Apr-2018, 11:30:54
    Author     : dad15gwu
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="model.HealthScore"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
		
        <%
            //Redirect to login page if user session is invalid
            HttpSession httpSession = request.getSession();
            
            String email = "";
            String password = "";
            User user = null;
            String name = "";
            String timeOfDay = "";
            String healthScoreMsg = "";
            
            boolean isTracking = true;
            
            try{
                email = (String) httpSession.getAttribute("email");
                password = (String) httpSession.getAttribute("password");

                user = PersistanceController.getUser(email, password);
                name = (String) httpSession.getAttribute("name");
                
                Date date = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                timeOfDay = "morning";
                int hour = cal.get(Calendar.HOUR_OF_DAY);

                if (hour >= 12 && hour < 17) {
                    timeOfDay = "afternoon";
                }
                else if (hour >= 17) {
                    timeOfDay = "evening";
                }

                HealthScore healthScore = new HealthScore(user);
                healthScoreMsg = Integer.toString(healthScore.getHealthScore());
                
                isTracking = user.isTrackingActivity();
            } catch(Exception e){
                request.setAttribute("message","Invalid session, please log in");
                request.getRequestDispatcher("userLogin.jsp").forward(request, response);
            }
        %>
        
    </head>
	
    <body height:100%; margin:0;padding:0>
		
		
        <div class="wrapper bg setbg">
		
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
					
					<%if(isTracking){%>
					<div class="form-group">
						<a href="exerciseLog.jsp" class="btn btn-info notpage" role="button">Exercise Log</a>
					</div>
					<%}%>
					
					<div class="form-group">
							<a href="foodLog.jsp" class="btn btn-info notpage" role="button">Food Log</a>
					</div>
				   
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
				<%
                                    User.ActivityLevel activityLevel = user.getActivityLevel();
                                    String activityLevelString = activityLevel.toString();
                                    
                                    String heightUnitString = user.getHeightUnit().toString();
                                    String weightUnitString = user.getWeightUnit().toString();
                                    
                                    DecimalFormat df = new DecimalFormat("#.##");
                                    String restingHeartRateString = df.format(user.getRestingHeartRate());
                                    String bodyFatPercentageString = df.format(user.getBodyFatPercentage());
				%>
				<div class="container mainboxes">
					<div class="row h-100">
						<div class="col-xl bigbox rounded-0.25 d-flex align-items-center">
							<form class="form-mb4 w-100 side-pad-25" action="WebController">
								<input type="hidden" name="formType" value="settings">
                                                                <div class="form-group form-inline w-100">
                                                                    <h4 class="w-100">User Settings</h4>
                                                                </div>
                                                                <div class="form-group form-inline w-100">
                                                                    <label for="tracking" class="w-50">Would you like to Track Activity?</label>
                                                                    <select name="tracking" class="form-control w-50 border-0 backgroundBlack2">
                                                                            <option value="True" <%if (isTracking){%>
                                                                                    selected
                                                                                    <%}%>>True</option>
                                                                            <option value="False" <%if (!isTracking){%>
                                                                                    selected
                                                                                    <%}%>>False</option>
                                                                    </select>
                                                                </div>
								<% 
								if(!isTracking){%>
								<div class="form-group form-inline w-100">
									<label for="activityLevel" class="w-50">Activity Level</label>
									<select name="activityLevel" class="form-control w-50 border-0 backgroundBlack2">
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
								</div>
								<%}
								else{%>
								<div class="form-group form-inline w-100">
									<label for="activityLevel" class="w-50">Activity Level (outside exercise)</label>
									<select name="activityLevel" class="form-control w-50 border-0 backgroundBlack2">
										<option value="NoExercise" <%if (activityLevelString.equals("NoExercise")){%>
												selected
												<%}%>>Sedentary</option>
										<option value="LightExercise" <%if (activityLevelString.equals("LightExercise")){%>
												selected
												<%}%>>Active Lifestyle</option>
									</select>
								</div>
								<%}%>
                                                                <div class="form-group form-inline w-100">
                                                                    <h4 class="w-100">Unit Preferences</h4>
                                                                </div>
                                                                
                                                                <div class="form-group form-inline">
                                                                    <label for="heightUnit" class="w-50">Height Preferences</label>
                                                                    <select name="heightUnit" class="form-control w-50 border-0 backgroundBlack2">
                                                                            <option value="cm" <%if (heightUnitString.equals("cm")){%>
												selected
												<%}%>>Cm</option>
                                                                            <option value="feetInches" <%if (heightUnitString.equals("feetInches")){%>
												selected
												<%}%>>Feet</option>
                                                                    </select>
                                                                </div>

                                                                <div class="form-group form-inline">
                                                                    <label for="weightUnit" class="w-50">Weight Preferences</label>
                                                                    <select name="weightUnit" class="form-control w-50 border-0 backgroundBlack2">
                                                                            <option value="kg" <%if (weightUnitString.equals("kg")){%>
												selected
												<%}%>>Kg</option>
                                                                            <option value="pound" <%if (weightUnitString.equals("pound")){%>
												selected
												<%}%>>Pound</option>
                                                                            <option value="stonePound" <%if (weightUnitString.equals("stonePound")){%>
												selected
												<%}%>>Stone</option>
                                                                    </select>
                                                                </div>
                                                                    
                                                                <div class="form-group form-inline w-100">
                                                                    <h4 class="w-100">Additional Health Data</h4>
                                                                </div>
                                                                    
                                                                <div class="form-group form-inline">
                                                                    <label for="restingHeartRate" class="w-50">Resting Heart Rate (bpm)</label>
                                                                    <input type="number" class="form-control w-50 border-0 backgroundBlack2" id="restingHeartRate" value="<%=restingHeartRateString%>" name="restingHeartRate">
                                                                </div>
                                                                    
                                                                <div class="form-group form-inline">
                                                                    <label for="bodyFatPercentage" class="w-50">Body Fat Percentage</label>
                                                                    <input type="number" class="form-control w-50 border-0 backgroundBlack2" id="bodyFatPercentage" value="<%=bodyFatPercentageString%>" name="bodyFatPercentage">
                                                                </div>

								<button type="submit" class="btn btn-info w20">Save</button>
							</form>
						</div>
						

					</div>
				
				</div>
			</div>


        </div>
    </body>
</html>
