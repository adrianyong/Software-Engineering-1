<%-- 
    Document   : userLogin
    Created on : 22-Mar-2018, 17:08:57
    Author     : 100021268
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="viewport" content="width=device-width, initial-scale=1">
        <title>User Login</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		

    </head>
	
    <body height:100%; margin:0;padding:0>
	
        <%
            //Redirect to profile page if user session already exists
            HttpSession httpSession = request.getSession();
            String email = (String) httpSession.getAttribute("email");
            if(email != null){
                response.sendRedirect("profile.jsp");
            }
        %>
		<div class="wrapper bg loginbg">
		
			<div class="container text-center">
					<h1 class="top1">healthBot</h1>
					<h4 class="subt"> your personal fitness assistant </h4>
			</div>
			
			<div style="background:transparent !important" class="jumbotron d-flex align-items-center">
				<div class="container">
					
					<form class="form mb-4" action="WebController">
						<div class="form-group">
							<input type="hidden" name="formType" value="login">
						</div>
						
						<div class="form-group">
							<label for="email" class="sr-only">Email:</label>
							<input type="email" class="form-control text-center border-right-0 border-left-0 border-bottom-0 rounded-0"
							id="email" placeholder="Email" name="email">
						</div>
						
						<div class="form-group">
							<label for="password" class="sr-only">Password:</label>
							<input type="password" class="form-control text-center border-right-0 border-left-0 border-bottom-0 rounded-0"
							id="pwd" placeholder="Password" name="password">
						</div>
		
						<fieldset class="form-group">					
							<div class="form-check">
								<label class="form-check-label">
									<input class="form-check-input" type="checkbox" name="remember"> Remember me
								</label>
							</div>
						</fieldset>
						
						<button type="submit" class="btn btn-info btn-block ">Submit</button>
					</form>
					
					<%String message = (String)request.getAttribute("message"); 
					
					if(message != null){%>
					
					<div class="alert alert-danger text-center">
						<strong>Error: </strong> <%= message%>
					</div>
                                        <%}%>
					
				</div>
				
				<div class="fixed-bottom text-center">
					<p><a href="register.jsp" class="btn btn-info" role="button">Sign up</a></p>
				</div>
			</div>
			
			
		</div>
		
    </body>
</html>
