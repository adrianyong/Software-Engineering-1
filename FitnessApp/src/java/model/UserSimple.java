/**
 * User stores the users data for the login MERGE TEST
 * @authors 100021268, 100122248, 100137721,100090034
 */

package model;

public class UserSimple {
    private String firstName;
    private String lastName;
    
    public UserSimple(String firstName, String lastName){
        this.firstName = firstName;
        this.lastName = lastName;
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
}
