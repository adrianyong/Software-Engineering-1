/**
 * Activity generates a fitness routine for the user and tracks their activity in the routine
 * @author 100021268 100122248 100137721 100090034
 */
package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public final class Activity {
    private String name;
    private double duration;
    private double caloriesBurnt;
    private Date dateTime;
    
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
        this.caloriesBurnt = caloriesBurnt*durationIn;
        this.duration = durationIn;
        this.dateTime = new Date();
    }
    
    public List<ActivityTemplate> getActivityList(){
        return new ArrayList();
    }

    public ActivityTemplate getActivityTemplate(String activityName){
        List<ActivityTemplate> activitiesList = getActivityList();
        for (ActivityTemplate a : activitiesList){
            if(a.name.equals(activityName)){ 
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
    
}
    


