<%-- 
    Document   : settings
    Created on : 25-Apr-2018, 11:30:54
    Author     : dad15gwu
--%>

<%@page import="model.User"%>
<%@page import="controller.PersistanceController"%>
<%@page import="model.HealthData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings</title>
<!--        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
    </head>
    <body>
        <div class="container">
            <%
                //Redirect to login page if user session is invalid
                HttpSession httpSession = request.getSession();
                String email = (String) httpSession.getAttribute("email");
                String password = (String) httpSession.getAttribute("password");
                if(email == null){
                    response.sendRedirect("userLogin.jsp");
                }

                User user = PersistanceController.getUser(email, password);
                System.out.println(user);
                User.ActivityLevel activityLevel = user.getActivityLevel();
                System.out.println(activityLevel);
                String activityLevelString = activityLevel.toString();
            %>
            <p>
                <form class="form-inline" action="WebController">
                    <input type="hidden" name="formType" value="settings">

                    <label for="activityLevel">Activity Level</label>
                    <select name="activityLevel">
                        <option value="NoExercise" <%if (activityLevelString.equals("NoExercise")){%>
                                selected
                                <%}%>>No Exercise</option>
                        <option value="LightExercise" <%if (activityLevelString.equals("LightExercise")){%>
                                selected
                                <%}%>>Light Exercise</option>
                        <option value="ModerateExercise" <%if (activityLevelString.equals("ModerateExercise")){%>
                                selected
                                <%}%>>Moderate Exercise</option>
                        <option value="HardExercise" <%if (activityLevelString.equals("HardExercise")){%>
                                selected
                                <%}%>>Hard Exercise</option>
                        <option value="VeryHardExercise"<%if (activityLevelString.equals("VeryHardExercise")){%>
                                selected
                                <%}%>>Very Hard Exercise</option>
                    </select>

                    <button type="submit" class="btn btn-primary">Save</button>
                </form>
            </p>

            <p><a href="profile.jsp" class="btn btn-info" role="button">Back</a></p>
        </div>
    </body>
</html>
