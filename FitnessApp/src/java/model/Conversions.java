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
    
    public static double weightStonePoundsToKg(double stoneWeight, double poundsWeight){
        return stoneWeight*6.35029 + poundsWeight*0.453592;
    }
    
    public static double heightFeetInchesToCM(double feetHeight, double inchesHeight){
        return feetHeight*30.48 + inchesHeight*2.54;
    }
    
    public static double heightCMToFeetPart(double cmHeight){
        return (int) (cmHeight * 0.0328084);
    }
    
    public static double heightCMToInchesPart(double cmHeight){
        return ((cmHeight * 0.0328084) - heightCMToFeetPart(cmHeight))*12;
    }
}
