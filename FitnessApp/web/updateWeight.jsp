<%-- 
    Document   : updateWeight
    Created on : 20-Apr-2018, 17:50:22
    Author     : Bento
--%>

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
        %>
        
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Data</title>
<!--        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);

          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Date', 'Weight', 'Height'],
              <%
                List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                String oldDate = "";
                for(HealthData hd : healthDatas){
                    String weightDisplay = Double.toString(hd.getWeight());
                    String heightDisplay = Double.toString(hd.getHeight());
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
                    String dateTimeDisplay = formatter.format(hd.getDateTime());
                    if(dateTimeDisplay.equals(oldDate))
                        break;
                    %>
                    ['<%=dateTimeDisplay%>', <%=weightDisplay%>, <%=heightDisplay%>],
                    <%
                    oldDate = dateTimeDisplay;
                }
              %>
            ]);

            var options = {
              curveType: 'function',
              legend: { position: 'bottom' }
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

            chart.draw(data, options);
          }
        </script>
    </head>
    <body>
        <%
            //Redirect to login page if user session is invalid
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            User user = PersistanceController.getUser(email, password);
            HealthData recentData = PersistanceController.getMostRecentData(email);
            
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
        <div class="container">
            <form class="form-inline" action="WebController">
                <input type="hidden" name="formType" value="weightHeight">
                <div>
                <%if("kg".equals(weightUnit)){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">kg
                </p><%}%>
                <%if("pound".equals(weightUnit)){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">lbs
                </p><%}%>
                <%if("stonePound".equals(weightUnit)){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">st
                    <input type="number" class="form-control" id="weight2" value="<%=lastWeight2%>" name="weight2">lbs
                </p><%}%>

                <%if("cm".equals(heightUnit)){%>
                <p>
                    <label for="height">Height:</label>
                    <input type="number" class="form-control" id="height" value="<%=lastHeight%>" name="height">cm
                </p><%}%>
                <%if("feetInches".equals(heightUnit)){%>
                <p>
                    <label for="height">Height:</label>
                    <input type="number" class="form-control" id="height" value="<%=lastHeight%>" name="height">ft
                    <input type="number" class="form-control" id="height2" value="<%=lastHeight2%>" name="height2">in
                </p><%}%>
                <p> <button type="submit" class="btn btn-primary">Submit</button> </p>
                </div>
            </form>
                
            <div id="curve_chart" style="width: 900px; height: 500px"></div>
                
            <%
                try {
                    //List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
                    Collections.reverse(healthDatas);;
                    for(HealthData hd : healthDatas){
                        String weightDisplay = "";
                        String heightDisplay = "";
                        String dateTimeDisplay = hd.getDateTime().toString();
                        
                        if("kg".equals(weightUnit)){
                            weightDisplay = Double.toString(hd.getWeight()) + "kg";
                        }
                        else if("pound".equals(weightUnit)){
                            weightDisplay = Double.toString(Conversions.weightKgToPounds(hd.getWeight())) + "lb";
                        }
                        else if("stonePound".equals(weightUnit)){
                            weightDisplay = Double.toString((int) Conversions.weightKgToStonePart(hd.getWeight())) + "st " + Double.toString((int) Conversions.weightKgToPoundsPart(hd.getWeight())) + "lb";
                        }
                        
                        if("cm".equals(heightUnit)){
                            heightDisplay = Double.toString(hd.getHeight()) + "cm";
                        }
                        else if("feetInches".equals(heightUnit)){
                            heightDisplay = Double.toString((int) Conversions.heightCMToFeetPart(hd.getHeight())) + "ft " + Double.toString((int) Conversions.heightCMToInchesPart(hd.getHeight())) + "in";
                        }%>
                        
                        <div>
                            <p>Weight: <%=weightDisplay%></p>
                            <p>Height: <%=heightDisplay%></p>
                            <p>Time Taken: <%=dateTimeDisplay%></p>
                            <br>
                        </div>
                    <%}
                }catch (Exception ex) { %>
                    <p>No existing entries found</p>
                <%}
            %>
            <p><a href="profile.jsp" class="btn btn-info" role="button">Back</a></p>
            </div>
    </body>
</html>
