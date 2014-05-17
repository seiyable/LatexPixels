function RippleChild() {
  //=========== in-class variables ===========
  this.servoMax = 180;
  this.rippleIDs = [];
  this.clocks = [];
  this.clockSpeeds = [];
  this.lifespans =[];
}

RippleChild.prototype = {

  //=========== rippleIt() ===========  
  rippleIt : function() {

    for (var i = 0; i < modules.length; i++) {
      if (this.rippleIDs.indexOf(modules[i].id) >= 0) {
        var rippleIndex = this.rippleIDs.indexOf(modules[i].id);
        var counter = this.clocks[rippleIndex];

        if(counter >= this.lifespans[rippleIndex]){
          this.removeList(modules[i].id);
        } else {
          var theta = radians(this.clocks[rippleIndex] % 360);
          modules[i].servoAngle = (1 +sin(theta - PI))*this.servoMax/2; // 0 ~ servoMax
        }
      }
    }
  },

  //=========== addList() ===========
  addList : function(_id) {
    this.rippleIDs.push(_id);
    this.clocks.push(0.0);
    this.clockSpeeds.push(0.1);
    this.lifespans.push(18);

    for (var i = 0; i < modules.length; i++) {
      if (modules[i].id == _id) {
         modules[i].rippleOn = true;
      }
    }
  },

  //=========== removeList() ===========
  removeList : function(_id) {
    if (this.rippleIDs.length > 0) {
      if (this.rippleIDs.indexOf(_id) >= 0) {
        var removeIndex = this.rippleIDs.indexOf(_id);
        this.rippleIDs.splice(removeIndex, 1);
        this.clocks.splice(removeIndex, 1);
        this.clockSpeeds.splice(removeIndex, 1);
        this.lifespans.splice(removeIndex, 1);

        for (var i = 0; i < modules.length; i++) {
          if (modules[i].id == _id) {
            modules[i].servoAngle = this.servoMax/2;
            modules[i].rippleOn = false;
          }
        }
      }
    }
  },

  //=========== updateClock() ===========  
  updateClock : function() {
    for (var i = 0; i < this.clocks.length; i++){
      this.clocks[i] += this.clockSpeeds[i];
    }
  }
}
