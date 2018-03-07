/**
 * FitnessApp is the main method 
 * @author 100021268 100122248 100137721 100090034
 */
package controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import model.*;

public class SystemController {

    private static ArrayList<User> users = new ArrayList();

    public static void main(String[] args) {
        
        if(users.isEmpty()){
            System.out.println("No users found! Please create user.");
        }

        User newUser = newUser();
        users.add(newUser);
        
    }
    
    public static User newUser(){
        String email = "Bentownsend1997@gmail.com";
        String password = "password";
        String firstName = "Ben";
        String surname = "Townsend";
        Date dateOfBirth = new GregorianCalendar(1997, Calendar.MARCH, 16).getTime();
        User.Sex sex = User.Sex.Male;
        boolean isMetric = true;
        boolean trackActivity = false;
        
        User testUser = new User(firstName, surname, email, password, dateOfBirth, sex, isMetric, trackActivity);
        System.out.println(testUser);
        System.out.println("New User \"" + firstName + "\" created.");
        return testUser;
    }
    
}
