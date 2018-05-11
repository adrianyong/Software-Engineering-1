<%-- 
    Document   : foodLog
    Created on : 20-Apr-2018, 17:46:25
    Author     : Bento
--%>

<%@page import="java.text.DecimalFormat"%>
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
            
            int modifiedBMR = (int) user.getGoal().getModifiedBMR(user);
            int caloriesConsumed = PersistanceController.getMostRecentHealthScore(email).getCaloriesConsumed();
            int caloriesLeft = modifiedBMR - caloriesConsumed;
        %>
        
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<title>Add Data</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body height:100%; margin:0;padding:0>
		<div class="wrapper bg fbg">
		
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
                            <div class="col-xl bigbox rounded-0.25 text-center align-items-center d-flex">
                                    <div class="container w-100">
                                        <div class="row w-100 vertical-align">
                                        </div>
                                        <div class="row w-100 vertical-align">
                                            <h2 class="w-100 no-margin">Calories remaining today</h2>
                                        </div>
                                        <div class="row w-100 vertical-align">
                                            <h2 class="w-100 no-margin"><%=caloriesLeft%></h2>
                                        </div>
                                        <div class="row w-100 vertical-align">
                                            <h2 class="w-100 no-margin">Daily calorie allowance</h2>
                                        </div>
                                        <div class="row w-100 vertical-align">
                                            <h2 class="w-100 no-margin"><%=modifiedBMR%></h2>
                                        </div>
                                    </div>
                                </div>
						
						
                                                <div class="col-xl bigbox rounded-0.25">
                                                    <div id="curve_chart" style="width: 100%; height: 100%"></div>
						</div>
                                                                
						
					</div>

					<div class="row h-50">
                            <div class="col-xl bigbox rounded-0.25 d-flex align-items-center">
                                    <form class="form-mb4 w-100" action="WebController">
                                        <input type="hidden" name="formType" value="food">
                                                                        <div class="form-group">
                                                                            <label for="food" class=" w-100 text-left">Food</label>
                                                                            <select name="food" class="form-control w-100 border-0 backgroundBlack">
                                                                                <%for(FoodTemplate ft : Food.getFoodList()){
                                                                                    String activityName = ft.getFoodName();
                                                                                %>
                                                                                    <option value="<%=activityName%>"><%=activityName%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                        <div class="form-group">
                                                                            <label for="quantity" class=" w-100 text-left">Quantity (g)</label>
                                                                            <input type="number" class="form-control " id="quantity" value="" name="quantity" step="0.01" min="0.01" required>
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
                            <div class="container section-act">
							<%
								try {
									List<Food> foods = PersistanceController.loadFoods(email);
									Collections.reverse(foods);;
                                                                        DecimalFormat df = new DecimalFormat("#.##");
									for(Food f : foods){
										SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                                                                                String dateTime = formatter.format(f.getDateTime());
                                                                                String meal = f.getMeal().toString();
                                                                                String food = f.getName();
                                                                                String portion = df.format(f.getPortion());
                                                                                String calories = df.format(f.getCalories());
                                                                                
                                                                                int days = (int)( (new Date().getTime() - f.getDateTime().getTime()) / (1000 * 60 * 60 * 24));

                                                                                if(days == 0)
                                                                                    dateTime = "Today";
                                                                                else if(days == 1 )
                                                                                    dateTime = days + " day ago";
                                                                                else if(days < 7 )
                                                                                    dateTime = days + " days ago";%>

										<div class="container">
											<div class="row border-bottom2 flex-row h-100 flex-start">
                                                <div class="p-2 w20 text-truncate"><%=meal%></div>
                                                <div class="p-2 w20 text-truncate"><%=food%></div>
                                                <div class="p-2 w20 text-truncate"><%=portion%> g</div>
                                                <div class="p-2 w20 text-truncate"><%=calories%> kcal</div>
                                                <div class="p-2 w20 text-truncate"><%=dateTime%></div>
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