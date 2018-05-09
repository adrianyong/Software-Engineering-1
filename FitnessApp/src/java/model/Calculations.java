/**
 * Calculations calculates the BMI, the BMR and the calories
 * @author 100021268 100122248 100137721 100090034
 */
package model;


public class Calculations {
    public static double BMR(User user){
        //For mass(kg), height(m), age(years)
        double BMR = 0;
        
        if(user.getSex()== User.Sex.Male){
            BMR = (13.397 * user.getWeight()) + (4.799 * user.getHeight()) - (5.677 * user.getAge()) + 88.362;
        }
        
        if(user.getSex() == User.Sex.Female){
            BMR = (9.247 * user.getWeight()) + (3.098 * user.getHeight()) - (4.330 * user.getAge()) + 447.593;
        }
        
        switch (user.getActivityLevel()) {
        case NoExercise:
            BMR *= 1.2;
            break;
        case LightExercise:
            BMR *= 1.375;
            break;
        case ModerateExercise:
            BMR *= 1.55;
            break;
        case HardExercise:
            BMR *= 1.725;
            break;
        case VeryHardExercise:
            BMR *= 1.9;
            break;
        default:
            break;
        }
            
        return BMR;
    }
    
    public static double BMI(double mass, double height){
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
