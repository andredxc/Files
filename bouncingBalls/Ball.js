
var canvas = document.querySelector("canvas");
var ctx = canvas.getContext("2d");

var canvasWidth = canvas.width = window.innerWidth;
var canvasHeight = canvas.height = window.innerHeight;

export default class Ball{

    constructor(xPos, yPos, xVel, yVel, radius, color){
        // TODO: Check for valid positions and radius
        // Ball can`t be spawned outside of the canvas
        this.xPos = xPos;
        this.yPos = yPos;
        this.xVel = xVel;
        this.yVel = yVel;
        this.color = color;
        this.radius = radius;

        console.log(`Ball created: xPos: ${this.xPos}, yPos: ${this.yPos}, xVel: ${this.xVel}, yVel: ${this.yVel}, color: ${this.color}, radius: ${this.radius}`);
    }

    update(ballArray = undefined){
        /* Updates the ball`s position */
        // Ball hit the edge on X axis
        if((this.xPos + this.radius) >= canvasWidth || (this.xPos - this.radius) <= 0){
            this.xVel = -this.xVel;
        }
        // Ball hit the edge on Y axis
        if((this.yPos + this.radius) >= canvasHeight || (this.yPos - this.radius) <= 0){
            this.yVel = -this.yVel;
        }
        // Collision detection
        if(ballArray != undefined){
            this.detectCollision(ballArray);
        }
        // Update position based on speed
        this.xPos += this.xVel;
        this.yPos += this.yVel;
    }

    draw(){
        /* Draw the shape on screen */
        ctx.beginPath();
        ctx.fillStyle = this.color;
        ctx.arc(this.xPos, this.yPos, this.radius, 0, 2*Math.PI);
        ctx.fill();
    }

    detectCollision(ballArray){
        /* Detect collisions and perform necessary changes in speed */
        var i, dist;

        for(i = 0; i < ballArray.length; i++){

            // TODO: optimize calculation
            if(this.xPos != ballArray[i].getX() || this.yPos != ballArray[i].getY()){
                // Skip the one ball
                // Test the distance between the center of the two circles
                dist = Math.sqrt(Math.pow(this.xPos - ballArray[i].getX(), 2) + Math.pow(this.yPos - ballArray[i].getY(), 2));
                if(dist <= (this.radius + ballArray[i].getRadius())){
                    // Collision detected
                    this.xVel = -this.xVel;
                    this.yVel = -this.yVel;
                }
            }
        }
    }

    getX(){return this.xPos;}
    getY(){return this.yPos;}
    getXVel(){return this.xVel;}
    getYVel(){return this.yVel;}
    getRadius(){return this.radius;}
}
