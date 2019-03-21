
const Player = require('./player.js');
const Db = require('./dbFactory.js');
const dbAddress = 'players.csv';


var db = new Db(dbAddress);
db.connect();
db.dump();
db.close();


//
// var player1 = new Player("Jorge", 35);
// console.log(`Player name: ${player1.getName()}, age: ${player1.getAge()}`);
