class ExpLayer {
  //=========== in-class variables ===========
  Blink bl;

  //=========== constructor ===========
  ExpLayer() {
    bl = new Blink();
  }

  //=========== express() ===========
  void express() {
      bl.blinkIt();

  }

  //=========== keyCommand() ===========
  void keyCommand(char _key, int _id) {
    println(_key, _id);
    
    //-------- start blink --------
    if (_key == 'a') {
      bl.addList(_id);
    }

    //-------- stop blink --------
    if (_key == 'd') {
      bl.removeList(_id);
    }
  }

  //=========== updateClock() ===========  
  void updateClock() {
      bl.updateClock();
    
  }
}

