/**
 * User stores the users data for the login MERGE TEST
 * @authors 100021268, 100122248, 100137721,100090034
 */

package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Date dob;
    private final Sex bioSex;
    private Goal goal;
    private boolean isMetric;
    private boolean isTrackingActivity;
    
    private List<HealthData> dataList;
    
    public static enum Sex{Male, Female}
    
    public User(String firstName, String lastName, String email, String password, Date dob, Sex sex, boolean isMetric, boolean isTrackingActivity){
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.bioSex = sex;
        this.isMetric = isMetric;
        this.isTrackingActivity = isTrackingActivity;
        
        this.dataList = new ArrayList();
    }
    
    public void updateData(double weight, double height, HealthData.ActivityLevel activityLevel){
        if(!isMetric){
            weight = Conversions.weightLbsToKG(weight);
            height = Conversions.heightToCM(height);
        }
        dataList.add(new HealthData(weight, height, activityLevel));
    }
    
    public boolean login(String email, String password){
        return this.email.equals(email) && this.password.equals(password);
    }
    
    public String getEmail(){
        return email;
    }
    
    public void changeEmail(String email){
        this.email = email;
    }
    
    public String getPassword(){
        return password;
    }
    
    public void changePassword(String password){
        this.password = password;
    }
    
    public String getFirstName(){
        return firstName;
    }
    
    public void changeFirstName(String firstName){
        this.firstName = firstName;
    }
    
    public String getLastName(){
        return lastName;
    }
    
    public void changeLastName(String lastName){
        this.lastName = lastName;
    }
    
    public String getFullName(){
        return firstName + " " + lastName;
    }
    
    public Date getDOB(){
        return dob;
    }
    
    public void changeDOB(Date dob){
        this.dob = dob;
    }
    
    public int getAge(){
        Date currentDate = new Date();
        long age = currentDate.getTime()-dob.getTime();
        age = (age/1000/60/60/24/365); //Converts age in 
        return (int) age;
    }
    
    public Sex getSex(){
        return bioSex;
    }
    
    public List<HealthData> getDataList(){
        return dataList;
    }
    
    public Goal getGoal(){
        return goal;
    }
    
    public boolean isMetric(){
        return isMetric;
    }
    
    public void changeMetricPreference(boolean isMetric){
        this.isMetric = isMetric;
    }
    
    public boolean isTrackingActivity(){
        return isTrackingActivity;
    }
    
    public void changeTRackingPreference(boolean isTrackingActivity){
        this.isTrackingActivity = isTrackingActivity;
    }
    
    @Override
    public String toString(){
        return email + "," + password + "," + firstName + "," + lastName + "," + dob + "," + bioSex + "," + isMetric + "," + isTrackingActivity;
    }
}
