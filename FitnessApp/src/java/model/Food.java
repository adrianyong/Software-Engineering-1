/**
 * Food gets the nutritional information of the food from  a recipe
 * @author 100021268 100122248 100137721 100090034
 */
package model;

import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Food {
    private final String name;
    private final double calories;
    private double portion;
    private final Date dateTime;
    
    public static enum Meal{Breakfast, Lunch, Dinner, Snack};
    private Meal meal;
        
    public Food(String nameIn, double portionIn, Meal mealIn){
        this.name = nameIn;
        this.portion = portionIn;
        
        FoodTemplate ft = getFoodTemplate(name);
        this.calories = (ft.getCalories()/100)*portionIn;
        
        this.meal = mealIn;
        this.dateTime = new Date();
    }
    
    public Food(String nameIn, String caloriesIn, String portionIn, String dateTimes, String meal) throws java.text.ParseException{
        this.name = nameIn;
        
        this.calories = Double.parseDouble(caloriesIn);
        this.portion = Double.parseDouble(portionIn);
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date dateTime = formatter.parse(dateTimes);
        this.dateTime = dateTime;
        
        this.meal = Meal.valueOf(meal);
    }
    
    public static List<FoodTemplate> getFoodList(){
        List<FoodTemplate> FoodTemplates = new ArrayList();
        Object obj = null;
        
        try {
            obj = new JSONParser().parse(new FileReader("FitnessApp/FoodTemplates.json"));
        } catch (IOException ex) {
            System.out.println("ERROR: with reading");
        } catch (ParseException ex) {
            System.out.println("ERROR: with parsing");
        }
        
        JSONObject jo = (JSONObject) obj;
        JSONArray ja = (JSONArray) jo.get("Foods");

        Iterator itr2 = ja.iterator();

        String name = null;
        String calories = null;

        while (itr2.hasNext()) 
        {
            Iterator<Map.Entry> itr1 = ((Map) itr2.next()).entrySet().iterator();

            while (itr1.hasNext()) {
            Map.Entry pair = itr1.next();
            if("name".equals(pair.getKey().toString()))
                name = pair.getValue().toString();
            else if("calories".equals(pair.getKey().toString()))
                calories = pair.getValue().toString();
        }
            FoodTemplates.add(new FoodTemplate(name, Integer.parseInt(calories)));
        }
        return FoodTemplates;
    }

    //Getters
    public FoodTemplate getFoodTemplate(String foodName){
        List<FoodTemplate> foodList = getFoodList();
        for (FoodTemplate f : foodList){
            if(f.getFoodName().equals(foodName)){ 
                return f;
            }
        }
        return null;
    }
    
    public String getName(){
        return name;
    }    
    
    public double getCalories(){
        return calories;
    }

    public double getPortion(){
        return portion;
    }

    public Date getDateTime(){
        return dateTime;
    }    
    
    public Meal getMeal(){
        return meal;
    }
    
    @Override
    public String toString(){
        return name + "," + calories + "," + portion + "," + dateTime.toString();
    }
}