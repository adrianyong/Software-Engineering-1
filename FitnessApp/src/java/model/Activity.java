/**
 * Activity generates a fitness routine for the user and tracks their activity in the routine
 * @author 100021268 100122248 100137721 100090034
 */
package model;

import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public final class Activity {
    private final String name;
    private final double duration;
    private double caloriesBurnt;
    private final Date dateTime;
    
    public Activity(User u, String nameIn, double durationIn){
        this.name = nameIn;
        ActivityTemplate a = getActivityTemplate(name);
        if(u.getWeight()<70.3068){
            caloriesBurnt = a.getWeightBand1Cals();
        }
        else if  (u.getWeight()<83.9146){
            caloriesBurnt = a.getWeightBand2Cals();
        }
        else {
            caloriesBurnt = a.getWeightBand3Cals();
        }
        this.caloriesBurnt = (caloriesBurnt*(durationIn/60))*2;
        this.duration = durationIn;
        this.dateTime = new Date();
    }
    
    public Activity(String name, String duration, String caloriesBurnt, String dateTimes) throws java.text.ParseException{
        this.name = name;
        
        this.duration = Double.parseDouble(duration);
        this.caloriesBurnt = Double.parseDouble(caloriesBurnt);
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date dateTime = formatter.parse(dateTimes);
        this.dateTime = dateTime;
    }
    
    public static List<ActivityTemplate> getActivityList(){
        List<ActivityTemplate> activityTemplates = new ArrayList();
        Object obj = null;
        
        try {
            obj = new JSONParser().parse(new FileReader("FitnessApp/ActivityTemplates.json"));
        } catch (IOException ex) {
            System.out.println("ERROR: with reading");
        } catch (ParseException ex) {
            System.out.println("ERROR: with parsing");
        }
        
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("Activities");

        Iterator itr2 = ja.iterator();

        String name = null;
        String caloriesBand1 = null;
        String caloriesBand2 = null;
        String caloriesBand3 = null;

        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();

            while (itr1.hasNext()) {
            Map.Entry pair = itr1.next();
            if("name".equals(pair.getKey().toString()))
                name = pair.getValue().toString();
            else if("caloriesBand1".equals(pair.getKey().toString()))
                caloriesBand1 = pair.getValue().toString();
            else if("caloriesBand2".equals(pair.getKey().toString()))
                caloriesBand2 = pair.getValue().toString();
            else if("caloriesBand3".equals(pair.getKey().toString()))
                caloriesBand3 = pair.getValue().toString();
        }
            activityTemplates.add(new ActivityTemplate(name, Integer.parseInt(caloriesBand1), Integer.parseInt(caloriesBand2), Integer.parseInt(caloriesBand3)));
        }
        return activityTemplates;
    }

    public ActivityTemplate getActivityTemplate(String activityName){
        List<ActivityTemplate> activitiesList = getActivityList();
        for (ActivityTemplate a : activitiesList){
            if(a.getActivityName().equals(activityName)){ 
                return a;
            }
        }
        return null;
    }
    
    //Getters
    public String getName(){
        return name;
    }    
    
    public double getDuration(){
        return duration;
    }

    public double getCaloriesBurnt(){
        return caloriesBurnt;
    }

    public Date getDateTime(){
        return dateTime;
    }    
    
    @Override
    public String toString(){
        return name + "," + duration + "," + caloriesBurnt + "," + dateTime.toString();
    }
    
}