/**
 * User stores the users data for the login MERGE TEST VERSION
 * @authors 100021268, 100122248, 100137721,100090034
 */

package model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class User {
    String email;
    String password;
    String firstName;
    String surname;
    Date dateOfBirth;
    Sex bioSex;
    ArrayList<HealthData> dataList;
    Goal goal;
    boolean isMetric;
    boolean trackActivity;
    
    public static enum Sex{Male, Female}
    
    public User(String firstName, String surname, String email, String password, Date dateOfBirth, Sex sex, boolean isMetric, boolean trackActivity){
        this.firstName = firstName;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.bioSex = sex;
        this.isMetric = isMetric;
        this.trackActivity = trackActivity;
    }
    
    void updateData(double weight, double height, HealthData.ActivityLevel activityLevel){
        if(!isMetric){
            weight = Conversions.weightToKG(weight);
            height = Conversions.heightToCM(height);
        }
        dataList.add(new HealthData(weight, height, activityLevel, new Date()));
    }
    
    boolean login(String email, String password){
        return this.email.equals(email) && this.password.equals(password);
    }
    
    
    String getEmail(){
        return email;
    }
    
    String getFirstName(){
        return firstName;
    }
    
    String getSurname(){
        return surname;
    }
    
    Date getDateOfBirth(){
        return dateOfBirth;
    }
    
    int getAge(){
        Date currentDate = new Date();
        long age = currentDate.getTime()-dateOfBirth.getTime();
        age = (age/1000/60/60/24/365);
        return (int) age;
    }
    
    Sex getSex(){
        return bioSex;
    }
    
    @Override
    public String toString(){
        return email + "," + password + "," + firstName + "," + surname + "," + dateOfBirth + "," + bioSex + "," + isMetric + "," + trackActivity;
    }
    
    public static void main(String[] args) {
        String email = "Bentownsend1997@gmail.com";
        String password = "password";
        String firstName = "Ben";
        String surname = "Townsend";
        Date dateOfBirth = new GregorianCalendar(1997, Calendar.MARCH, 16).getTime();
        Sex sex = Sex.Male;
        boolean isMetric = true;
        boolean trackActivity = false;
        
        User testUser = new User(firstName, surname, email, password, dateOfBirth, sex, isMetric, trackActivity);
        System.out.println(testUser);
    }
}
