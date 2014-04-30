function ExpLayer() {
  //=========== in-class variables ===========
  this.bl;
  this.bl = new Blink();
}

ExpLayer.prototype = {
  //=========== loop() ===========
  loop : function() {
      this.bl.blinkIt();
  },

  //=========== keyHandler() ===========
  keyHandler : function(_key, _id) {    
    //-------- start blink --------
    if (_key == 'A') {
      this.bl.addList(_id);
    }

    //-------- stop blink --------
    if (_key == 'D') {
      this.bl.removeList(_id);
    }
  },

  //=========== updateClock() ===========  
  updateClock : function() {
    this.bl.updateClock();    
  }
}
