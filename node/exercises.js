
const DEFAULT_TEMP = 100.0;

class tempTools{

    constructor(){
        this.temp = DEFAULT_TEMP;
    }

    celsiusToFahrenheit(){
        return 9.0*this.temp/5.0 + 32.0;
    }
    
    fahrenheitToCelsius(){
        return 5.0*this.temp/9.0 - 32.0;
    }

    setTemp(temp){this.temp = temp;}
    getTemp(){return this.temp;}
}

module.exports = tempTools;

