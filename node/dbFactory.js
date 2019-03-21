
const Database = require('./csvDatabase.js');
var db;

function dbFactory(address){
    db = new Database(address);
}

dbFactory.prototype.connect = function(){
    db.connect();
}

dbFactory.prototype.close = function(){
    db.close();
}

dbFactory.prototype.dump = function(){
    db.dump();
}

module.exports = dbFactory;
