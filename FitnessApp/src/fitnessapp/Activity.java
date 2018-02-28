/**
 * Activity generates a fitness routine for the user and tracks their activity in the routine
 * @author 100021268 100122248 100137721 100090034
 */
package fitnessapp;

import java.util.ArrayList;

public class Activity {
    ActivityTemplate activity;
    int heartRate;
    double duration;
    String activityType;
    double userWeight;
    double caloriesBurnt;
    ArrayList activityLog;
    double goalActivityDuration;
    int goalCalorieBurn;
    
    Activity(){
        //creates Activity type object utilising the activity template and the 
        //users inputted data for the activityLogger
    }
    
    void getHeartRate(){
        //return type int of average heart rate throughout activity
    }
    
    void getDuration(){
        //return type double of time for activity duration
    }
    
    void getActivityTemplate(){
        //return type ActivityTemplate from Activity Template 
    }
    
    void getWeight(){
        //returns weight in double from User.healthData
    }
    
    void calculateCalorieBurn(){
        //returns and calculates calories burnt as a double utilises 
        //ActivityTemplate
    }
}
