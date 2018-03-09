/**
 * FitnessApp is the main method 
 * @author 100021268 100122248 100137721 100090034
 */
package controller;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.*;

import org.json.*;

public class SystemController {

    private static ArrayList<User> users = new ArrayList<>();

    public static void main(String[] args) {
        if(users.isEmpty()){
            System.out.println("No users found! Please create user.");
        }
        User newUser = newUser();
        users.add(newUser);
        newUser.updateData(70, 180, HealthData.ActivityLevel.LightExercise);
        newUser.updateData(80, 180, HealthData.ActivityLevel.NoExercise);
        
        JSONObject jo = new JSONObject();
        
        /*private String email;
        private String password;
        private String firstName;
        private String surname;
        private Date dateOfBirth;
        private final Sex bioSex;
        private ArrayList<HealthData> dataList;
        private Goal goal;
        private boolean isMetric;
        private boolean isTrackingActivity;*/
        
        jo.put("email", newUser.getEmail());
        jo.put("password", newUser.getPassword());
        jo.put("firstName", newUser.getFirstName());
        jo.put("surname", newUser.getSurname());
        jo.put("dateOfBirth", newUser.getDateOfBirth());
        jo.put("bioSex", newUser.getSex());
        jo.put("dataList", newUser.getDataList());
        jo.put("goal", newUser.getGoal());
        jo.put("isMetric", newUser.isMetric());
        jo.put("isTrackingActivity", newUser.isTrackingActivity());
        
        PrintWriter pw = null;
        try {
            pw = new PrintWriter("users.json");
        } catch (FileNotFoundException ex) {
            Logger.getLogger(SystemController.class.getName()).log(Level.SEVERE, null, ex);
        }
        pw.write(jo.toString(1));
         
        pw.flush();
        pw.close();
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
