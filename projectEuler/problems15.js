
// Problem 1 ----------------------------------------------------------
function sumMultiples35(){

    var i, sum;

    sum = 0;
    for(i = 1; i < 1000; i++){
        // Sum multiples of 3 and 5
        if(i%3 == 0 || i%5 == 0){
            sum += i;
        }
    }

    console.log(`Sum of all multiples of 3 and 5 below 1000 is: ${sum}`);
    return sum;
}


// Tests --------------------------------------------------------------

sumMultiples35();