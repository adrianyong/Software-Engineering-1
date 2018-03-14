/**
 * FitnessApp is the main method 
 * @author 100021268 100122248 100137721 100090034
 */
package controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.HealthData;
import model.User;

public class SystemController {

    private static List<User> users = new ArrayList<User>();

    public static void main(String[] args) throws java.text.ParseException, IOException, FileNotFoundException, org.json.simple.parser.ParseException{
        try {
            users = PersistanceController.loadUsers();
            System.out.println("All users loaded successfully.");
        } catch (Exception e) {
            System.out.println("Error: unable to load users, they may not exist!");
        }
        
        try {
            PersistanceController.loadHealthData(users);
            System.out.println("All user data loaded successfully.");
        } catch (Exception e) {
            System.out.println("Error: unable to load user data, it may not exist!");
        }
        
        /*if(users.isEmpty()){
            createTestUsers();
            try {
                PersistanceController.saveUsers(users);
                System.out.println("All users saved successfully.");
            } catch (Exception e){
                System.out.println("Error: unable to save users!");
            }
        }*/
        
        /*for(User u : users){
            if(u.getDataList().isEmpty()){
                u.updateData(70, 180, "NoExercise");
                u.updateData(80, 170, "ModerateExercise");
                u.updateData(60, 200, "LightExercise");
            }
        }*/
        //PersistanceController.saveHealthData(users);
        
    }
    
    public static List<User> getUsers() throws IOException, FileNotFoundException, org.json.simple.parser.ParseException, ParseException{
        List<User> users = PersistanceController.loadUsers();
        return users;
    }
    
    public static void addUser(User user) throws IOException, FileNotFoundException, org.json.simple.parser.ParseException, ParseException{
        List<User> users = PersistanceController.loadUsers();
        System.out.println(users + "loaded");
        users.add(user);
        System.out.println(user + "added");
        PersistanceController.saveUsers(users);
        System.out.println(users + "saved");
    }
    
    public static List<User> createTestUsers() throws ParseException{
        User user1 = new User("bentownsend1997@gmail.com", "password", "Ben", "Townsend", "16/03/1997", "Male", true, false);
        System.out.println("User \"" + user1.getFullName() + "\" created");
        users.add(user1);

        User user2 = new User("sophiecevrollo@gmail.com", "12345", "Sophie", "Rollo", "05/04/1994", "Female", false, true);
        System.out.println("User \"" + user2.getFullName() + "\" created");
        users.add(user2);

        User user3 = new User("brazil.jdogg@gmail.com", "12345", "James", "Mason", "10/12/1995", "Male", true, true);
        System.out.println("User \"" + user3.getFullName() + "\" created");
        users.add(user3);

        User user4 = new User("ayong104@gmail.com", "12345", "Adrian", "Yong", "10/04/1997", "Male", true, false);
        System.out.println("User \"" + user4.getFullName() + "\" created");
        users.add(user4);
        
        return users;
    }
}
