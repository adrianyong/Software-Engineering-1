/**
 * Goal allows the user to set a time goal for their fitness endeavours 
 * @author 100021268 100122248 100137721 100090034
 */
package model;

public class Goal {
    public static enum GoalType{GainWeight, LoseWeight, MaintainWeight}
    public static enum GoalSpeed{Slow, Average, Aggressive}
    
    private double goalWeight;
    private GoalType goal;
    private GoalSpeed speed;
    
    Goal(double goalWeight, GoalType goal, GoalSpeed speed){
        this.goalWeight = goalWeight;
        this.goal=goal;
        this.speed=speed;
    }
    
    Goal(String goalWeight, String goal, String speed){
        this.goalWeight = Double.parseDouble(goalWeight);
        this.goal=GoalType.valueOf(goal);
        this.speed=GoalSpeed.valueOf(speed);
    }
    
    public void setGoalWeight(double goalWeight){
        this.goalWeight = goalWeight;
    }
    
    public double getGoalWeight(){
        return goalWeight;
    }
    
    public void setGoal(GoalType goal){
        this.goal = goal;
    }
    
    public GoalType getType(){
        return goal;
        //return Type of goal
    }
    
    public void setGoalSpeed(GoalSpeed speed){
        this.speed = speed;
    }
    
    public GoalSpeed getGoalSpeed(){
        return speed;
        //return int of time span allowed
    }
    
    @Override
    public String toString(){
        return goalWeight + goal.toString() + speed.toString();
    }
}
