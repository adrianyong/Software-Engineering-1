/**
 * Activity Template is inherited from the Activity class
 * @author 100021268 100122248 100137721 100090034
 */

package model;

public class ActivityTemplate {
    
    Enum type;
    double templateDuration;
    double templateCaloriesBurnt;
    
    ActivityTemplate(){
        //constructs ActivityTemplate, does this by pulling it from a database
    }
    
    void getTemplateDuration(){
        //returns double of duration from the ActivityTemplate object
    }
    
    void getTemplateCaloriesBurnt(){
        //returns double of calories burnt from the ActivityTemplate object
    }
    
    void getTemplateType(){
        //returns type of activity from the Activitytemplate object (name) 
    }
}
