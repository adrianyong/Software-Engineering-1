/**
 * Goal allows the user to set a time goal for their fitness endeavours 
 * @author 100021268 100122248 100137721 100090034
 */
package model;

public class Goal {
    
    private GoalType goal;
    
    public static enum GoalType{GainWeight, LoseWeight, MaintainWeight}
    private int timeSpan;
    
    
    GoalType getType(){
        return goal;
        //return Type of goal
    }
    
    int getTimeSpan(){
        
        return timeSpan;
        //return int of time span allowed
    }
}
