/**
 * Calculations calculates the BMI, the BMR and the calories
 * @author 100021268 100122248 100137721 100090034
 * hi bitbucket
 */
package model;


public class Calculations {
    double BMI;
    double BMR;
    double userCalories;
    
    public double BMR(double mass, double height, int age, char sex){
        
        //For mass(kg), height(m), age(years)
        
        height = height / 100;
        
        if(sex == 'm'){
            BMR = (13.397 * mass) + (4.799 * height) - (5.677 * age) + 88.362;
        }
        
        if(sex == 'f'){
            BMR = (9.247 * mass) + (3.098 * height) - (4.330 * age) + 447.593;
        }
        
        return BMR;
    }
    
    public double BMI(double mass, double height){
        
            //When mass(kg) height(m)
            BMI = mass / (height * height);
            
            /** BMI for lbs and inches
            BMI = (mass / (height * height)) * 703
            **/
            
        return BMI;
    }
    
    public double calcMaintCalories(double BMR , double activityLevel){
       
            userCalories = BMR * activityLevel;
        
        return userCalories;
    }
}
