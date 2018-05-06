<%-- 
    Document   : updateWeight
    Created on : 20-Apr-2018, 17:50:22
    Author     : Bento
--%>

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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Data</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    </head>
    <body>
        <%
            //Redirect to login page if user session is invalid
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            String password = (String) httpSession.getAttribute("password");
            if(email == null){
                response.sendRedirect("userLogin.jsp");
            }
            
            User user = PersistanceController.getUser(email, password);
            HealthData recentData = PersistanceController.getMostRecentData(email);
            
            String lastWeight = "";
            String lastWeight2 = "";
            String lastHeight = "";
            String lastHeight2 = "";
            
            
            String weightUnit = user.getWeight().toString();
            String heightUnit = user.getHeight().toString();
            
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
                    lastHeight = Double.toString(recentData.getWeight());
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
                <%if(weightUnit == "kg"){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">kg
                </p><%}%>
                <%if(weightUnit == "pound"){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">lbs
                </p><%}%>
                <%if(weightUnit == "stonePound"){%>
                <p>
                    <label for="weight">Weight</label>
                    <input type="number" class="form-control" id="weight" value="<%=lastWeight%>" name="weight">st
                    <input type="number" class="form-control" id="weight2" value="<%=lastWeight2%>" name="weight2">lbs
                </p><%}%>

                <%if(heightUnit == "cm"){%>
                <p>
                    <label for="height">Height:</label>
                    <input type="number" class="form-control" id="height" value="<%=lastHeight%>" name="height">cm
                </p><%}%>
                <%if(heightUnit == "feetInches"){%>
                <p>
                    <label for="height">Height:</label>
                    <input type="number" class="form-control" id="height" value="<%=lastHeight%>" name="height">ft
                    <input type="number" class="form-control" id="height2" value="<%=lastHeight2%>" name="height2">in
                </p><%}%>
                <p> <button type="submit" class="btn btn-primary">Submit</button> </p>
                </div>
            </form>
            <%
                try {
                    List<HealthData> healthDatas = PersistanceController.loadHealthData(email);
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
