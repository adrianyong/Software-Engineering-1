/**
 * Activity Template is inherited from the Activity class
 * @author 100021268 100122248 100137721 100090034 
 */

//note - activite calorie burn should be input for 60 minute duration
//ensure this is explained on admin activity entry

package model;

public class ActivityTemplate {
    String name = "";
    int caloriesBand1 = 0;
    int caloriesBand2 = 0;
    int caloriesBand3 = 0;


    
    ActivityTemplate(String activityName, int weight1Cals, int weight2Cals, int weight3Cals){
        name = activityName;
        caloriesBand1 = weight1Cals;
        caloriesBand2 = weight2Cals;
        caloriesBand3 = weight3Cals;
    }
    
    int getWeightBand1Cals(){
        return caloriesBand1;
    }  
    
    int getWeightBand2Cals(){
        return caloriesBand2;
    }  
    
    int getWeightBand3Cals(){
        return caloriesBand3;
    }
    
    String getActivityName(){
       return name;
    }
}

