<%-- 
    Document   : updateWeight
    Created on : 20-Apr-2018, 17:50:22
    Author     : Bento
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.HealthScore"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="model.Conversions"%>
<%@page import="model.HealthData"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="controller.PersistanceController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
        
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<title>Add Data</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);

          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Date', 'Weight'],
              <%
                List<HealthData> healthDatas = new ArrayList(PersistanceController.loadHealthData(email));
                String oldDate = "";
                for(HealthData hd : healthDatas){
                    String weightDisplay = Double.toString(hd.getWeight());
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                    String dateTimeDisplay = formatter.format(hd.getDateTime());
                    if(dateTimeDisplay.equals(oldDate))
                        break;
                    %>
                    ['<%=dateTimeDisplay%>', <%=weightDisplay%>],
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
		<div class="wrapper bg wlogbg">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
			
			<%
				HealthData recentData = PersistanceController.getMostRecentHealthData(email);
				
				String lastWeight = "";
				String lastWeight2 = "";
				String lastHeight = "";
				String lastHeight2 = "";
				
				String weightUnit = user.getWeightUnit().toString();
				String heightUnit = user.getHeightUnit().toString();
				
                                DecimalFormat df = new DecimalFormat("#.##");
				if(recentData!=null){
					if("kg".equals(weightUnit)){
						lastWeight = df.format(recentData.getWeight());
					}
					else if("pound".equals(weightUnit)){
						lastWeight = df.format(Conversions.weightKgToPounds(recentData.getWeight()));
					}
					else if("stonePound".equals(weightUnit)){
						lastWeight = df.format((int) Conversions.weightKgToStonePart(recentData.getWeight()));
						lastWeight2 = df.format((int) Conversions.weightKgToPoundsPart(recentData.getWeight()));
					}

					if("cm".equals(heightUnit)){
						lastHeight = df.format(recentData.getHeight());
					}
					else if("feetInches".equals(heightUnit)){
						lastHeight = df.format((int) Conversions.heightCMToFeetPart(recentData.getHeight()));
						lastHeight2 = df.format((int) Conversions.heightCMToInchesPart(recentData.getHeight()));
					}
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
						<a href="updateWeight.jsp" class="btn btn-info currentpage" role="button">Weight Log</a>
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
								<input type="hidden" name="formType" value="weightHeight">
								<%if("kg".equals(weightUnit)){%>
								<div class="form-group">
									<label for="weight" class="w-100 text-left">Weight (kg)</label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="weight" value="<%=lastWeight%>" name="weight">
								</div><%}%>
								<%if("pound".equals(weightUnit)){%>
								<div class="form-group">
									<label for="weight" class=" w-100 text-left">Weight (lb)</label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="weight" value="<%=lastWeight%>" name="weight">
								</div><%}%>
								<%if("stonePound".equals(weightUnit)){%>
								<div class="form-group form-inline">
									<label for="weight" class=" w-100 text-left">Weight (st & lb)</label>
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="weight" value="<%=lastWeight%>" name="weight">
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="weight2" value="<%=lastWeight2%>" name="weight2">
								</div><%}%>

								<%if("cm".equals(heightUnit)){%>
								<div class="form-group">
									<label for="height" class=" w-100 text-left">Height (cm) </label>
									<input type="number" class="form-control border-0 backgroundBlack2" id="height" value="<%=lastHeight%>" name="height">
								</div><%}%>
								<%if("feetInches".equals(heightUnit)){%>
								<div class="form-group form-inline">
									<label for="height" class=" w-100 text-left">Height (ft & in)</label>
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="height" value="<%=lastHeight%>" name="height">
									<input type="number" class="form-control w-50 border-0 backgroundBlack2" id="height2" value="<%=lastHeight2%>" name="height2">
								</div><%}%>
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
								try {
									//List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                                                                        Collections.reverse(healthDatas);
									for(HealthData hd : healthDatas){
										String weightDisplay = "";
										String heightDisplay = "";
										SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
										String dateTime = formatter.format(hd.getDateTime());
										
										int days = (int)( (new Date().getTime() - hd.getDateTime().getTime()) / (1000 * 60 * 60 * 24));

										if(days == 0)
											dateTime = "Today";
										else if(days == 1 || days == -1)
											dateTime = days + " day ago";
										else if(days < 7 )
											dateTime = days + " days ago";
										
										if("kg".equals(weightUnit)){
											weightDisplay = df.format(hd.getWeight()) + "kg";
										}
										else if("pound".equals(weightUnit)){
											weightDisplay = df.format(Conversions.weightKgToPounds(hd.getWeight())) + "lb";
										}
										else if("stonePound".equals(weightUnit)){
											weightDisplay = Double.toString((int) Conversions.weightKgToStonePart(hd.getWeight())) + "st " + Double.toString((int) Conversions.weightKgToPoundsPart(hd.getWeight())) + "lb";
										}
										
										if("cm".equals(heightUnit)){
											heightDisplay = df.format(hd.getHeight()) + "cm";
										}
										else if("feetInches".equals(heightUnit)){
											heightDisplay = Double.toString((int) Conversions.heightCMToFeetPart(hd.getHeight())) + "ft " + Double.toString((int) Conversions.heightCMToInchesPart(hd.getHeight())) + "in";
										}%>
										<div class="container">
											<div class="row border-bottom2 flex-row flex-start">
													<div class="p-2 w33 text-truncate"><%=weightDisplay%></div>
													<div class="p-2 w33 text-truncate"><%=heightDisplay%></div>
													<div class="p-2 w33 text-truncate"><%=dateTime%></div>
											</div>
										</div>
									<%}
								}catch (Exception ex) { %>
									<p>No existing entries found</p>
								<%}
							%>
                                                    </div>
						</div>
					</div>
				</div>
			</div>
                
      
        </div>
    </body>
</html>
