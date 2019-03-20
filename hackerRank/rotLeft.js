
function rotLeft(a, d){

    var i, oldIndex;
    var newA = [];

    // Recalculate each index according to d
    for(i = 0; i < a.length; i++){
        oldIndex = (i + d) % a.length;
        newA[i] = a[oldIndex];
    }

    console.log(`Original array: ${a}`);
    console.log(`New array: ${newA}`);
    return newA;
}

// Test
var array = [1, 2, 3, 4, 5];
var rotations = 100000000000002;
rotLeft(array, rotations);