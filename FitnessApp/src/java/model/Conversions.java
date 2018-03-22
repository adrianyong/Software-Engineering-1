/**
 * Conversion holds the calculations required to convert to/from metric/imperial
 * @author 100021268 100122248 100137721 100090034
 */
package model;

public class Conversions {
    
    static double weight;
    static double height;
    
    public static double weightLbsToKG(double lbsWeight){//pounds to kilogram
        weight = lbsWeight*(0.45359237);
        return weight;
    }
    
    public static double weightKGToPounds(double kgWeight){//kilogram to pounds
        weight = kgWeight/(0.45359237);
        return weight;
    }
    
    public static double weightLbsToStone(double lbsWeight){//pounds to stone
        weight = (lbsWeight*0.071429);
        return weight;
    }
    
    public static double weightKGToStone(double kgWeight){//kilogram to stone
        weight = (kgWeight*0.157473);
        return weight;
    }
    
    public static double heightToCM(double inchesHeight){//inches to centimetres
        height = (inchesHeight*2.54);
        return height;
    }
    
    public static double heightToInches(double cmHeight){//centimetres to inches
        height = (cmHeight/2.54);
        return height;
    }
    
}
