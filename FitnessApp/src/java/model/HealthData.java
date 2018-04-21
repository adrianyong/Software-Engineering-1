 /**
 * HealthData stores the user's data
 * @author 100021268 100122248 100137721 100090034
 */
package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HealthData {
    private final double weightKG;
    private final double heightCM;
    private final ActivityLevel activityLevel;
    private final Date dateTime;
    //List<Double> dailyCalories;
    
    public static enum ActivityLevel{NoExercise, LightExercise, ModerateExercise, HardExercise, VeryHardExercise}
    
    public HealthData(double weightKG, double heightCM, String activityLevel){
        this.weightKG = weightKG;
        this.heightCM = heightCM;
        this.activityLevel = ActivityLevel.valueOf(activityLevel);
        this.dateTime = new Date();
    }
    
    public HealthData(String weightKG, String heightCM, String activityLevel, String dateTimes) throws ParseException{
        this.weightKG = Double.parseDouble(weightKG);
        this.heightCM = Double.parseDouble(heightCM);
        this.activityLevel = ActivityLevel.valueOf(activityLevel);
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date dateTime = formatter.parse(dateTimes);
        this.dateTime = dateTime;
    }
    
    public double getWeight(){
        return weightKG;
    }
    
    public double getHeight(){
        return heightCM;
    }
    
    public ActivityLevel getActivityLevel(){
        return activityLevel;
    }
    
    public Date getDateTime(){
        return dateTime;
    }
    
    @Override
    public String toString(){
        return "" + weightKG + heightCM + activityLevel + dateTime;
    }
}
