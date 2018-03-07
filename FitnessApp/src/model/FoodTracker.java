/**
 * FoodTracker uses Food to keep track of the daily intake of the person
 * @author 100021268 100122248 100137721 100090034
 */

package model;

public class FoodTracker {
    Food food;
    double dailyCalorieIntake;
    int[] dailyNutrientIntake = new int[6];
    double portionSize;
    
    void calculatePortionConsumed(){
        //returns double calculating the portion consumed against the Food object 
    }
    
    void getFood(){
        //retuns Food type object from Food 
    }
    
    void getDailyCalorieIntake(){
        //returns dailyCalorieIntake as int/double 
    }
    void getDailyNutrientIntake(){
        //returns dailyCalorieIntake as int[6]
    }
            
}
