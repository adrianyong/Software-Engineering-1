/**
 * Goal allows the user to set a time goal for their fitness endeavours 
 * @author 100021268 100122248 100137721 100090034
 */
package model;

public class Goal {
    public static enum GoalType{GainWeight, LoseWeight, MaintainWeight}
    public static enum GoalSpeed{Slow, Average, Aggressive}
    
    private double goalWeight;
    private GoalType goalType;
    private GoalSpeed goalSpeed;
    
    public Goal(double goalWeight, GoalType goalType, GoalSpeed goalSpeed){
        this.goalWeight = goalWeight;
        this.goalType=goalType;
        this.goalSpeed=goalSpeed;
    }
    
    public Goal(String goalWeight, String goalType, String goalSpeed){
        this.goalWeight = Double.parseDouble(goalWeight);
        this.goalType=GoalType.valueOf(goalType);
        this.goalSpeed=GoalSpeed.valueOf(goalSpeed);
    }
    
    public void setGoalWeight(double goalWeight){
        this.goalWeight = goalWeight;
    }
    
    public double getGoalWeight(){
        return goalWeight;
    }
    
    public void setGoal(GoalType goal){
        this.goalType = goal;
    }
    
    public GoalType getType(){
        return goalType;
        //return Type of goal
    }
    
    public void setGoalSpeed(GoalSpeed speed){
        this.goalSpeed = speed;
    }
    
    public GoalSpeed getGoalSpeed(){
        return goalSpeed;
        //return int of time span allowed
    }
    
    @Override
    public String toString(){
        return goalWeight + goalType.toString() + goalSpeed.toString();
    }
}
