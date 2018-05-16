/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import model.Activity;
import model.Food;
import model.HealthData;
import model.HealthScore;
import model.User;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Bento
 */
public class PersistanceControllerTest {
    
    public PersistanceControllerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of loadHealthData method, of class PersistanceController.
     * @throws java.text.ParseException
     */
    @Test
    public void testLoadHealthData() throws ParseException {
        System.out.println("loadHealthData");
        String email = "test";
        List<HealthData> expResult = new ArrayList();
        expResult.add(new HealthData("70.0","182.0","05/05/2018 11:00:00"));
        expResult.add(new HealthData("73.0","182.0","06/05/2018 20:00:00"));
        
        List<HealthData> result = PersistanceController.loadHealthData(email);
        assertEquals(expResult.toString(), result.toString());
    }

    /**
     * Test of loadActivities method, of class PersistanceController.
     */
    @Test
    public void testLoadActivities() throws ParseException {
        System.out.println("loadActivities");
        String email = "test";
        List<Activity> expResult = new ArrayList();
        expResult.add(new Activity("Yoga","60.0","240.0","09/05/2018 13:00:00"));
        expResult.add(new Activity("Bowling","120.0","360.0","10/05/2018 17:00:00"));
        
        List<Activity> result = PersistanceController.loadActivities(email);
        assertEquals(expResult.toString(), result.toString());
    }

    /**
     * Test of loadHealthScores method, of class PersistanceController.
     * @throws java.text.ParseException
     */
    @Test
    public void testLoadHealthScores() throws ParseException {
        System.out.println("loadHealthScores");
        String email = "test";
        List<HealthScore> expResult = new ArrayList();
        expResult.add(new HealthScore("1", "240", "20", "08/05/2018 12:00:00"));
        expResult.add(new HealthScore("2", "360", "40", "09/05/2018 12:00:00"));
        
        List<HealthScore> result = PersistanceController.loadHealthScores(email);
        assertEquals(expResult.toString(), result.toString());
    }

    /**
     * Test of loadFoods method, of class PersistanceController.
     */
    @Test
    public void testLoadFoods() throws ParseException {
        System.out.println("loadFoods");
        String email = "test";
        List<Food> expResult = new ArrayList();
        expResult.add(new Food("Mushroom Soup (avg. weight 400g)","221.0","400.0","12/05/2018 11:00:00","Lunch"));
        expResult.add(new Food("Mushroom (avg. weight 18g)","4.0","10.0","12/05/2018 09:00:00","Breakfast"));
        
        List<Food> result = PersistanceController.loadFoods(email);
        assertEquals(expResult.toString(), result.toString());
    }
    
}
