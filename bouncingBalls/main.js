/*
    Andre Dexheimer Carneiro
    21/03/2019
 */

import Ball from "./Ball.js";
import {random} from "./utils.js"

var canvas = document.querySelector("canvas");
var ctx = canvas.getContext("2d");
var ballArray = [];

function loop_collisionTest(){
    /* Creates only two balls which collide with each other */
    var i;
    var numBalls = 2;
    // Clear canvas
    ctx.fillStyle = "rgb(0, 0, 0)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Initialize balls
    if(ballArray.length < 2){
        ballArray.push(new Ball(
            0,
            100,
            4,
            0,
            20,
            "rgb(255, 255, 255)"
        ));

        ballArray.push(new Ball(
            800,
            100,
            -4,
            0,
            8,
            "rgb(255, 255, 0)"
        ));
    }
    // Update and render balls
    for(i = 0; i < numBalls; i++){
        ballArray[i].update(ballArray);
        ballArray[i].draw();
    }

    requestAnimationFrame(loop_collisionTest);
}


function loop(){
    /* Generate random balls all over the place */
    var i;
    // Ball constants
    const numBalls = 20;
    const minX = 3;
    const minY = 3;
    const maxX = canvas.width;
    const maxY = canvas.height;
    const maxVelX = 12;
    const maxVelY = 12;
    const minR = 15;
    const maxR = 15;

    // Clear canvas
    ctx.fillStyle = "rgb(0, 0, 0)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Initialize balls
    while(ballArray.length < numBalls){
        ballArray.push(new Ball(
            random(minX, maxX),
            random(minY, maxY),
            random(-maxVelX, maxVelX),
            random(-maxVelY, maxVelY),
            random(minR, maxR),
            "rgb(" + random(0,255) + "," + random(0, 255) +"," + random(0, 255) + ")"
        ));

    }
    // Update and render balls
    for(i = 0; i < numBalls; i++){
        ballArray[i].update(ballArray);
        ballArray[i].draw();
    }

    requestAnimationFrame(loop);
}

// -------------------------------------------------------- MAIN
// loop();
loop_collisionTest();
