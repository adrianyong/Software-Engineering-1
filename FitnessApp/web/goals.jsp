<%-- 
    Document   : goals
    Created on : 20-Apr-2018, 17:46:42
    Author     : Bento
--%>

<%@page import="controller.SystemController"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.HealthData"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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

                user = SystemController.getUser(email, password);
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
            
            Goal goal = user.getGoal();
            double goalWeightDouble = user.getGoal().getGoalWeight();
            String goalWeight = "";
            String goalWeight2 = "";
            String goalType = goal.getType().toString();
            String goalSpeed = goal.getGoalSpeed().toString();

            String weightUnit = user.getWeightUnit().toString();

            DecimalFormat df = new DecimalFormat("#.##");
            
            if("kg".equals(weightUnit)){
                goalWeight = df.format((int) goalWeightDouble);
            }
            else if("pound".equals(weightUnit)){
                goalWeight = df.format((int) Conversions.weightKgToPounds(goalWeightDouble));
            }
            else if("stonePound".equals(weightUnit)){
                goalWeight = df.format((int) Conversions.weightKgToStonePart(goalWeightDouble));
                goalWeight2 = df.format((int) Conversions.weightKgToPoundsPart(goalWeightDouble));
            }
            %>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);

          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Date', 'Input Weight', 'Trend Weight'],
              <%
                List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                String oldDate = "";
                int count = 0;
                String weightDisplay = "";
                String dateTimeDisplay = "";
                
                double startingW = user.getWeight();
                for(HealthData hd : healthDatas){
                    weightDisplay = Double.toString(hd.getWeight());
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                    dateTimeDisplay = formatter.format(hd.getDateTime());
                    if(dateTimeDisplay.equals(oldDate) || count >= healthDatas.size()-1)
                        break;
                    %>
                    ['<%=dateTimeDisplay%>', <%=weightDisplay%>, null],
                    <%
                    oldDate = dateTimeDisplay;
                }
                %>
                ['<%=dateTimeDisplay%>', <%=weightDisplay%>, <%=startingW%>],
                <%
                
                double goalW = user.getGoal().getGoalWeight();
                double goalS = 0;
                if(user.getGoal().getGoalSpeed()==Goal.GoalSpeed.Aggressive)
                    goalS = 0.9/7;
                else if(user.getGoal().getGoalSpeed()==Goal.GoalSpeed.Average)
                    goalS = 0.45/7;
                else if(user.getGoal().getGoalSpeed()==Goal.GoalSpeed.Slow)
                    goalS = 0.225/7;
                Date date = new Date();
                if(user.getGoal().getType()==Goal.GoalType.GainWeight){
                    for(double i = startingW + goalS; i < goalW; i += goalS){
                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                        String dateTime = formatter.format(date);
                        %>
                        ['<%=dateTime%>', null,  <%=i%>],
                        <%
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(date);
                        cal.add(Calendar.DATE, 1);
                        date = cal.getTime();
                    }
                }
                else if(user.getGoal().getType()==Goal.GoalType.LoseWeight){
                    for(double i = startingW - goalS; i > goalW; i -= goalS){
                        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                        String dateTime = formatter.format(date);
                        %>
                        ['<%=dateTime%>', null,  <%=i%>],
                        <%
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(date);
                        cal.add(Calendar.DATE, 1);
                        date = cal.getTime();
                    }
                }
              %>
            ]);

            var options = {
              curveType: 'function',
              animation: {"startup": true},
              legend: { position: 'bottom' },
              colors: ['#048a72','#97BEB8'],
              series: {0: { 
                      lineWidth: 5 
                  },
                  1: { 
                      lineWidth: 5 
                  } 
              },
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
										<h2 class="w-50 no-margin text-left text-truncate">Goal Weight</h2>
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
                                                                        <%int days = (int) user.getGoal().getGoalCompletion(user);%>
                                                                        <br>
                                                                        <div class="form-group form-inline">
										<h2 class="w-50 no-margin text-left text-truncate">Days Remaining</h2>
										<h3 class="w-50 no-margin text-left text-truncate"><%=days%></h3>
									</div>
								</div>
							</div>
						
						<div class="col-xl bigbox rounded-0.25 d-flex align-items-center">
							<form class="form-mb4 w-100 side-pad-5" action="WebController">
								<input type="hidden" name="formType" value="goals">
								<!--<div class="form-group">
									<label for="goalType" class="w-100 text-left">Goal:</label>
									<select name="goalType" class="form-control w-100 border-0 backgroundBlack2">
										<option value="GainWeight"<%//if (goalType.equals("GainWeight")){%>
                                                                                    selected
                                                                                    <%//}%>>Gain Weight</option>
										<option value="LoseWeight"<%//if (goalType.equals("LoseWeight")){%>
                                                                                    selected
                                                                                    <%//}%>>Lose Weight</option>
										<option value="MaintainWeight"<%//if (goalType.equals("MaintainWeight")){%>
                                                                                    selected
                                                                                    <%//}%>>Maintain Weight</option>
									</select>
								</div>-->

								<%
								if("kg".equals(weightUnit)){%>
								<div class="form-group">
									<label for="goalWeight" class=" w-100 text-left">Goal Weight (kg) </label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">
								</div><%}
								else if("pound".equals(weightUnit)){%>
								<div class="form-group">
									<label for="goalWeight" class="w-100 text-left">Goal Weight (lb)</label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">
								</div><%}
								else if("stonePound".equals(weightUnit)){%>
								<div class="form-group form-inline">
									<label for="goalWeight" class=" w-100 text-left">Goal Weight (st & lbs)</label>
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="goalWeight" value="<%=goalWeight%>" name="goalWeight">
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="goalWeight2" value="<%=goalWeight2%>" name="goalWeight2">
								</div><%}%>

								<div class="form-group">
									<label for="goalSpeed" class=" w-100 text-left">Goal Speed:</label>
									<select name="goalSpeed" class="form-control w-100 border-0 backgroundBlack2">
										<%if("kg".equals(weightUnit)){%>-->
                                                                                        <option value="Slow"<%if (goalSpeed.equals("Slow")){%>
                                                                                            selected
                                                                                            <%}%>>Slow 0.225kg/week</option>
                                                                                        <option value="Average"<%if (goalSpeed.equals("Average")){%>
                                                                                            selected
                                                                                            <%}%>>Average 0.45kg/week</option>
                                                                                        <option value="Aggressive"<%if (goalSpeed.equals("Aggressive")){%>
                                                                                            selected
                                                                                            <%}%>>Aggressive 0.9kg/week</option>
										<%}
										else{%>
											<option value="Slow"<%if (goalSpeed.equals("Slow")){%>
                                                                                            selected
                                                                                            <%}%>>Slow 0.5lb/week</option>
                                                                                        <option value="Average"<%if (goalSpeed.equals("Average")){%>
                                                                                            selected
                                                                                            <%}%>>Average 1.0lb/week</option>
                                                                                        <option value="Aggressive"<%if (goalSpeed.equals("Aggressive")){%>
                                                                                            selected
                                                                                            <%}%>>Aggressive 2.0lb/week</option>
										<%}%>
									</select>
								</div>
								<button type="submit" class="btn btn-info w-100" onclick="return confirm('Are you sure?')">Update Goal</button></p>
							</form>
						
						</div>
					</div>
					<div class="row h-50">
						<div class="col-xl bigbox rounded-0.25">
							<div id="curve_chart" style="width: 100%; height: 100%"></div>
						</div>
					</div>
				</div>
			</div>
        </div>
    </body>
</html>
