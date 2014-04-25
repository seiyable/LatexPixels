class Arduino {
  //=========== in-class variables ===========
  PVector location;
  PImage ard;
  float imageWidth;

  //=========== constructor ===========
  Arduino(float _lx, float _ly, int _imageWidth) {
    location = new PVector(_lx, _ly);
    ard = loadImage("arduino_Uno.png");
    ard.resize(_imageWidth, 0);
  }

  //=========== display() ===========
  void display() {
    image(ard, location.x, location.y);
  }
}

