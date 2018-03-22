/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package view;

import controller.SystemController;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Bento
 */
public class NewUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        
        String dobIn = request.getParameter("dob");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = formatter.parse(dobIn);
        } catch (ParseException ex) {
            Logger.getLogger(NewUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        formatter = new SimpleDateFormat("dd/MM/1997");
        String dob = formatter.format(date);

        String sex = request.getParameter("sex");
        boolean isMetric = request.getParameter("isMetric") != null;
        boolean isTrackingActivity = request.getParameter("isTrackingActivity") != null;
        
        User user = null;
        String output = "";
        try {
            user = new User(email, password, firstName, lastName, dob, sex, isMetric, isTrackingActivity);
            output = "User created succesfully.";
        } catch (ParseException ex) {
            output = "Error: Unable to create user!";
        }
        try {
            SystemController.addUser(user);
        } catch (IOException | ParseException | org.json.simple.parser.ParseException ex) {
            output += "\nError: Unable to save user!";
        }
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Registration Result</title>");
            out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.css\">");            
            out.println("</head>");
            out.println("<body>");
            out.println("<div class=col-auto>");
            
            out.println("<h2> "+ output + " </h2>");
            out.println("<h3>Hello, " + user.getFirstName() + "!</h3>");
            out.println("<h4><a href=\"/FitnessApp\">Return</a></h4>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
