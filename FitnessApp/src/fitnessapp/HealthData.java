/**
 * HealthData stores the user's data
 * @author 100021268 100122248 100137721 100090034
 */
package fitnessapp;

import java.util.Date;
import java.util.List;

public class HealthData {
    double weightKG;
    double heightCM;
    Enum activityLevel;
    boolean isMetric;
    Date dateTime;
    List<Double> dailyCalories;
    
    void getWeight(){
        //returns type double weight //getter
    }
    
    void getHeight(){
        //returns type double  height //getter
    }
    
    void getTime(){
        //return type Date of time health data was created (for graphs) 
        //do research as to whether we can store date time 
    }
}
