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
    private final Sex bioSex;
    private Goal goal;
    private boolean isMetric;
    private boolean isTrackingActivity;
    
    private List<HealthData> dataList;
    
    public static enum Sex{Male, Female}
    
    public User(String email, String password, String firstName, String lastName, Date dob, Sex sex, boolean isMetric, boolean isTrackingActivity){
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.bioSex = sex;
        this.isMetric = isMetric;
        this.isTrackingActivity = isTrackingActivity;
        
        this.dataList = new ArrayList();
    }
    
    public User(String email, String password, String firstName, String lastName, String dobs, String sexs, boolean isMetric, boolean isTrackingActivity) throws ParseException{
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        this.dob = formatter.parse(dobs);
        
        this.bioSex = Sex.valueOf(sexs);
        this.isMetric = isMetric;
        this.isTrackingActivity = isTrackingActivity;
        
        this.dataList = new ArrayList();
    }
    
    public void updateData(double weight, double height, String activityLevel){
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
    
    public void setMetricPreference(boolean isMetric){
        this.isMetric = isMetric;
    }
    
    public boolean isTrackingActivity(){
        return isTrackingActivity;
    }
    
    public void setTrackingPreference(boolean isTrackingActivity){
        this.isTrackingActivity = isTrackingActivity;
    }
    
    @Override
    public String toString(){
        return email + "," + password + "," + firstName + "," + lastName + "," + getDobString() + "," + bioSex + "," + isMetric + "," + isTrackingActivity;
    }
}
