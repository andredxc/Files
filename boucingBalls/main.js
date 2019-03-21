
/* 
    Andre Dexheimer Carneiro

    TODO: Correct import/export errors
 */

import Ball from "Ball";

function loop(){

    var ball1 = new Ball(5, 5, 1, 1, 2, "red");

    ball1.draw();
    
    requestAnimationFrame(loop);
}

loop(); 
