import Ball from './Ball.js';
/*
    Andre Dexheimer Carneiro

    TODO: Correct import/export errors
 */

function loop(){

    var ball1 = new Ball(1, 1, 10, 10, 5, "red");

    ball1.update();
    ball1.draw();

    // console.clear();
    // console.log("Calling loop function");

    requestAnimationFrame(loop);
}

loop();
