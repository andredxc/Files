
const http = require('http');
const tempTools = require('./exercises');

function testHttp(){

    http.createServer(function(req, res){

        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end('Hello World');
    }).listen(8080);
}

function testTemp(){
    
    let tt = new tempTools();

    console.log("Temperature: " + tt.getTemp() + "ºC = " + tt.celsiusToFahrenheit() + "Fº");
    console.log("Temperature: " + tt.getTemp() + "ºF = " + tt.fahrenheitToCelsius() + "Cº");
}

var nameList = ["John", "Rudy", "Elton"];
console.log(`Name list: ${nameList}`);
// console.table(nameList);

