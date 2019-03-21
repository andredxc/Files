
var canvas = document.querySelector('canvas');
var ctx = canvas.getContext('2d');

var canvasWidth = canvas.width = window.innerWidth;
var canvasHeight = canvas.height = window.innerHeight;

export default class Ball{

    constructor(xPos, yPos, xVel, yVel, radius, color){
        // TODO: Check for valid positions and radius
        this.xPos = xPos;
        this.yPos = yPos;
        this.xVel = xVel;
        this.yVel = yVel;
        this.color = color;
        this.radius = radius;
    }

    update(){

        if((this.xPos + this.radius) >= canvasWidth){
            this.xVel = -this.xVel;
        }

        if((this.yPos + this.radius) >= canvasHeight){
            this.yVel1 = -this.yVel;
        }

        this.xPos += this.xVel;
        this.yPos += this.yVel;

        console.log(`Position: (${this.xPos}, ${this.yPos}) + (${this.xVel}, ${this.yVel})`);
    }

    draw(){
        /* Draw the shape on screen */
        ctx.beginPath();
        ctx.fillStype = this.color;
        ctx.arc(this.xPos, this.yPos, this.radius, 0, 2*Math.PI);
        ctx.fill();
    }
}
