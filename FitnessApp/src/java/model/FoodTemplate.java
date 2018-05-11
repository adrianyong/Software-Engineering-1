/**
 * FoodTracker uses Food to keep track of the daily intake of the person
 * @author 100021268 100122248 100137721 100090034
 */

package model;

public class FoodTemplate {
    private String name;
    private double calories;
    
    public FoodTemplate(String nameIn, int caloriesIn){//, double portionSizeIn){
        name = nameIn;
        calories = caloriesIn;
    }
    
    public String getFoodName(){
        return name;
    }
    
    public double getCalories(){
        return calories;
    }
}