/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Activity;
import model.Food;
import model.Goal;
import model.HealthData;
import model.HealthScore;

import model.User;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author jxy13mmu
 */
public class PersistanceController {
    
    /**
     * Method to save all users from a list to the userdata json file
     * @param users
     */
    public static void saveUsers(List<User> users){
        PrintWriter pw = null;
        try {
            new File("FitnessApp/").mkdir();
            File userdata = new File("FitnessApp/userdata.json");
            userdata.createNewFile();
            pw = new PrintWriter(new FileWriter(userdata));
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO OPEN \"userdata.json\" FILE TO SAVE USERS");
        }
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        for(User u : users){
            Map m = new LinkedHashMap();
            
            m.put("email", u.getEmail());
            m.put("password", u.getPassword());
            m.put("firstName", u.getFirstName());
            m.put("lastName", u.getLastName());
            
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
            String dateOfBirth = formatter.format(u.getDob());
            m.put("dob", dateOfBirth);

            m.put("sex", u.getSex().toString());
            m.put("heightUnit", u.getHeightUnit().toString());
            m.put("weightUnit", u.getWeightUnit().toString());

            m.put("tracking", u.isTrackingActivity());
            
            m.put("activityLevel", u.getActivityLevel().toString());

            m.put("goalWeight", Double.toString(u.getGoal().getGoalWeight()));
            m.put("goalType", u.getGoal().getType().toString());
            m.put("goalSpeed", u.getGoal().getGoalSpeed().toString());
            
            m.put("restingHeartRate", Integer.toString(u.getRestingHeartRate()));
            m.put("bodyFatPercentage", Double.toString(u.getBodyFatPercentage()));
            
            ja.add(m);

            //System.out.println("User \"" + u.getFullName() + "\" saved");
        }
        
        jo.put("users", ja);
        
        pw.write(jo.toJSONString());
        
