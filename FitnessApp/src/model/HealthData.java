/**
 * HealthData stores the user's data
 * @author 100021268 100122248 100137721 100090034
 */
package model;

import java.util.Date;

public class HealthData {
    private final double weightKG;
    private final double heightCM;
    private final ActivityLevel activityLevel;
    private final Date dateTime;
    //List<Double> dailyCalories;
    
    public static enum ActivityLevel{NoExercise, LightExercise, ModerateExercise, HardExercise, VeryHardExercise}
    
    public HealthData(double weightKG, double heightCM, ActivityLevel activityLevel, Date dateTime){
        this.weightKG = weightKG;
        this.heightCM = heightCM;
        this.activityLevel = activityLevel;
        this.dateTime = dateTime;
    }
    
    double getWeight(){
        return weightKG;
    }
    
    double getHeight(){
        return heightCM;
    }
    
    Date getDateTime(){
        return dateTime;
    }
}
