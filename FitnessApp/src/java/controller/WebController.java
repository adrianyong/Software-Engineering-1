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
        String formType = request.getParameter("formType");
        switch(formType){
        case "register":
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
                System.out.println("Error with date reformatting");
            }
            formatter = new SimpleDateFormat("dd/MM/1997");
            String dob = formatter.format(dobd);
            
            String sex = request.getParameter("sex");
            String height = request.getParameter("height");
            String weight = request.getParameter("weight");
            String tracking = request.getParameter("tracking");
            
            System.out.println(email + ", " + password + ", " + firstName + ", " + lastName + ", " + dob + ", " + sex + ", " + height + ", " + weight + ", " + tracking);
            
            User user = null;
            {
                try {
                    user = new User(email, password, firstName, lastName, dob, sex, height, weight, Boolean.parseBoolean(tracking));
                } catch (ParseException ex) {
                    System.out.println("Error creating user");
                }
            }
            
            System.out.println(user);
            
            ArrayList<User> users = new ArrayList();
            users.add(user);
            
            {
                try {
                    PersistanceController.saveUsers(users);
                } catch (IOException ex) {
                    System.out.println("Error saving user");
                }
            }
            
            /*System.out.println("Yo this is a registration");
            request.setAttribute("firstName",firstName);
            request.setAttribute("messageType","Success");
            request.setAttribute("message","User created successfully");
            { 
                try {
                    request.getRequestDispatcher("welcome.jsp").forward(request, response);
                } catch (Exception ex) {
                    System.out.println("Error");
                }
            }*/
            break;
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
