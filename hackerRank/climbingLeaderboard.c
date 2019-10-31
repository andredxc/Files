# include <stdio.h>
# include <stdlib.h>


int* climbingLeaderboard(int* scores, int scoreSize, int* alice, int aliceSize);


int main(){

    int i;
    int scoreSize, aliceSize;
    int *output;

    // Initialize arrays for example 1 scenario
    // scoreSize = 7;
    // aliceSize = 4;
    // int scores[] = {100, 100, 50, 40, 40, 20, 10};
    // int alice[] = {5, 25, 50, 120};

    // Initialize arrays for example 2 scenario
    scoreSize = 6;
    aliceSize = 5;
    int scores[] = {100, 90, 90, 80, 75, 60};
    int alice[] = {50, 65, 77, 90, 102};

    // Call function and print results
    output = climbingLeaderboard(scores, scoreSize, alice, aliceSize);
    fprintf(stderr, "Output\n");
    for(i = 0; i < 4; i++){
        fprintf(stderr, "%d\n", output[i]);
    }
}


int* climbingLeaderboard(int* scores, int scoreSize, int* alice, int aliceSize){

    int i, j, scorePosition, done;
    int *output;

    output = (int*)malloc(aliceSize*sizeof(int));

    // For each one of alice's scores
    for(i = 0; i < aliceSize; i++){

        // Find the position for the current alice score
        scorePosition = 1;
        done = 0;
        j = 0;
        while(j < scoreSize && !done){
            if(alice[i] >= scores[j]){
                // Alice score is higher than the current one
                done = 1;
            }
            else if(j == scoreSize-1 || scores[j] != scores[j+1]){
                // The next score is differente from the current
                scorePosition++;
            }
            j++;
        }
        output[i] = scorePosition;
    }

    return output;
}
