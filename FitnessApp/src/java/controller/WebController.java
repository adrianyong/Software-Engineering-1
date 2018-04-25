/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.HealthData;
import model.User;

/**
 *
 * @author Bento
 */
public class WebController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    private void processRequest(HttpServletRequest request, HttpServletResponse response) {
        HttpSession httpSession = request.getSession();
        String formType = request.getParameter("formType");
        switch(formType){
        case "register":
            registration(request, response, httpSession);
            break;
        case "login":
            login(request, response, httpSession);
            break;
        case "logout":
            logout(request, response, httpSession);
            break;
        case "weightHeight":
            weightHeight(request, response, httpSession);
            break;
        }
    }
    
    void registration(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
        //System.out.println("Form is asking for registration");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        String dobs = request.getParameter("dob");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date dobd = null;
        try {
            dobd = formatter.parse(dobs);
        } catch (ParseException ex) {
            System.out.println("ERROR: INCOMPATIBLE DATE FORMAT");
        }
        formatter = new SimpleDateFormat("dd/MM/1997");
        String dob = formatter.format(dobd);

        String sex = request.getParameter("sex");
        String height = request.getParameter("height");
        String weight = request.getParameter("weight");
        String tracking = request.getParameter("tracking");
        String activityLevel = "NoExercise"; //= request.getParameter("activityLevel");

        //System.out.println(email + ", " + password + ", " + firstName + ", " + lastName + ", " + dob + ", " + sex + ", " + height + ", " + weight + ", " + tracking);

        User user = null;
        try {
            user = new User(email, password, firstName, lastName, dob, sex, height, weight, tracking, activityLevel);
        } catch (ParseException ex) {
            System.out.println("ERROR: UNABLE TO INSTIANIATE NEW USER");
        }

        //System.out.println(user);
        PersistanceController.addUser(user);

        request.setAttribute("firstName",firstName);
        request.setAttribute("messageType","Success");
        request.setAttribute("message","User created successfully");

        httpSession.setAttribute("email", email);
        httpSession.setAttribute("password", password);
        httpSession.setAttribute("name", firstName);

        try {
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO LOAD WELCOME PAGE AFTER REGISTRATION");
        }
            
    }
    
    void login(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
        boolean error = false;
            
        //System.out.println("Form is asking for login");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(email==""){
            request.setAttribute("message","Please enter an email");
            error=true;
        }
        else if(password==""){
            request.setAttribute("message","Please enter a password");
            error=true;
        }

        User user = null;
        if(PersistanceController.matchUser(email) && error==false){
            //Email is correct
            user = PersistanceController.getUser(email, password);
            if(user == null){
                //Password is incorrect
                request.setAttribute("message","Wrong password");
                error=true;
            }
            else{
                //Password is correct
            }
        }
        else if (error==false){
            //Email is incorrect
            request.setAttribute("message","Email not found");
            error=true;
        }

        if(error){
            try {
                request.getRequestDispatcher("userLogin.jsp").forward(request, response);
            } catch (Exception ex) {
                System.out.println("ERROR: UNABLE TO RELOAD LOGIN PAGE");
            }
        }

        String firstName = user.getFirstName();

        request.setAttribute("firstName",firstName);
        request.setAttribute("messageType","Success");
        request.setAttribute("message","User login successful");

        httpSession.setAttribute("email", email);
        httpSession.setAttribute("password", password);
        httpSession.setAttribute("name", firstName);

        try {
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO LOAD WELCOME PAGE AFTER LOGIN");
        }
    }
    
    void logout(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
        httpSession.invalidate();
        try {
            request.getRequestDispatcher("userLogin.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO LOAD LOGIN PAGE AFTER LOGOUT");
        }
    }
    
    void weightHeight(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
        String email = (String) httpSession.getAttribute("email");
        
        String weight = request.getParameter("weight");
        String height = request.getParameter("height");
        String activityLevel = request.getParameter("activityLevel");
        
        HealthData healthData = new HealthData(Double.parseDouble(weight), Double.parseDouble(height));

        System.out.println(healthData);
        PersistanceController.addHealthData(healthData, email);

        try {
            request.getRequestDispatcher("updateWeight.jsp").forward(request, response);
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO RELOAD WEIGHT PAGE");
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
