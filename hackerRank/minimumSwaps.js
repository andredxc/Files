
function minimumSwaps(a){

    var i, temp, numSwaps;

    console.log(`Initial array: ${a}`);

    numSwaps = 0;
    for(i = 0; i < a.length; i++){
        if(a[i] != i+1){
            // Must be swapped
            temp = a[i];
            for(j = i; j < a.length; j++){
                // Find element to swap
                if(a[j] == i+1){
                    // Swap
                    a[i] = a[j];
                    a[j] = temp;
                    numSwaps++;
                    break;
                }
            }
            // console.log(`Current array: ${a}`);
            console.log(`Swapping ${a[i]} and ${a[j]}...`);
        }
    }

    console.log(`Final array: ${a}`);
    console.log(`Number of swapped elements: ${numSwaps}`);
    return numSwaps;
}

var array = [9,2,3,4,5,6,1,8,7];
minimumSwaps(array);