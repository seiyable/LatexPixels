function Rise() {
  //=========== in-class variables ===========
  this.servoMax = 180;
  this.riseIDs = [];
  this.clocks = [];
  this.clockSpeeds = [];
  this.lifespans =[];
}

Rise.prototype = {

  //=========== riseIt() ===========  
  riseIt : function() {

    for (var i = 0; i < modules.length; i++) {
      if (this.riseIDs.indexOf(modules[i].id) >= 0) {
        var riseIndex = this.riseIDs.indexOf(modules[i].id);
        var counter = this.clocks[riseIndex];

        if(counter >= this.lifespans[riseIndex]){
          this.removeList(modules[i].id);
          console.log(i+1, 'Rise off');
          sendmessage({id: i+1, mode: 'Rise', value: false});
          $.get("/output/" + (i+1) + "B" );
        } else {
          modules[i].servoAngle = this.servoMax; // 0 ~ servoMax
        }
      }
    }
  },

  //=========== addList() ===========
  addList : function(_id) {
    this.riseIDs.push(_id);
    this.clocks.push(0.0);
    this.clockSpeeds.push(0.1);
    this.lifespans.push(18);
    for (var i = 0; i < modules.length; i++) {
      if (modules[i].id == _id) {
         modules[i].riseOn = true;
      }
    }
  },

  //=========== removeList() ===========
  removeList : function(_id) { 
    if (this.riseIDs.length > 0) {
      if (this.riseIDs.indexOf(_id) >= 0) {
        var removeIndex = this.riseIDs.indexOf(_id);
        this.riseIDs.splice(removeIndex, 1);
        this.clocks.splice(removeIndex, 1);
        this.clockSpeeds.splice(removeIndex, 1);
        this.lifespans.splice(removeIndex, 1);

        for (var i = 0; i < modules.length; i++) {
          if (modules[i].id == _id) {
            modules[i].servoAngle = this.servoMax/2;
            modules[i].riseOn = false;
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
