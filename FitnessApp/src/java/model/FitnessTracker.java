/**
 * Fitness tracker compares the health scores and sets them into different quartiles
 * @author 100021268 100122248 100137721 100000034
 */
package model;

import java.util.HashMap;

public class FitnessTracker {
    int currentHealthScore;
    int previousHealthScore;
    int medianHealthScore;
    int highestHealthScore;
    int lowestHealthScore;
    HashMap healthScoreLog;
    
    boolean compareTo(int healthScore1, int healthScore2){
        return healthScore1>healthScore2;
    }
    
    //compares two healthScoreInts using compareTo, returns the higher
    int compareHealthScores(int healthScore1, int healthScore2){
        if(compareTo(healthScore1, healthScore2)){
            return healthScore1;
        }
        return healthScore2; 
    }
}
