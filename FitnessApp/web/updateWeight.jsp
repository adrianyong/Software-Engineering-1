<%-- 
    Document   : updateWeight
    Created on : 20-Apr-2018, 17:50:22
    Author     : Bento
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form class="form-inline" action="WebController">
            <p>
                <input type="hidden" name="formType" value="weightHeight">
                <label for="height">Height:</label> <!--SESSION DATA USE HEIGHT FROM USER AS PLACEHOLDER-->
                <input type="height" class="form-control" id="height" placeholder="Enter height" name="height">
            </p>
            <p>
                <label for="weight">Weight</label><!--USER PREFERRED DATA TYPE I.E METRIC OR IMPERIAL-->
                <!--INPUT VALIDATION-->
                <input type="weight" class="form-control" id="weight" placeholder="Enter weight" name="weight">
            </p>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
    </body>
</html>
