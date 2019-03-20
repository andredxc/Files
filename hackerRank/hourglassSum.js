

// https://www.hackerrank.com/challenges/2d-array/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays                      
function hourglassSum(array){

    var i, j, curSum, hourglassCount, highestSum;
    var lenX = array[0].length;
    var lenY = array.length;
    var sumArray = [];
    var done;

   console.log("(1,3): " + array[1][3]);
    
    hourglassCount = 0;
    i = 0;
    j = 0;
    done = false;
    while(i < lenX && !done){
        while(j < lenY && !done){
            if(i+2 < lenX){
                if(j+2 < lenY){
                    // Hourglass inside the matrix`s dimensions
                    // (topRow) + (middleRow) + (bottomRow)
                    curSum = (array[i][j]+array[i+1][j]+array[i+2][j]) + (array[i+1][j+1]) + (array[i][j+2]+array[i+1][j+2]+array[i+2][j+2]);
                    hourglassCount++;
                    console.log(`Hourglass nr ${hourglassCount}: ${curSum}`);
                    sumArray.push(curSum);
                }
            }
            else{
                // Can`t go further right
                done = true;
            }
            j++;
        }
        i++;
    }

    // Find highest sum
    if(sumArray.length > 1){
        highestSum = sumArray[0];
    }
    for(i = 0; i < sumArray.length; i++){
        if(sumArray[i] > highestSum){
            highestSum = sumArray[i];
        }
    }
    console.log(sumArray);
    console.log(`hourglass sums: ${sumArray}`);
    console.log(`Highest sum: ${highestSum}`);
    return highestSum;
}

var array = [[-9, 0, -9, 0, 0, 0], [-9, 9, -9, 0, 0, 0], [-9, 0, -9, 8, 0, 1], [1, 4, 1, 6, -2, 2], [1, 3, 2, 6, 0, 4], [1, 2, 3, 0, 0, 0]];
hourglassSum(array);