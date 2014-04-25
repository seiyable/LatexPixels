function Arduino(_lx, _ly, _imageWidth) {
  //=========== in-class variables ===========
  this.location = new PVector(_lx, _ly);;
  //this.ard = loadImage("img/arduino_Uno.png");    // asyncroness;
  //ard.resize(_imageWidth, 0);    // not working
}

Arduino.prototype = {
  //=========== display() ===========
  display : function() {
    image(this.ard, location.x, location.y);
  }
}