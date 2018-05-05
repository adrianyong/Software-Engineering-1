/**
 * Calculations calculates the BMI, the BMR and the calories
 * @author 100021268 100122248 100137721 100090034
 * hi bitbucket
 */
package model;


public class Calculations {
    
    
    
    
    public static double BMR(double mass, double height, int age, User.Sex sex){
        //For mass(kg), height(m), age(years)
        double BMR = 0;
//        height = height / 100;
        
        if(sex == User.Sex.Male){
            BMR = (13.397 * mass) + (4.799 * height) - (5.677 * age) + 88.362;
        }
        
        if(sex == User.Sex.Female){
            BMR = (9.247 * mass) + (3.098 * height) - (4.330 * age) + 447.593;
        }
        
        return BMR;
    }
    
    public static double BMI(double mass, double height){
//        double BMI = 0;
//        
//        //When mass(kg) height(m)
//        BMI = mass / (height * height);
//
//        /** BMI for lbs and inches
//        BMI = (mass / (height * height)) * 703
//        **/
            
        return mass / (height/100 * height/100);
    }
    
    public static String BMIClass(double mass, double height){
        double BMI = mass / (height/100 * height/100);
        if(BMI < 18.5)
            return "Underweight";
        else if(BMI < 24.9)
            return "Healthy Weight";
        else if(BMI < 29.9)
            return "Overweight";
        else
            return "Obese";
    }
    
    public static double calcMaintCalories(double BMR , double activityLevel){
       double userCalories;
       
        userCalories = BMR * activityLevel;
        
        return userCalories;
    }
}
