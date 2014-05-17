function Ripple() {
  //=========== in-class variables ===========
  this.servoMax = 180;
  this.rippleChildren = []; //array in array
  this.stepCounts = [];
  this.nextStepTiming = [];
  this.childrensLifespans = [];
  this.baseModuleIDs = []; //array in array
  this.clocks = [];
  this.clockSpeeds = [];
  this.lifespans =[];
}

Ripple.prototype = {
  //=========== rippleIt() ===========  
  rippleIt : function() {
    for (var i = 0; i < this.rippleChildren.length; i++){
      for (var j = 0; j < this.rippleChildren[i].length; j++){
        this.rippleChildren[i][j].rippleChildIt();
      }
    }

  },

  //=========== generateRippleChildren() ===========  
  generateRippleChildren : function(_index) {
    this.rippleChildren[_index].push(new RippleChild(this.stepCounts[_index], this.childrensLifespans[_index]));
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
