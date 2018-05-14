/**
 * Goal allows the user to set a time goal for their fitness endeavours 
 * @author 100021268 100122248 100137721 100090034
 */
package model;

import static java.lang.Math.abs;

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
    
    public Goal(double goalWeight, String goalType, String goalSpeed){
        this.goalWeight = goalWeight;
        this.goalType=GoalType.valueOf(goalType);
        this.goalSpeed=GoalSpeed.valueOf(goalSpeed);
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
    
    //returns the amount of days left to reach goal with current goalSpeed
    public double getGoalCompletion(User u){
        double deltaWeight;
        double goalSpeedHere = 0;
        if(null != goalSpeed)switch (goalSpeed) {
            case Aggressive:
                goalSpeedHere = 0.9;
                break;
            case Average:
                goalSpeedHere = 0.45;
                break;
            case Slow:
                goalSpeedHere = 0.225;
                break;
            default:
                break;
        }
        deltaWeight = goalWeight - u.getWeight();
        deltaWeight = deltaWeight/goalSpeedHere;
        return abs(deltaWeight*7);
    }
    
    public double getModifiedBMR(User u){
        double BMR = u.getBMR();
        if(goalType==GoalType.GainWeight){
            if(null!=goalSpeed)
                switch (goalSpeed) {
                case Aggressive:
                    return BMR + 1000;
                case Average:
                    return BMR + 500;
                case Slow:
                    return BMR + 250;
                default:
                    break;
            }
        }
        else if(goalType==GoalType.LoseWeight){
            if(null!=goalSpeed)
                switch (goalSpeed) {
                case Aggressive:
                    return BMR - 1000;
                case Average:
                    return BMR - 500;
                case Slow:
                    return BMR - 250;
                default:
                    break;
            }
        }
        
        return BMR; 
    }
    
    @Override
    public String toString(){
        return goalWeight + goalType.toString() + goalSpeed.toString();
    }
}
