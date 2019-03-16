
function sockMerchant(sockList){

    var sockCopy = sockList;
    var i, j;
    var pairsFound = 0;

    // Go through the socks
    for(i = 0; i < sockList.length; i++){
        // Find pair for each sock
        if(sockCopy[i] != -1){
            for(j = i+1; j < sockList.length; j++){
                if(sockCopy[j] == sockCopy[i]){
                    // Found a pair
                    sockCopy[i] = sockCopy[j] = -1;
                    pairsFound++;
                    break;
                }
            }
        }
    }
    
    return pairsFound;
}

var sockList = [1, 1, 2, 2, 3, 4 ,5, 3, 2, 1, 2];

console.log(`Calling sock merchant with ${sockList}`);
console.log(`There are ${sockMerchant(sockList)} pairs of socks`);