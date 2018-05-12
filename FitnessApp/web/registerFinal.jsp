<%-- 
    Document   : registerFinal
    Created on : 25-Apr-2018, 12:05:32
    Author     : dad15gwu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Final Registration</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<link rel="stylesheet" type="text/css" href="css/registration.css">
    </head>
    <body height:100%; margin:0;padding:>
		<div class="wrapper bg regbg2">
		
			<div style="background:transparent !important" class="jumbotron jumbotitle d-flex align-items-center">
				<div class="container containermob text-center leftmid">
					<h1>healthBot</h1>
					<h5>your personal fitness assistant </h5>
				</div>
			</div>
		
			<div style="background:transparent !important" class="jumbotron jumbomain d-flex align-items-center">
				<div class="container containermob text-center leftmid">
					<form class="form-mb4" action="WebController">
							<input type="hidden" name="formType" value="register2">
							<%
							HttpSession httpSession = request.getSession();
							String weightUnit = (String) httpSession.getAttribute("weightUnit");
							String heightUnit = (String) httpSession.getAttribute("heightUnit");
							if("kg".equals(weightUnit)){%>
								<p><label for="weight" class="text-left w-100">Weight (kg)</label>
								<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="weight" placeholder="Enter weight" name="weight" required></p>
							<%}
							else if("pound".equals(weightUnit)){%>
								<p><label for="weight" class="text-left w-100">Weight (lb)</label>
								<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="weight" placeholder="Enter weight" name="weight" required></p>
							<%}
							else if("stonePound".equals(weightUnit)){%>
								<p><label for="weight" class="text-left w-100">Weight (st & lb)</label>
								<div class="form-group form-inline">
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0 w-50" id="weight" placeholder="Enter weight (st)" name="weight" required></p>
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0 w-50" id="weight2" placeholder="Enter weight (lb)" name="weight2" required></p>
								</div>
							<%}%>

							<%if("cm".equals(heightUnit)){%>
							<p><label for="height" class="text-left w-100">Height (cm)</label> 
							<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="height" placeholder="Enter height" name="height" required></p>
							<%}%>
							<%if("feetInches".equals(heightUnit)){%>
								<p><label for="weight" class="text-left w-100">Height (ft & in)</label>
								<div class="form-group form-inline">
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0 w-50" id="height" placeholder="Enter height (ft)" name="height" required></p>
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0 w-50" id="height2" placeholder="Enter height (in)" name="height2" required"></p>
								</div>
							<%}%>

							<%if("kg".equals(weightUnit)){%>
								<p><label for="goalWeight" class="text-left w-100">Goal Weight (kg)</label>
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="goalWeight" placeholder="Enter goal weight" name="goalWeight" required></p>
							<%}
							else if("pound".equals(weightUnit)){%>
								<p><label for="goalWeight" class="text-left w-100">Goal Weight (lb)</label>
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0" id="goalWeight" placeholder="Enter goal weight" name="goalWeight" required></p>
							<%}
							else if("stonePound".equals(weightUnit)){%>
								<p><label for="weight" class="text-left w-100">Goal Weight (st & lb)</label>
								<div class="form-group form-inline">
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0 w-50" id="goalWeight" placeholder="Enter weight (st)" name="goalWeight" required></p>
									<input type="number" class="form-control border-right-0 border-left-0 border-bottom-0 rounded-0 w-50" id="goalWeight2" placeholder="Enter weight (lb)" name="goalWeight2" required></p>
								</div>
							<%}%>

							
							
							<%
								String trackingS = (String) httpSession.getAttribute("tracking");
								boolean tracking = Boolean.parseBoolean(trackingS);
								if(!tracking){
							%>
							<div class="form-group form-inline">
								<label for="activityLevel" class="w-50 text-left">Activity Level</label>
								<select name="activityLevel" class="form-control w-50 border-0 backgroundBlack">
									<option value="NoExercise">No Exercise</option>
									<option value="LightExercise">Light Exercise 1-3 days/week</option>
									<option value="ModerateExercise">Moderate Exercise 3-5 days/week</option>
									<option value="HardExercise">Hard Exercise 6-7 days/week</option>
									<option value="VeryHardExercise">Very Hard Exercise with Physical Job</option>
								</select>
							</div>
							<%}
                                                        else{%>
							<div class="form-group form-inline">
								<label for="activityLevel" class="w-50 text-left">Activity Level (outside exercise)</label>
								<select name="activityLevel" class="form-control w-50 border-0 backgroundBlack">
									<option value="NoExercise">Sedentary</option>
									<option value="LightExercise">Active Lifestyle</option>
								</select>
							</div>
							<%}%>

							<div class="form-group form-inline">
								<label for="goalType" class="w-50 text-left">Goal</label>
								<select name="goalType" class="form-control w-50 border-0 backgroundBlack">
									<option value="GainWeight">Gain Weight</option>
									<option value="LoseWeight">Lose Weight</option>
									<option value="MaintainWeight">Maintain Weight</option>
								</select>
							</div>
							
							<div class="form-group form-inline">
								<label for="goalSpeed" class="w-50 text-left">Goal Speed</label>
								<select name="goalSpeed" class="form-control w-50 border-0 backgroundBlack">
									<%if("kg".equals(weightUnit)){%>
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
							 
							<button type="submit" class="btn btn-info btn-block">Submit</button></p>
						</form>
				</div>		
			</div>
			
			<div style="background:transparent !important" class="jumbotron jumbobot d-flex align-items-center">
				<div class="container containermob text-center leftmid">
					<a href="register.jsp" class="btn btn-info" role="button">Back</a></p>
				</div>
			</div>
			
    </body>
</html>
