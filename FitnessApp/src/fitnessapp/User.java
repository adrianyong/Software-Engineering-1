/**
 * User stores the users data for the login
 * @authors 100021268, 100122248, 100137721,100090034
 */

package fitnessapp;

import java.util.ArrayList;
import java.util.Date;
import javax.xml.crypto.Data;

public class User {
    String email;
    String password;
    Date dateOfBirth;
    Enum Sex;
    ArrayList<Data> dataList;
    Goal goal;
    boolean isMetric;
    boolean trackAct;
    
    void getEmail(){
        //returns String email
    }
    
    void acccountExists(){
        //returns boolean if account exists
    }
    
    void login(){
        //returns boolean true/false if login is successful
    }
    
    void getDateOfBirth(){
        //returns Date type DOB
    }
    
    void getAge(){
        //returns int type age
    }
    
    void getSex(){
        //returns Sex type male or feamle
    }
}
