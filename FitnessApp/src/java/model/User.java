/**
 * User stores the users data for the login MERGE TEST
 * @authors 100021268, 100122248, 100137721,100090034
 */

package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class User {
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Date dob;
    private final Sex sex;
    private HeightUnit heightUnit;
    private WeightUnit weightUnit;
    private boolean isTrackingActivity;
    private ActivityLevel activityLevel;
  
    private Goal goal;
    private List<HealthData> dataList;
    private List<Activity> activityLog; 
    private List<HealthScore> healthScoreLog; 
    private List<Food> foodLog; 
    
    private int restingHeartRate;
    private double bodyFatPercentage;
    
    private boolean admin;
    
    public static enum Sex{Male, Female}
    public static enum HeightUnit{cm, feetInches}
    public static enum WeightUnit{kg, pound, stonePound}
    public static enum ActivityLevel{NoExercise, LightExercise, ModerateExercise, HardExercise, VeryHardExercise}
    
    public User(String email, String password, String firstName, String lastName, Date dob, Sex sex, HeightUnit height, WeightUnit weight, boolean isTrackingActivity, ActivityLevel activityLevel){
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.sex = sex;
        this.heightUnit = height;
        this.weightUnit = weight;
        this.isTrackingActivity = isTrackingActivity;
        this.activityLevel = activityLevel;
        
        this.admin = false;
    }
    
    public User(String email, String password, String firstName, String lastName, String dobs, String sexs, String heights, String weights, String isTrackingActivity, String activityLevel) throws ParseException{
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        this.dob = formatter.parse(dobs);
        
        this.sex = Sex.valueOf(sexs);
        this.heightUnit = HeightUnit.valueOf(heights);
        this.weightUnit = WeightUnit.valueOf(weights);
        
        this.isTrackingActivity = Boolean.parseBoolean(isTrackingActivity);
        
        this.activityLevel = ActivityLevel.valueOf(activityLevel);
    }
    
    public boolean login(String email, String password){
        return this.email.equals(email) && this.password.equals(password);
    }
    
    public String getEmail(){
        return email;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    public String getPassword(){
        return password;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    
    public String getFirstName(){
        return firstName;
    }
    
    public void setFirstName(String firstName){
        this.firstName = firstName;
    }
    
    public String getLastName(){
        return lastName;
    }
    
    public void setLastName(String lastName){
        this.lastName = lastName;
    }
    
    public String getFullName(){
        return firstName + " " + lastName;
    }
    
    public Date getDob(){
        return dob;
    }
    
    public String getDobString(){
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
        return formatter.format(dob);
    }
    
    public void setDob(Date dob){
        this.dob = dob;
    }
    
    public int getAge(){
        Date currentDate = new Date();
        long age = currentDate.getTime()-dob.getTime();
        age = (age/1000/60/60/24/365); //Converts age in 
        return (int) age;
    }
    
    public Sex getSex(){
        return sex;
    }
    
    public void setGoal(Goal goal){
        this.goal = goal;
    }
    
    public Goal getGoal(){
        return goal;
    }
    
    public boolean isTrackingActivity(){
        return isTrackingActivity;
    }
    
    public void setTrackingPreference(boolean isTrackingActivity){
        this.isTrackingActivity = isTrackingActivity;
    }
    
    public ActivityLevel getActivityLevel() {
        return activityLevel;
    }

    public void setActivityLevel(ActivityLevel activityLevel) {
        this.activityLevel = activityLevel;
    }
    
    public void setActivityLevel(String activityLevel) {
        this.activityLevel = ActivityLevel.valueOf(activityLevel);
    }
    
    public void setDataList(List<HealthData> dataList){
        this.dataList = dataList;
    }
    
    public List<HealthData> getDataList(){
        return dataList;
    }
    
    public double getWeight(){
        return dataList.get(dataList.size() - 1).getWeight();
    }
    
    public double getHeight(){
        return dataList.get(dataList.size() - 1).getHeight();
    }
    
    public double getBMI(){
        double weight = getWeight();
        double height = getHeight();
        return Calculations.BMI(weight, height);
    }
    
    public double getBMR(){
        return Calculations.BMR(this);
    }

    /**
     * @return the height
     */
    public HeightUnit getHeightUnit() {
        return heightUnit;
    }

    /**
     * @param heightUnit the heightUnit to set
     */
    public void setHeightUnit(HeightUnit heightUnit) {
        this.heightUnit = heightUnit;
    }
    
    /**
     * @return the weight
     */
    public WeightUnit getWeightUnit() {
        return weightUnit;
    }

    /**
     * @param weightUnit the weightUnit to set
     */
    public void setWeightUnit(WeightUnit weightUnit) {
        this.weightUnit = weightUnit;
    }
    
    /**
     * @return the restingHeartRate
     */
    public int getRestingHeartRate() {
        return restingHeartRate;
    }

    /**
     * @param restingHeartRate the restingHeartRate to set
     */
    public void setRestingHeartRate(int restingHeartRate) {
        this.restingHeartRate = restingHeartRate;
    }

    /**
     * @return the bodyFatPercentage
     */
    public double getBodyFatPercentage() {
        return bodyFatPercentage;
    }

    /**
     * @param bodyFatPercentage the bodyFatPercentage to set
     */
    public void setBodyFatPercentage(double bodyFatPercentage) {
        this.bodyFatPercentage = bodyFatPercentage;
    }
    
    public void addActivity(String name, double duration){
        activityLog.add(new Activity(this, name, duration));
    }
    
//    public void removeActivity(){
//        //removes Activity type object from activityLog list
//        //returns Activity type object which was removed
//    }
    
    public List<Activity> getActivityLog(){
        return activityLog;
    }
    
    public void setActivityLog(List<Activity> activityLog){
        this.activityLog = activityLog;
    }
    
    public void clearActivityLog(){
        /*clears the activityLog list of all Activity objects
        *returns ArrayList<Activity> previousActivityLog containing the 
        *list which was removed from the activityLog chosen to return this
        *incase of archiving reasons
        */
    }
    
    //Health Score Methods
    public void addHealthScore(){
        healthScoreLog.add(new HealthScore(this));
    }
    
    public void addCaloriesBurnt(){
        
    }
    
    public void addCaloriesConsumed(){
        
    }
    
    public List<HealthScore> getHealthScoreLog(){
        return healthScoreLog;
    }
    
    public void setHealthScoreLog(List<HealthScore> healthScoreLog){
        this.healthScoreLog = healthScoreLog;
    } 
    
    //Food Methods
    public void addFood(String nameIn, double portionIn, Food.Meal mealIn){
        foodLog.add(new Food(nameIn, portionIn, mealIn));
    }
    
    public List<Food> getFoodLog(){
        return foodLog;
    }
    
    public void setFoodLog(List<Food> foodLog){
        this.foodLog = foodLog;
    }
    
    @Override
    public String toString(){
        return email + "," + password + "," + firstName + "," + lastName + "," + getDobString() + "," + sex + "," + heightUnit+ "," + weightUnit + "," + isTrackingActivity + "," + admin + "," + activityLevel;
    }
}
