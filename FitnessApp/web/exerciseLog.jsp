<%-- 
    Document   : exerciseLog
    Created on : 20-Apr-2018, 17:46:17
    Author     : Bento
--%>

<%@page import="controller.SystemController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
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
        <title>Activity Log</title>
		
        <%
            HttpSession httpSession = request.getSession();

            String email = "";
            String password = "";
            User user = null;
            String name = "";
            String timeOfDay = "";
            String healthScoreMsg = "";
            
            boolean isTracking = true;
            //Redirect to login page if user session is invalid
            try{
                email = (String) httpSession.getAttribute("email");
                password = (String) httpSession.getAttribute("password");
                name = (String) httpSession.getAttribute("name");
                user = SystemController.getUser(email, password);

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
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);

          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Date', 'Calories Burnt'],
              <%
                List<HealthScore> healthScores = PersistanceController.loadHealthScores(email);
                String oldDate = "";
                for(HealthScore hs : healthScores){
                    String calorieDisplay = Double.toString(hs.getCaloriesBurnt());
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                    String dateTimeDisplay = formatter.format(hs.getDateTime());
                    if(dateTimeDisplay.equals(oldDate))
                        break;
                    %>
                    ['<%=dateTimeDisplay%>', <%=calorieDisplay%>],
                    <%
                    oldDate = dateTimeDisplay;
                }
              %>
            ]);

            var options = {
              curveType: 'function',
              animation: {"startup": true},
              legend: { position: 'bottom' },
              colors: ['#048a72'],
              series: {0: { lineWidth: 5 } },
              backgroundColor: { fill:'transparent' },
              hAxis: {textStyle:{color: '#FFF'}},
              vAxis: {textStyle:{color: '#FFF'}},
              chartArea: {'width': '90%', 'height': '80%'},
              legend: {position: 'none'}
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

            chart.draw(data, options);
          }
        </script>
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
						<label class="floatleft" onclick="return alert('Your health is not measured by your weight alone.\nHere at healthBot we understand that and created the healthBot Health Score to reflect this.\nWe use your BMI, body fat percentage and resting heart rate to give you a truer representation of your health.\nShare it with your friends and family and see who amongst you can reach the top score of 7 ! ')">Health Score: <%= healthScoreMsg%></label>
						<div class="form-group">
							<a href="profile.jsp" class="btn btn-info notpage" role="button">Home</a>
						</div>
						
						<%if(isTracking){%>
                                                <div class="form-group">
                                                        <a href="exerciseLog.jsp" class="btn btn-info currentpage" role="button">Exercise Log</a>
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
							<a href="settings.jsp" class="btn btn-info notpage" role="button">Settings</a>
						</div>
						
					</form>
					
				<div class="container mainboxes">
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25 d-flex align-items-center">
							<form class="form-mb4 w-100 side-pad-5" action="WebController">
								<input type="hidden" name="formType" value="activity">
                                <div class="form-group">
                                    <label for="duration" class=" w-100 text-left">Duration (Minutes)</label>
                                    <input type="number" class="form-control border-0 backgroundBlack2" id="duration" value="" name="duration" required>
                                </div>
                                <div class="form-group">
                                    <label for="activity" class=" w-100 text-left">Activity</label>
                                    <select name="activity" class="form-control w-100 border-0 backgroundBlack2">
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
                                <div id="curve_chart" style="width: 100%; height: 100%"></div>
                            </div>
                        </div>
                    
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25 no-pad">
						<div class="container section-act">
                                <%
                                    List<Activity> activityLog = new ArrayList(user.getActivityLog());
                                    Collections.reverse(activityLog);
                                    DecimalFormat df = new DecimalFormat("#.##");
                                    if(activityLog.size()>0){
                                    for(Activity a: activityLog){
                                        String activity = a.getName();
                                        String duration = df.format(a.getDuration());

                                        String caloriesBurnt = df.format(a.getCaloriesBurnt());
                                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                                        String dateTime = formatter.format(a.getDateTime());
                                        
                                        int days = (int)( (new Date().getTime() - a.getDateTime().getTime()) / (1000 * 60 * 60 * 24));
                                        
                                        if(days == 0)
                                            dateTime = "Today";
                                        else if(days == 1 )
                                            dateTime = days + " day ago";
                                        else if(days < 7 )
                                            dateTime = days + " days ago";
                                %>
                                
                                <div class="container">
                                    <div class="row border-bottom2 flex-row">
                                        <div class="p-2 w40 text-truncate"><%=activity%></div>
                                        <div class="p-2 w20 text-truncate"><%=duration%> mins</div>
                                        <div class="p-2 w20 text-truncate"><%=caloriesBurnt%> kcal</div>
                                        <div class="p-2 w20 text-truncate"><%=dateTime%></div>
                                    </div>
                                </div>
                                <%}}
                                else{%>
                                    <p>No existing activities</p>
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
