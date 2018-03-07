/**
 * User stores the users data for the login MERGE TEST
 * @authors 100021268, 100122248, 100137721,100090034
 */

package model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class User {
    private String email;
    private String password;
    private String firstName;
    private String surname;
    private Date dateOfBirth;
    private final Sex bioSex;
    private ArrayList<HealthData> dataList;
    private Goal goal;
    private boolean isMetric;
    private boolean isTrackingActivity;
    
    public static enum Sex{Male, Female}
    
    public User(String firstName, String surname, String email, String password, Date dateOfBirth, Sex sex, boolean isMetric, boolean isTrackingActivity){
        this.firstName = firstName;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.bioSex = sex;
        this.isMetric = isMetric;
        this.isTrackingActivity = isTrackingActivity;
    }
    
    public void updateData(double weight, double height, HealthData.ActivityLevel activityLevel){
        if(!isMetric){
            weight = Conversions.weightToKG(weight);
            height = Conversions.heightToCM(height);
        }
        dataList.add(new HealthData(weight, height, activityLevel, new Date()));
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
    
    public String getSurname(){
        return surname;
    }
    
    public void changeSurname(String surname){
        this.surname = surname;
    }
    
    public Date getDateOfBirth(){
        return dateOfBirth;
    }
    
    public void changeDateOfBirth(Date dateOfBirth){
        this.dateOfBirth = dateOfBirth;
    }
    
    public int getAge(){
        Date currentDate = new Date();
        long age = currentDate.getTime()-dateOfBirth.getTime();
        age = (age/1000/60/60/24/365); //Converts age in 
        return (int) age;
    }
    
    public Sex getSex(){
        return bioSex;
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
        return email + "," + password + "," + firstName + "," + surname + "," + dateOfBirth + "," + bioSex + "," + isMetric + "," + isTrackingActivity;
    }
}
