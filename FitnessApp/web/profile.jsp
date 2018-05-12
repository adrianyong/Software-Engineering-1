<%-- 
    Document   : profile
    Created on : 22-Mar-2018, 18:30:07
    Author     : 100021268
--%>

<%@page import="java.util.List"%>
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
        <%
            HttpSession httpSession = request.getSession();
            
            String email = "";
            String password = "";
            User user = null;
            
            int BMR = 0;
            int modifiedBMR = 0;
            
            int hour = 0;
            int caloriesBurnt = 0;
            int caloriesNotBurnt = 0;
            
            int caloriesConsumed = 0;
            int caloriesLeft = 0;
            
            //Redirect to login page if user session is invalid
            try{
                email = (String) httpSession.getAttribute("email");
                password = (String) httpSession.getAttribute("password");

                user = PersistanceController.getUser(email, password);
                BMR = (int) Calculations.BMR(user);
                modifiedBMR = (int) user.getGoal().getModifiedBMR(user);

                Date date = new Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                hour = cal.get(Calendar.HOUR_OF_DAY);
                caloriesBurnt = (int) ((hour/24.0f)*BMR);
                caloriesNotBurnt = (int) BMR - caloriesBurnt;

                caloriesConsumed = PersistanceController.getMostRecentHealthScore(email).getCaloriesConsumed();
                caloriesLeft = modifiedBMR - caloriesConsumed;
            } catch(Exception e){
                request.setAttribute("message","Invalid session, please log in");
                request.getRequestDispatcher("userLogin.jsp").forward(request, response);
            }
            
        %>
       <!--Calories remaining Chart-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load("current", {packages:["corechart"]});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Type', 'Calories'],
              ['Consumed', <%=caloriesConsumed%>],
              ['Not yet consumed', <%=caloriesLeft%>],
            ]);

            var options = {
                pieSliceBorderColor : "transparent",
                pieHole: 0.8,
                pieSliceText: "none",
                animation: {"startup": true},
                legend: { position: 'bottom' },
                colors: ['#048a72','#97BEB8'],
                backgroundColor: { fill:'transparent' },
                chartArea: {'width': '95%', 'height': '95%'},
                legend: {position: 'none'},
                'tooltip' : {
                    trigger: 'none'
                }
            };

            var chart = new google.visualization.PieChart(document.getElementById('caloriesRemaining'));
            chart.draw(data, options);
          }
        </script>
        <%
            double startingWeight = user.getDataList().get(0).getWeight();
            double currentWeight = user.getWeight();
            double goalWeight = user.getGoal().getGoalWeight();
        %>
        <!--Goal days-->
        <script type="text/javascript">
            google.charts.load("current", {packages:["corechart"]});
            google.charts.setOnLoadCallback(drawChart);
            function drawChart() {
              var data = google.visualization.arrayToDataTable([
                ['Type', 'startingWeight', 'currentWeight', 'goalWeight', { role: 'annotation' } ],
                ['2010', <%=startingWeight%>, <%=currentWeight%>, <%=goalWeight%>, '']
              ]);

              var view = new google.visualization.DataView(data);
              view.setColumns([0, 1,
                               { calc: "stringify",
                                 sourceColumn: 1,
                                 type: "string",
                                 role: "annotation" },
                               2]);

              var options = {
                bar: {groupWidth: "95%"},
                legend: { position: "none" },
                isStacked: true,
                animation: {"startup": true},
                colors: ['#048a72','#97BEB8'],
                backgroundColor: { fill:'transparent' },
                chartArea: {'width': '90%', 'height': '80%'},
                legend: {position: 'none'},
                'tooltip' : {
                    trigger: 'none'
                },
                hAxis: { textPosition: 'none', gridlines: { count: 0 } },
                vAxis: { textPosition: 'none', gridlines: { count: 0 } },

              };
              var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
              chart.draw(view, options);
          }
      </script>
      
        <!--Weight chart-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Date', 'Weight'],
              <%
                List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                String oldDateForGraph = "";
                for(HealthData hd : healthDatas){
                    String weightDisplay = Double.toString(hd.getWeight());
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                    String dateTimeDisplay = formatter.format(hd.getDateTime());
                    if(dateTimeDisplay.equals(oldDateForGraph))
                        break;
                    %>
                    ['<%=dateTimeDisplay%>', <%=weightDisplay%>],
                    <%
                    oldDateForGraph = dateTimeDisplay;
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
        
        <!--Calories Burnt Chart-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load("current", {packages:["corechart"]});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Type', 'Calories'],
              ['', <%=BMR%>],
              ['Burnt', <%=caloriesBurnt%>],
              ['Not yet burnt', <%=caloriesNotBurnt%>],
            ]);

            var options = {
                pieSliceBorderColor : "transparent",
                slices: {
                    0: {
                        color: 'transparent',
                        enableInteractivity: false
                    }
                },
                pieHole: 0.8,
                pieStartAngle: 90,
                pieSliceText: "none",
                animation: {"startup": true},
                legend: { position: 'bottom' },
                colors: ['#97BEB8','#048a72'],
                backgroundColor: { fill:'transparent' },
                chartArea: {'width': '95%', 'height': '95%'},
                legend: {position: 'none'},
                'tooltip' : {
                    trigger: 'none'
                }
            };

            var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
            chart.draw(data, options);
          }
        </script>
    </head>
    <body height:100%; margin:0;padding:0>
        <div class="wrapper bg profbg">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
			
				<%
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
					
					<!--<div class="<%= messageCSS%>">
						<strong><%= messageType%>!</strong> <%= message%>
					</div>-->
					
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
					
					String timeOfDay = "morning";

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
						<div class="col-xl bigbox rounded-0.25 align-items-center text-center">
                            <p><h4>Calories remaining today</h4></p>
                            <div class="container w-100 h80">
                                <div class="row h80">
                                    <div id="caloriesRemaining" class="col-md-12"></div>
                                    <div class="item-front">
                                        <h1><%=caloriesLeft%></h1>
                                    </div>
                                </div>
                                <p><a href="foodLog.jsp"><h4>Add Consumption</h4></a>
                            </div>
                            
						</div>
						
						<div class="col-xl bigbox rounded-0.25 align-items-center text-center">
                                                    <%
                                                        int days = (int) user.getGoal().getGoalCompletion(user);
                                                    %>
                                                    <br>
                                                    <h4>You'll reach your goal in</h4>
                                                    <h1><%=days%> Days</h1>
                                                    <div id="barchart_values" style="width: 100%; height: 20%;"></div>
                                                    <h4>Good Job Keep it up!</h4>
						</div>
					</div>
					
					<div class="row h-50">
                                            <div class="col-xl bigbox rounded-0.25 align-items-center text-center">
                                                <br>
                                                <h4>Weight over time</h4>
                                                <div id="curve_chart" style="width: 100%; height: 80%"></div>
                                            </div>

                                            <div class="col-xl bigbox rounded-0.25 align-items-center text-center">
                                                <br>
                                                <p><h4>Calories burnt today</h4></p>
                                                <div class="container w-100 h-80">
                                                    <div class="row h80">
                                                        <div id="donutchart" class="col-md-12"></div>
                                                        <div class="item-front2">
                                                            <h1><%=caloriesBurnt%></h1>
                                                        </div>
                                                    </div>
                                                    <p><a href="exerciseLog.jsp"><h4>Add Activity</h4></a>
                                                </div>
					</div>
				</div>
			
			</div>
        </div>
    </body>
</html>
