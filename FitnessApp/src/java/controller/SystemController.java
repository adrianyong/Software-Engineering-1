/**
 * FitnessApp is the main method 
 * @author 100021268 100122248 100137721 100090034
 */
package controller;

import static controller.PersistanceController.loadActivities;
import static controller.PersistanceController.loadFoods;
import static controller.PersistanceController.loadHealthData;
import static controller.PersistanceController.loadHealthScores;
import static controller.PersistanceController.loadUsers;
import static controller.PersistanceController.saveUserFile;
import static controller.PersistanceController.saveUsers;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import model.Activity;
import model.Food;

import model.HealthData;
import model.HealthScore;
import model.User;

public class SystemController {

    public static void addUser(User u){
        List<User> users;
        try {
            users = loadUsers();
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO OPEN \"userdata.json\", POSSIBLY EMPTY FILE, INITIALISING");
            users = new ArrayList();
        }
        users.add(u);
        saveUsers(users);
    }
    
    public static boolean matchUser(String email){
        //System.out.println("Searching for email " + email);
        List<User> users;
        try {
            users = loadUsers();
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO OPEN \"userdata.json\" FILE TO LOAD USERS");
            return false;
        }
        
        for(User u : users){
            //System.out.println("Now trying user " + u.getFullName());
            if(u.getEmail().equals(email)){
                //System.out.println("Found at user " + u.getFullName());
                return true;
            }
        }
        return false;
    }
    
    public static User getUser(String email, String password){
        //System.out.println("Getting user with email " + email);
        List<User> users;
        try {
            users = loadUsers();
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO OPEN \"userdata.json\" FILE TO LOAD USERS");
            return null;
        }
        
        for(User u : users){
            //System.out.println("Now trying user " + u.getFullName());
            //System.out.println("Checking " + u.getEmail() + " against " + email);
            if(u.getEmail().equals(email)){
                //System.out.println("Checking " + u.getPassword() + " against " + password);
                if(u.getPassword().equals(password)){
                    //System.out.println("User found " + u.getFullName());
                    return u;
                }
            }
            //System.out.println("User email not found");
        }
        return null;
    }
    
    public static void addHealthData(HealthData data, String email){
        System.out.println("Adding new data for " + email);
        
        List<HealthData> healthData;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            healthData = new ArrayList();
        }
        healthData.add(data);
        
        List<Activity> activities;
        try {
            activities = loadActivities(email);
        } catch (Exception ex){
            activities = new ArrayList();
        }
        
        List<HealthScore> healthScores;
        try {
            healthScores = loadHealthScores(email);
        } catch (Exception ex){
            healthScores = new ArrayList();
        }
        
        List<Food> foods;
        try {
            foods = loadFoods(email);
        } catch (Exception ex){
            foods = new ArrayList();
        }
        saveUserFile(healthData, activities, healthScores, foods, email);
        
        System.out.println("New health data added");
    }
    
    public static HealthData getMostRecentHealthData(String email){
        List<HealthData> healthData = null;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
            healthData = new ArrayList();
        }
        if(healthData.size()==0)
            return null;
        
        return healthData.get(healthData.size()-1);
    }
    
    public static void addActivity(Activity activity, String email){
        System.out.println("Adding new data for " + email);
        
        List<HealthData> healthData;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            healthData = new ArrayList();
        }
        
        List<Activity> activities;
        try {
            activities = loadActivities(email);
        } catch (Exception ex){
            activities = new ArrayList();
        }
        activities.add(activity);
        
        List<HealthScore> healthScores;
        try {
            healthScores = loadHealthScores(email);
        } catch (Exception ex){
            healthScores = new ArrayList();
        }
        
        List<Food> foods;
        try {
            foods = loadFoods(email);
        } catch (Exception ex){
            foods = new ArrayList();
        }
        
        saveUserFile(healthData, activities, healthScores, foods, email);
        
        System.out.println("New activity added");
    }
    
    public static Activity getMostRecentActivity(String email){
        List<Activity> activites = null;
        try {
            activites = loadActivities(email);
        } catch (Exception ex){
            System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
            activites = new ArrayList();
        }
        if(activites.size()==0)
            return null;
        
        return activites.get(activites.size()-1);
    }
    
    public static void addHealthScore(HealthScore healthScore, String email){
        System.out.println("Adding new data for " + email);
        
        List<HealthData> healthData;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            healthData = new ArrayList();
        }
        
        List<Activity> activities;
        try {
            activities = loadActivities(email);
        } catch (Exception ex){
            activities = new ArrayList();
        }
        
        List<HealthScore> healthScores;
        try {
            healthScores = loadHealthScores(email);
        } catch (Exception ex){
            healthScores = new ArrayList();
        }
        healthScores.add(healthScore);
        
        List<Food> foods;
        try {
            foods = loadFoods(email);
        } catch (Exception ex){
            foods = new ArrayList();
        }
        
        saveUserFile(healthData, activities, healthScores, foods, email);
        
        System.out.println("New activity added");
    }
    
    public static void addCalories(double caloriesBurnt, double caloriesConsumed, String email){
        System.out.println("Adding new data for " + email);
        
        List<HealthData> healthData;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            healthData = new ArrayList();
        }
        
        List<Activity> activities;
        try {
            activities = loadActivities(email);
        } catch (Exception ex){
            activities = new ArrayList();
        }
        
        List<HealthScore> healthScores;
        try {
            healthScores = loadHealthScores(email);
        } catch (Exception ex){
            healthScores = new ArrayList();
        }
        Collections.reverse(healthScores);
        for(HealthScore hs : healthScores){
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            String oldDate = formatter.format(hs.getDateTime());
            String currentDate = formatter.format(new Date());
            if(oldDate.equals(currentDate)){
                hs.setCaloriesBurnt(hs.getCaloriesBurnt() + (int) caloriesBurnt);
                hs.setCaloriesConsumed(hs.getCaloriesConsumed() + (int) caloriesConsumed);
            }
        }
        
        List<Food> foods;
        try {
            foods = loadFoods(email);
        } catch (Exception ex){
            foods = new ArrayList();
        }
        
        saveUserFile(healthData, activities, healthScores, foods, email);
        
        System.out.println("New activity added");
    }
    
    public static HealthScore getMostRecentHealthScore(String email){
        List<HealthScore> healthScores = null;
        try {
            healthScores = loadHealthScores(email);
        } catch (Exception ex){
            System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
            healthScores = new ArrayList();
        }
        if(healthScores.size()==0)
            return null;
        
        return healthScores.get(healthScores.size()-1);
    }
    
    public static void addFood(Food food, String email){
        System.out.println("Adding new data for " + email);
        
        List<HealthData> healthData;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            healthData = new ArrayList();
        }
        
        List<Activity> activities;
        try {
            activities = loadActivities(email);
        } catch (Exception ex){
            activities = new ArrayList();
        }
        
        List<HealthScore> healthScores;
        try {
            healthScores = loadHealthScores(email);
        } catch (Exception ex){
            healthScores = new ArrayList();
        }
        
        List<Food> foods;
        try {
            foods = loadFoods(email);
        } catch (Exception ex){
            foods = new ArrayList();
        }
        foods.add(food);
        
        
        saveUserFile(healthData, activities, healthScores, foods, email);
        
        System.out.println("New activity added");
    }
    
    public static Food getMostRecentFood(String email){
        List<Food> foods = null;
        try {
            foods = loadFoods(email);
        } catch (Exception ex){
            System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
            foods = new ArrayList();
        }
        if(foods.size()==0)
            return null;
        
        return foods.get(foods.size()-1);
    }
    
    //private static List<User> users = new ArrayList<User>();

