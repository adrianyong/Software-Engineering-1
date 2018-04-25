/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import model.HealthData;

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
            m.put("height", u.getHeight().toString());
            m.put("weight", u.getWeight().toString());

            m.put("tracking", u.isTrackingActivity());
            
            m.put("activityLevel", u.getActivityLevel());

            ja.add(m);

            //System.out.println("User \"" + u.getFullName() + "\" saved");
        }
        
        jo.put("users", ja);
        
        pw.write(jo.toJSONString());
        
        pw.flush();
        pw.close();
    }
    
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
            String height = null;
            String weight = null;
            String tracking = null;
            String activityLevel = null;
            
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
                else if("height".equals(pair.getKey().toString()))
                    height = pair.getValue().toString();
                else if("weight".equals(pair.getKey().toString()))
                    weight = pair.getValue().toString();
                else if("tracking".equals(pair.getKey().toString()))
                    tracking = pair.getValue().toString();
                else if("activityLevel".equals(pair.getKey().toString()))
                    activityLevel = pair.getValue().toString();
            }
            
            User user = null;
            try {
                user = new User(email, password, firstName, lastName, dob, sex, height, weight, tracking, activityLevel);
            } catch (java.text.ParseException ex) {
                System.out.println("ERROR: UNABLE TO LOAD AND INSTIANIATE NEW USER");
            }
            users.add(user);
           
            //System.out.println("User \"" + user.getFullName() + "\" loaded");
        }
        
        return users;
    }
    
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
    
    public static void saveHealthData(List<HealthData> healthData, String email){
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

        pw.write(jo.toJSONString());

        pw.flush();
        pw.close();

        System.out.println("User \"" + email + "\" data saved");
    }

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
            System.out.println("ERROR: wutg parsing");
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
    
    public static void addHealthData(HealthData data, String email){
        System.out.println("Adding new data for " + email);
        
        List<HealthData> healthData;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            healthData = new ArrayList();
        }
        healthData.add(data);
        saveHealthData(healthData, email);
        
        System.out.println("New health data added");
    }
    
    public static HealthData getMostRecentData(String email){
        List<HealthData> healthData = null;
        try {
            healthData = loadHealthData(email);
        } catch (Exception ex){
            System.out.println("ERROR: UNABLE TO LOAD MOST RECENT");
        }
        return healthData.get(healthData.size()-1);
    }
}
