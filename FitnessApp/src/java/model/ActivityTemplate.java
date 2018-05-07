/**
 * Activity Template is inherited from the Activity class
 * @author 100021268 100122248 100137721 100090034 
 */

//note - activite calorie burn should be input for 60 minute duration
//ensure this is explained on admin activity entry

package model;

public class ActivityTemplate {
    String name = "";
    int weightBand1Cals = 0;
    int weightBand2Cals = 0;
    int weightBand3Cals = 0;


    
    ActivityTemplate(String activityName, int weight1Cals, int weight2Cals, int weight3Cals){
name = activityName;
    weightBand1Cals = weight1Cals;
    weightBand2Cals = weight2Cals;
    weightBand3Cals = weight3Cals;
    }
    
    int getWeightBand1Cals(){
        return weightBand1Cals;
    }  
    
    int getWeightBand2Cals(){
        return weightBand2Cals;
    }  
    
    int getWeightBand3Cals(){
        return weightBand3Cals;
    }
    
    String getActivityName(){
       return name;
    }
}

