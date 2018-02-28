/**
 * Activity Logger logs the previous activities done
 * @author 100021268 100122248 100137721 100090034
 */
package fitnessapp;

import java.util.ArrayList;

public class ActivityLogger {
    
    Activity activity;
    ArrayList<Activity> activityLog; 
    
    ActivityLogger(){
        //automatically makes the activityLog list when initialised
    }
    
    void getActivity(){
        //returns Activity type object from activityLog list
    }
    
    void addActivity(){
        //adds Activity type object into activityLog list
    }
    
    void removeActivity(){
        //removes Activity type object from activityLog list
        //returns Activity type object which was removed
    }
    
    void clearActivityLog(){
        /*clears the activityLog list of all Activity objects
        *returns ArrayList<Activity> previousActivityLog containing the 
        *list which was removed from the activityLog chosen to return this
        *incase of archiving reasons
        */
    }
}
