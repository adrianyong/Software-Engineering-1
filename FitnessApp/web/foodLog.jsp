<%-- 
    Document   : foodLog
    Created on : 20-Apr-2018, 17:46:25
    Author     : Bento
--%>

<%@page import="model.FoodTemplate"%>
<%@page import="model.Food"%>
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
                List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                String oldDate = "";
                for(HealthData hd : healthDatas){
                    String weightDisplay = Double.toString(hd.getWeight());
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                    String dateTimeDisplay = formatter.format(hd.getDateTime());
                    if(dateTimeDisplay.equals(oldDate))
                        break;
                    %>
                    ['', ''],
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
		<div class="wrapper bg fbg">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
			
			<%
				HealthData recentData = PersistanceController.getMostRecentHealthData(email);
				
				String lastWeight = "";
				String lastWeight2 = "";
				String lastHeight = "";
				String lastHeight2 = "";
				
				
				String weightUnit = user.getWeightUnit().toString();
				String heightUnit = user.getHeightUnit().toString();
				
				if(recentData!=null){
					if("kg".equals(weightUnit)){
						lastWeight = Double.toString(recentData.getWeight());
					}
					else if("pound".equals(weightUnit)){
						lastWeight = Double.toString(Conversions.weightKgToPounds(recentData.getWeight()));
					}
					else if("stonePound".equals(weightUnit)){
						lastWeight = Double.toString((int) Conversions.weightKgToStonePart(recentData.getWeight()));
						lastWeight2 = Double.toString((int) Conversions.weightKgToPoundsPart(recentData.getWeight()));
					}

					if("cm".equals(heightUnit)){
						lastHeight = Double.toString(recentData.getHeight());
					}
					else if("feetInches".equals(heightUnit)){
						lastHeight = Double.toString((int) Conversions.heightCMToFeetPart(recentData.getHeight()));
						lastHeight2 = Double.toString((int) Conversions.heightCMToInchesPart(recentData.getHeight()));
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
					
					<div class="form-group">
						<a href="exerciseLog.jsp" class="btn btn-info notpage" role="button">Exercise Log</a>
					</div>
					
                    <div class="form-group">
                        <a href="foodLog.jsp" class="btn btn-info currentpage" role="button">Food Log</a>
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
							<form class="form-mb4 w-100" action="WebController">
								<input type="hidden" name="formType" value="weightHeight">
								<div class="form-group">
                                                                    <label for="duration" class=" w-100 text-left">Quantity (g)</label>
                                                                    <input type="number" class="form-control " id="duration" value="" name="duration" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="activity" class=" w-100 text-left">Food</label>
                                                                    <select name="activity" class="form-control w-100 border-0 backgroundBlack">
                                                                        <%for(FoodTemplate ft : Food.getFoodList()){
                                                                            String activityName = ft.getFoodName();
                                                                        %>
                                                                            <option value="<%=activityName%>"><%=activityName%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="meal" class=" w-100 text-left">Meal</label>
                                                                    <select name="meal" class="form-control w-100 border-0 backgroundBlack">
                                                                        <%for(Food.Meal f : Food.Meal.values()){
                                                                            String meal = f.toString();
                                                                        %>
                                                                            <option value="<%=meal%>"><%=meal%></option>
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
								try {
									List<Food> foods = PersistanceController.loadFoods(email);
									Collections.reverse(foods);;
									for(Food f : foods){
										SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                                                                                String dateTime = formatter.format(f.getDateTime());%>

										<div class="container">
											<div class="row border-bottom2 flex-row">
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