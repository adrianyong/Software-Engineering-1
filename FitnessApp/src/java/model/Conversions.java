/**
 * Conversion holds the calculations required to convert to/from metric/imperial
 * @author 100021268 100122248 100137721 100090034
 */
package model;

public class Conversions {
    
    static double weight;
    static double height;
    
    public static double weightPoundsToKg(double lbsWeight){//pounds to kilogram
        weight = lbsWeight*(0.45359237);
        return weight;
    }
    
    public static double weightKgToPounds(double kgWeight){//kilogram to pounds
        weight = kgWeight/(0.45359237);
        return weight;
    }
    
    public static double weightKgToStonePart(double kgWeight){
        return (int) (kgWeight * 0.157473);
    }
    
    public static double weightKgToPoundsPart(double kgWeight){
        return ((kgWeight * 0.157473) - weightKgToStonePart(kgWeight))*14;
    }
    
//    public static double weightPoundsToStone(double lbsWeight){//pounds to stone
//        weight = (lbsWeight*0.071429);
//        return weight;
//    }
    
//    public static double weightKgToStone(double kgWeight){//kilogram to stone
//        weight = (kgWeight*0.157473);
//        return weight;
//    }
    
    public static double weightStonePoundsToKg(double stoneWeight, double poundsWeight){
        return stoneWeight*6.35029 + poundsWeight*0.453592;
    }
    
    public static double heightFeetInchesToCM(double feetHeight, double inchesHeight){
        return feetHeight*30.48 + inchesHeight*2.54;
    }
    
//    public static String heightCMToFeetInches(double cmHeight){
//        int temp1 = (int) cmHeight;
//        int temp2 = (int) (cmHeight % 30.48);
//        return temp1 + "feet, " + temp2;
//    }
    
    public static double heightCMToFeetPart(double cmHeight){
        return (int) (cmHeight * 0.0328084);
    }
    
    public static double heightCMToInchesPart(double cmHeight){
        return ((cmHeight * 0.0328084) - heightCMToFeetPart(cmHeight))*12;
    }
//    public static double heightInchesToCM(double inchesHeight){//inches to centimetres
//        height = (inchesHeight*2.54);
//        return height;
//    }
    
//    public static double heightCmToInches(double cmHeight){//centimetres to inches
//        height = (cmHeight/2.54);
//        return height;
//    }
    
}
