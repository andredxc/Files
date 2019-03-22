
export function random(min, max){
    /*Random number in the interval [min, max]*/
    var num = Math.floor(Math.random()*(max-min+1)) + min;
    return  num;
}
