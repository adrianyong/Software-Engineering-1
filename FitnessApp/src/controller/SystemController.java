/**
 * FitnessApp is the main method 
 * @author 100021268 100122248 100137721 100090034
 */
package controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import model.*;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class SystemController {

    private static List<User> users = new ArrayList<User>();

    public static void main(String[] args) throws FileNotFoundException, IOException, ParseException, java.text.ParseException {
        if(users.isEmpty()){
            System.out.println("No users found! Please create user.\n");
        }
        User newUser = newUser();
        users.add(newUser);
        newUser.updateData(70, 180, HealthData.ActivityLevel.LightExercise);
        newUser.updateData(80, 180, HealthData.ActivityLevel.NoExercise);
        newUser.updateData(80, 200, HealthData.ActivityLevel.ModerateExercise);
        
        System.out.println(newUser);
        
        writeTest(newUser);
        writeData(newUser);
        User oldUser = readTest();
        
        System.out.println(oldUser);
    }
    
    public static void writeData(User user) throws FileNotFoundException{
        JSONObject jo = new JSONObject();
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
        
        int i = 0;
        for(HealthData hd : user.getDataList()){
            Map data = new LinkedHashMap();
            
            data.put("weight", hd.getWeight());
            data.put("height", hd.getHeight());
            data.put("activity", hd.getActivityLevel().toString());
            
            String date = formatter.format(hd.getDateTime());
            data.put("dateTime", date);
            
            jo.put("data" + i, data);
            
            i++;
        }
        
        PrintWriter pw = new PrintWriter("users/ " + user.getEmail() + ".json");
        pw.write(jo.toJSONString());
        pw.flush();
        pw.close();
    }
    
    public static void writeTest(User user) throws FileNotFoundException{
        // creating JSONObject
        JSONObject jo = new JSONObject();
         
        // putting data to JSONObject
        jo.put("firstName", user.getFirstName());
        jo.put("lastName", user.getLastName());
        jo.put("email", user.getEmail());
        jo.put("password", user.getPassword());
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
        String dateOfBirth = formatter.format(user.getDOB());
        jo.put("dob", dateOfBirth);
        
        jo.put("sex", user.getSex().toString());
        
        jo.put("metric", user.isMetric());
        jo.put("tracking", user.isTrackingActivity());
        
        PrintWriter pw = new PrintWriter("userdata.json");
        pw.write(jo.toJSONString());
        
        System.out.println("User \"" + user.getFullName() + "\" saved\n");
        
        pw.flush();
        pw.close();
    }
    
    public static User readTest() throws FileNotFoundException, IOException, ParseException, java.text.ParseException{
        // parsing file "JSONExample.json"
        Object obj = new JSONParser().parse(new FileReader("userdata.json"));
         
        // typecasting obj to JSONObject
        JSONObject jo = (JSONObject) obj;
         
        // getting fields
        String firstName = (String) jo.get("firstName");
        String lastName = (String) jo.get("lastName");
        String email = (String) jo.get("email");
        String password = (String) jo.get("password");
        
        String dobs = (String) jo.get("dob");
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Date dob = formatter.parse(dobs);
        
        String sexs = (String) jo.get("sex");
        User.Sex sex = User.Sex.valueOf(sexs);
        
        boolean metric = (boolean) jo.get("metric");
        boolean tracking = (boolean) jo.get("tracking");
        
        User user = new User(firstName, lastName, email, password, dob, sex, metric, tracking);

        System.out.println("User \"" + user.getFullName() + "\" loaded\n");
        
        return user;
    }
    
    public static User newUser(){
        String email = "bentownsend1997@gmail.com";
        String password = "password";
        String firstName = "Ben";
        String surname = "Townsend";
        Date dateOfBirth = new GregorianCalendar(1997, Calendar.MARCH, 16).getTime();
        User.Sex sex = User.Sex.Male;
        boolean isMetric = true;
        boolean trackActivity = false;
        
        User testUser = new User(firstName, surname, email, password, dateOfBirth, sex, isMetric, trackActivity);
        System.out.println("New User \"" + testUser.getFullName() + "\" created.\n");
        return testUser;
    }
    
}