        pw.flush();
        pw.close();
    }
    
    /**
     * Method to load a list of all users from the userdata.json file
     * @return a list of all users
     * @throws FileNotFoundException
     * @throws IOException
     * @throws ParseException
     */
    public static List<User> loadUsers() throws FileNotFoundException, IOException, ParseException{
        Object obj = null;
        new File("FitnessApp/").mkdir();
        File userdata = new File("FitnessApp/userdata.json");
        userdata.createNewFile();
        obj = new JSONParser().parse(new FileReader(userdata));
            
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("users");
        List<User> users = new ArrayList();
        
        Iterator itr2 = ja.iterator();
         
        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();
            
            String firstName = null;
            String lastName = null;
            String email = null;
            String password = null;
            String dob = null;
            String sex = null;
            String heightUnit = null;
            String weightUnit = null;
            String tracking = null;
            String activityLevel = null;
            
            String goalWeight = null;
            String goalType = null;
            String goalSpeed = null;
            
            String restingHeartRate = null;
            String bodyFatPercentage = null;
            
            while (itr1.hasNext()) {
                Map.Entry pair = itr1.next();
                if("firstName".equals(pair.getKey().toString()))
                    firstName = pair.getValue().toString();
                else if("lastName".equals(pair.getKey().toString()))
                    lastName = pair.getValue().toString();
                else if("email".equals(pair.getKey().toString()))
                    email = pair.getValue().toString();
                else if("password".equals(pair.getKey().toString()))
                    password = pair.getValue().toString();
                else if("dob".equals(pair.getKey().toString()))
                    dob = pair.getValue().toString();
                else if("sex".equals(pair.getKey().toString()))
                    sex = pair.getValue().toString();
                else if("heightUnit".equals(pair.getKey().toString()))
                    heightUnit = pair.getValue().toString();
                else if("weightUnit".equals(pair.getKey().toString()))
                    weightUnit = pair.getValue().toString();
                else if("tracking".equals(pair.getKey().toString()))
                    tracking = pair.getValue().toString();
                else if("activityLevel".equals(pair.getKey().toString()))
                    activityLevel = pair.getValue().toString();
                
                else if("goalWeight".equals(pair.getKey().toString()))
                    goalWeight = pair.getValue().toString();
                else if("goalType".equals(pair.getKey().toString()))
                    goalType = pair.getValue().toString();
                else if("goalSpeed".equals(pair.getKey().toString()))
                    goalSpeed = pair.getValue().toString();
                
                else if("restingHeartRate".equals(pair.getKey().toString()))
                    restingHeartRate = pair.getValue().toString();
                else if("bodyFatPercentage".equals(pair.getKey().toString()))
                    bodyFatPercentage = pair.getValue().toString();
            }
            
            User user = null;
            try {
                user = new User(email, password, firstName, lastName, dob, sex, heightUnit, weightUnit, tracking, activityLevel);
            } catch (java.text.ParseException ex) {
                System.out.println("ERROR: UNABLE TO LOAD AND INSTIANIATE NEW USER");
            }
            user.setGoal(new Goal(goalWeight, goalType, goalSpeed));
            try {
            user.setRestingHeartRate(Integer.parseInt(restingHeartRate));
            } catch (Exception e){
                user.setRestingHeartRate(0);
            }
            try {
            user.setBodyFatPercentage(Double.parseDouble(bodyFatPercentage));
            } catch (Exception e){
                user.setBodyFatPercentage(0);
            }
            
            List<HealthData> healthData = null;
            try {
                healthData = loadHealthData(email);
            } catch (Exception ex){
                System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
                healthData = new ArrayList();
            }
            
            List<Activity> activities = null;
            try {
                activities = loadActivities(email);
            } catch (Exception ex){
                System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
                activities = new ArrayList();
            }
            
            List<HealthScore> healthScores = null;
            try {
                healthScores = loadHealthScores(email);
            } catch (Exception ex){
                System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
                healthScores = new ArrayList();
            }
            
            List<Food> foods = null;
            try{
                foods = loadFoods(email);
            }catch (Exception ex){
                System.out.println("ERROR: UNABLE TO LOAD MOST RECENT, THERE MAY BE NO ENTRIES");
                foods = new ArrayList();
            }
        
            user.setDataList(healthData);
            user.setActivityLog(activities);
            user.setHealthScoreLog(healthScores);
            user.setFoodLog(foods);
            
            users.add(user);
         
        }
        
        return users;
    }
    
    /**
     * Method to save the user file containing health data, activities, healthscores and foods
     * @param healthData
     * @param activities
     * @param healthScores
     * @param foods
     * @param email
     */
    public static void saveUserFile(List<HealthData> healthData, List<Activity> activities, List<HealthScore> healthScores, List<Food> foods, String email){
        PrintWriter pw = null;
        try {
            new File("FitnessApp/users").mkdir();
            File userdata = new File("FitnessApp/users/" + email + ".json");
            userdata.createNewFile();
            pw = new PrintWriter(new FileWriter(userdata));
        } catch (Exception ex) {
            System.out.println("ERROR: UNABLE TO OPEN \"" + email + ".json\" FILE TO SAVE DATA");
        }
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();

        for(HealthData hd : healthData){
            Map m = new LinkedHashMap();

            m.put("weight", hd.getWeight());
            m.put("height", hd.getHeight());

            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            String dateTime = formatter.format(hd.getDateTime());
            m.put("dateTime", dateTime);

            ja.add(m);
        }

        jo.put("healthData", ja);
        
        //ACTIVITIES JSON WRITER
        ja = new JSONArray();
        
        for(Activity a : activities){
            Map m = new LinkedHashMap();

            m.put("name", a.getName());
            m.put("duration", a.getDuration());
            m.put("caloriesBurnt", a.getCaloriesBurnt());

            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            String dateTime = formatter.format(a.getDateTime());
            m.put("dateTime", dateTime);

            ja.add(m);
        }
        
        jo.put("activities", ja);
        
        //HEALTHSCORE JSON WRITER
        ja = new JSONArray();
        
        for(HealthScore hs : healthScores){
            Map m = new LinkedHashMap();

            m.put("healthScore", hs.getHealthScore());
            
            m.put("caloriesBurnt", hs.getCaloriesBurnt());
            m.put("caloriesConsumed", hs.getCaloriesConsumed());

            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            String dateTime = formatter.format(hs.getDateTime());
            m.put("dateTime", dateTime);

            ja.add(m);
        }
        
        jo.put("healthScores", ja);
        
        //FOOD JSON WRITER
        ja = new JSONArray();
        
        for(Food f : foods){
            Map m = new LinkedHashMap();

            m.put("name", f.getName());
            m.put("calories", f.getCalories());
            m.put("portion", f.getPortion());
            m.put("meal", f.getMeal().toString());

            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            String dateTime = formatter.format(f.getDateTime());
            m.put("dateTime", dateTime);

            ja.add(m);
        }
      
        jo.put("foods", ja);

        pw.write(jo.toJSONString());

        pw.flush();
        pw.close();

        System.out.println("User \"" + email + "\" data saved");
    }

    /**
     * Method for loading the healthdata part of the user data
     * @param email
     * @return a list of healthdata
     */
    public static List<HealthData> loadHealthData(String email){
        List<HealthData> healthData = new ArrayList();
        Object obj = null;
        
        new File("FitnessApp/users").mkdir();
        File userdata = new File("FitnessApp/users/" + email + ".json");
        try {
            userdata.createNewFile();
        } catch (IOException ex) {
            System.out.println("ERROR: with creating file");
        }
        try {
            obj = new JSONParser().parse(new FileReader(userdata));
        } catch (IOException ex) {
            System.out.println("ERROR: with reading");
        } catch (ParseException ex) {
            System.out.println("ERROR: with parsing");
        }
        
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("healthData");

        Iterator itr2 = ja.iterator();

        String weight = null;
        String height = null;
        String activityLevel = null;
        String dateTime = null;

        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();

            while (itr1.hasNext()) {
            Map.Entry pair = itr1.next();
            if("weight".equals(pair.getKey().toString()))
                weight = pair.getValue().toString();
            else if("height".equals(pair.getKey().toString()))
                height = pair.getValue().toString();
            else if("activityLevel".equals(pair.getKey().toString()))
                activityLevel = pair.getValue().toString();
            else if("dateTime".equals(pair.getKey().toString()))
                dateTime = pair.getValue().toString();
        }
            try {
                healthData.add(new HealthData(weight, height, dateTime));
            } catch (java.text.ParseException ex) {
                System.out.println("ERROR: UNABLE TO LOAD DATA ENTRY INTO LIST");
            }
        }

        System.out.println("User \"" + email + "\" data loaded");
        
        return healthData;
    }
    
    /**
     * Method for loading the activities part of the user data
     * @param email
     * @return list of activities
     */
    public static List<Activity> loadActivities(String email){
        List<Activity> activities = new ArrayList();
        Object obj = null;
        
        new File("FitnessApp/users").mkdir();
        File userdata = new File("FitnessApp/users/" + email + ".json");
        try {
            userdata.createNewFile();
        } catch (IOException ex) {
            System.out.println("ERROR: with creating file");
        }
        try {
            obj = new JSONParser().parse(new FileReader(userdata));
        } catch (IOException ex) {
            System.out.println("ERROR: with reading");
        } catch (ParseException ex) {
            System.out.println("ERROR: with parsing");
        }
        
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("activities");

        Iterator itr2 = ja.iterator();

        String name = null;
        String duration = null;
        String caloriesBurnt = null;
        String dateTime = null;

        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();

            while (itr1.hasNext()) {
            Map.Entry pair = itr1.next();
            if("name".equals(pair.getKey().toString()))
                name = pair.getValue().toString();
            else if("duration".equals(pair.getKey().toString()))
                duration = pair.getValue().toString();
            else if("caloriesBurnt".equals(pair.getKey().toString()))
                caloriesBurnt = pair.getValue().toString();
            else if("dateTime".equals(pair.getKey().toString()))
                dateTime = pair.getValue().toString();
        }
            try {
                activities.add(new Activity(name, duration, caloriesBurnt, dateTime));
            } catch (java.text.ParseException ex) {
                System.out.println("ERROR: UNABLE TO LOAD DATA ENTRY INTO LIST");
            }
        }

        System.out.println("User \"" + email + "\" data loaded");
        
        return activities;
    }
    
    /**
     * Method for loading the healthscore part of the user data
     * @param email
     * @return a list of health score
     */
    public static List<HealthScore> loadHealthScores(String email){
        List<HealthScore> healthScores = new ArrayList();
        Object obj = null;
        
        new File("FitnessApp/users").mkdir();
        File userdata = new File("FitnessApp/users/" + email + ".json");
        try {
            userdata.createNewFile();
        } catch (IOException ex) {
            System.out.println("ERROR: with creating file");
        }
        try {
            obj = new JSONParser().parse(new FileReader(userdata));
        } catch (IOException ex) {
            System.out.println("ERROR: with reading");
        } catch (ParseException ex) {
            System.out.println("ERROR: with parsing");
        }
        
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("healthScores");

        Iterator itr2 = ja.iterator();

        String healthScore = null;
        String caloriesBurnt = null;
        String caloriesConsumed = null;
        String dateTime = null;

        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();

            while (itr1.hasNext()) {
            Map.Entry pair = itr1.next();
            if("healthScore".equals(pair.getKey().toString()))
                healthScore = pair.getValue().toString();
            else if("caloriesBurnt".equals(pair.getKey().toString()))
                caloriesBurnt = pair.getValue().toString();
            else if("caloriesConsumed".equals(pair.getKey().toString()))
                caloriesConsumed = pair.getValue().toString();
            else if("dateTime".equals(pair.getKey().toString()))
                dateTime = pair.getValue().toString();
        }
            try {
                healthScores.add(new HealthScore(healthScore, caloriesBurnt, caloriesConsumed, dateTime));
            } catch (java.text.ParseException ex) {
                System.out.println("ERROR: UNABLE TO LOAD DATA ENTRY INTO LIST");
            }
        }

        System.out.println("User \"" + email + "\" data loaded");
        
        return healthScores;
    }
    
    /**
     * Method for loading the food part of the user data
     * @param email
     * @return a list of foods
     */
    public static List<Food> loadFoods(String email){
        List<Food> foods = new ArrayList();
        Object obj = null;
        
        new File("FitnessApp/users").mkdir();
        File userdata = new File("FitnessApp/users/" + email + ".json");
        try {
            userdata.createNewFile();
        } catch (IOException ex) {
            System.out.println("ERROR: with creating file");
        }
        try {
            obj = new JSONParser().parse(new FileReader(userdata));
        } catch (IOException ex) {
            System.out.println("ERROR: with reading");
        } catch (ParseException ex) {
            System.out.println("ERROR: with parsing");
        }
        
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("foods");

        Iterator itr2 = ja.iterator();

        String name = null;
        String calories = null;
        String portion = null;
        String dateTime = null;
        String meal = null;
        
        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();

            while (itr1.hasNext()) {
            Map.Entry pair = itr1.next();
            if("name".equals(pair.getKey().toString()))
                name = pair.getValue().toString();
            else if("calories".equals(pair.getKey().toString()))
                calories = pair.getValue().toString();
            else if("portion".equals(pair.getKey().toString()))
                portion = pair.getValue().toString();
            else if("dateTime".equals(pair.getKey().toString()))
                dateTime = pair.getValue().toString();
            else if("meal".equals(pair.getKey().toString()))
                meal = pair.getValue().toString();
        }
            try {
                foods.add(new Food(name, calories, portion, dateTime, meal));
            } catch (java.text.ParseException ex) {
                System.out.println("ERROR: UNABLE TO LOAD DATA ENTRY INTO LIST");
            }
        }

        System.out.println("User \"" + email + "\" data loaded");
        
        return foods;
    }
}
