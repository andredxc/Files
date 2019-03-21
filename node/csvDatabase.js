
const fs = require("fs");
// Problema, talvez reiniciar o computador corrija
const csv = require("fast-csv");

var _fileName;
var _stream;
var _csvStream;

function CsvDatabase(fileName){
    _fileName = fileName;
}

CsvDatabase.prototype.connect = function(){
    _stream = fs.createReadStream(_fileName);
}

CsvDatabase.prototype.dump = function(){
    _csvStream = csv()
        .on("data", function(data){
            console.log(data);
        })
        .on("end", function(){
            console.log("Done");
        });
}

CsvDatabase.prototype.close = function(){
    _stream.pipe(_csvStream);
}

module.exports = CsvDatabase;