//    public static void main(String[] args) throws java.text.ParseException, IOException, FileNotFoundException, org.json.simple.parser.ParseException{
//        try {
//            users = PersistanceController.loadUsers();
//            System.out.println("All users loaded successfully.");
//        } catch (Exception e) {
//            System.out.println("Error: unable to load users, they may not exist!");
//        }
//        
//        try {
//            PersistanceController.loadHealthData(users);
//            System.out.println("All user data loaded successfully.");
//        } catch (Exception e) {
//            System.out.println("Error: unable to load user data, it may not exist!");
//        }
//        
//        /*if(users.isEmpty()){
//            createTestUsers();
//            try {
//                PersistanceController.saveUsers(users);
//                System.out.println("All users saved successfully.");
//            } catch (Exception e){
//                System.out.println("Error: unable to save users!");
//            }
//        }*/
//        
//        for(User u : users){
//            u.updateData(70, 180, "NoExercise");
//            u.updateData(80, 170, "ModerateExercise");
//            u.updateData(60, 200, "LightExercise");
//        }
//        PersistanceController.saveHealthData(users);
//        
//    }
//    
//    public static List<User> getUsers() throws IOException, FileNotFoundException, org.json.simple.parser.ParseException, ParseException{
//        List<User> users = PersistanceController.loadUsers();
//        return users;
//    }
//    
//    public static void addUser(User user) throws IOException, FileNotFoundException, org.json.simple.parser.ParseException, ParseException{
//        List<User> users = PersistanceController.loadUsers();
//        System.out.println(users + "loaded");
//        users.add(user);
//        System.out.println(user + "added");
//        PersistanceController.saveUsers(users);
//        System.out.println(users + "saved");
//    }
    
//    public static List<User> createTestUsers() throws ParseException{
//        User user1 = new User("bentownsend1997@gmail.com", "password", "Ben", "Townsend", "16/03/1997", "Male", true, false);
//        System.out.println("User \"" + user1.getFullName() + "\" created");
//        users.add(user1);
//
//        User user2 = new User("sophiecevrollo@gmail.com", "12345", "Sophie", "Rollo", "05/04/1994", "Female", false, true);
//        System.out.println("User \"" + user2.getFullName() + "\" created");
//        users.add(user2);
//
//        User user3 = new User("brazil.jdogg@gmail.com", "12345", "James", "Mason", "10/12/1995", "Male", true, true);
//        System.out.println("User \"" + user3.getFullName() + "\" created");
//        users.add(user3);
//
//        User user4 = new User("ayong104@gmail.com", "12345", "Adrian", "Yong", "10/04/1997", "Male", true, false);
//        System.out.println("User \"" + user4.getFullName() + "\" created");
//        users.add(user4);
//        
//        return users;
//    }
}
