<%-- 
    Document   : exerciseLog
    Created on : 20-Apr-2018, 17:46:17
    Author     : Bento
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.HealthScore"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="model.ActivityTemplate"%>
<%@page import="model.Activity"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
		<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
		
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
		%>
		
    </head>
    <body height:100%; margin:0;padding:0>
		<div class="wrapper bg alogbg overflow-hidden">
	
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
							<a href="exerciseLog.jsp" class="btn btn-info currentpage" role="button">Exercise Log</a>
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
						<div class="col-xl bigbox rounded-0.25 d-flex align-items-center">
							<form class="form-mb4 w-100" action="WebController">
								<input type="hidden" name="formType" value="activity">
                                    <div class="form-group">
                                        <label for="duration" class=" w-100 text-left">Duration(Minutes)</label>
                                        <input type="number" class="form-control " id="duration" value="" name="duration" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="activity" class=" w-100 text-left">Activity</label>
                                        <select name="activity" class="form-control w-100 border-0 backgroundBlack">
                                            <%for(ActivityTemplate at : Activity.getActivityList()){
                                                String activityName = at.getActivityName();
                                            %>
                                                <option value="<%=activityName%>"><%=activityName%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    
								<button type="submit" class="btn btn-info w-100">Submit</button>

							</form>
                            </div>
                            
                            <div class="col-xl bigbox rounded-0.25">
                                
                            </div>
                        </div>
                    
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25 no-pad">
						<div class="container section-act">
                                <%
                                    for(Activity a: user.getActivityLog()){
                                        String activity = a.getName();
                                        String duration = Double.toString(a.getDuration());
                                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                                        String dateTime = formatter.format(a.getDateTime());
                                        String caloriesBurnt = Double.toString(a.getCaloriesBurnt());
                                %>
                                
                                <div class="form-group d-flex align-items-center">
                                    <div class="form-control w-25 border-right-0 text-truncate"><%=activity%></div>
                                    <div class="form-control w-25 border-left-0 border-right-0 text-truncate"><%=duration%></div>
                                    <div class="form-control w-25 border-left-0 text-truncate"><%=caloriesBurnt%></div>
                                    <div class="form-control w-25 border-left-0 text-truncate"><%=dateTime%></div>
                                </div>
                                <%}%>
                            </div>
                        </div>
					</div>
					</div>
				</div>
			</div>
		</div>	
    </body>
</html>
