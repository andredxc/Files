
var _name;
var _age;

function Player(name, age){

    _name = name;
    _age = age;
}

Player.prototype.getName = function(){
    return _name;
};

Player.prototype.getAge = function(){
    return _age;
};

// Export the class
module.exports = Player;
