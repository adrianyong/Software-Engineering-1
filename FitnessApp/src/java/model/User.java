/**
 * User stores the users data for the login MERGE TEST
 * @authors 100021268, 100122248, 100137721,100090034
 */

package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Date dob;
    private final Sex sex;
    private final Height height;
    private final Weight weight;
    private Goal goal;
    private boolean isTrackingActivity;
    private ActivityLevel activityLevel;
    
    private boolean admin;
    
    public static enum Sex{Male, Female}
    public static enum Height{cm, feetInches}
    public static enum Weight{kg, pound, stonePound}
    public static enum ActivityLevel{NoExercise, LightExercise, ModerateExercise, HardExercise, VeryHardExercise}
    
    public User(String email, String password, String firstName, String lastName, Date dob, Sex sex, Height height, Weight weight, boolean isTrackingActivity, ActivityLevel activityLevel){
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.sex = sex;
        this.height = height;
        this.weight = weight;
        this.isTrackingActivity = isTrackingActivity;
        this.activityLevel = activityLevel;
        
        this.admin = false;
        
        //this.dataList = new ArrayList();
    }
    
    public User(String email, String password, String firstName, String lastName, String dobs, String sexs, String heights, String weights, String isTrackingActivity, String activityLevel) throws ParseException{
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        this.dob = formatter.parse(dobs);
        
        this.sex = Sex.valueOf(sexs);
        this.height = Height.valueOf(heights);
        this.weight = Weight.valueOf(weights);
        
        this.isTrackingActivity = Boolean.parseBoolean(isTrackingActivity);
        
        this.activityLevel = ActivityLevel.valueOf(activityLevel);
        
        //this.dataList = new ArrayList();
    }
    
    /*public void updateData(double weight, double height, String activityLevel){
        if(!isMetric){
            weight = Conversions.weightLbsToKG(weight);
            height = Conversions.heightToCM(height);
        }
        dataList.add(new HealthData(weight, height, activityLevel));
    }
    
    public void updateData(double weight, double height, String activityLevel, String dateTime) throws ParseException{
        if(!isMetric){
            weight = Conversions.weightLbsToKG(weight);
            height = Conversions.heightToCM(height);
        }
        dataList.add(new HealthData(weight, height, activityLevel, dateTime));
    }*/
    
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
    
//    public List<HealthData> getDataList(){
//        return dataList;
//    }
    
    public Goal getGoal(){
        return goal;
    }
    
    /*public boolean isMetric(){
        return isMetric;
    }
    
    public void setMetricPreference(boolean isMetric){
        this.isMetric = isMetric;
    }*/
    
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
    
    @Override
    public String toString(){
        return email + "," + password + "," + firstName + "," + lastName + "," + getDobString() + "," + sex + "," + height+ "," + weight + "," + isTrackingActivity + "," + admin + "," + activityLevel;
    }

    /**
     * @return the height
     */
    public Height getHeight() {
        return height;
    }

    /**
     * @return the weight
     */
    public Weight getWeight() {
        return weight;
    }
}
