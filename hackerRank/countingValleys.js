
function countingValleys(n, s){

    var i;
    var level = 0;
    var valleyCount = 0;

    if(s.length != n){
        // Wrong format
        console.log("Number of steps differs from string length");
        return -1;
    }

    for(i = 0; i < n; i++){

        if(s.charAt(i) == 'D'){
            // Step down
            level--;
        }
        else if(s.charAt(i) == 'U'){
            // Step up
            level ++;
            if(level == 0){
                // Found the end of a valley
                valleyCount++;
            }
        }
        else{
            // Badly formatted string
            console.log("Invalid character in string");
            return -1;
        }
    }

    console.log(`Number of valleys: ${valleyCount}`);
    return valleyCount;
}

countingValleys(10, "DDUUUUDDDU");