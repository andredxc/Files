
var canvas = document.querySelector('canvas');
var ctx = canvas.getContext('2d');

function Ball(xPos, yPos, xVel, yVel, radius, color){

    // TODO: Check for valid positions and radius
    this.xPos = xPos;
    this.yPos = yPos;
    this.xVel = xVel;
    this.yVel = yVel;
    this.color = color;
    this.radius = radius;
}

Ball.prototype.update = function(){
    this.xPos += this.xVel;
    this.yPos += this.yVel;
};

Ball.prototype.draw = function(){
    /* Draw the shape on screen */
    ctx.beginPath();
    ctx.fillStype = this.color;
    ctx.arc(this.xPos, this.yPos, this.radius, 0, 2*Math.PI);
    ctx.fill();
};

module.exports = Ball;