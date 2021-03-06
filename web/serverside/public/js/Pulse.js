function Pulse() {
  //=========== in-class variables ===========
  this.servoMax = 180;
  this.pulseIDs = [];
  this.clocks = [];
  this.clockSpeeds = [];
  this.lifespans =[];
}

Pulse.prototype = {

  //=========== pulseIt() ===========  
  pulseIt : function() {

    for (var i = 0; i < modules.length; i++) {
      if (this.pulseIDs.indexOf(modules[i].id) >= 0) {
        var pulseIndex = this.pulseIDs.indexOf(modules[i].id);
        var counter = this.clocks[pulseIndex];

        if(counter >= this.lifespans[pulseIndex]){
          this.removeList(modules[i].id);
          console.log(i+1, 'Pulse off');
          sendmessage({id: i+1, mode: 'Pulse', value: false});
          $.get("/output/" + (i+1) + "F" );
        } else {
          var theta = radians(this.clocks[pulseIndex] % 360);
          modules[i].servoAngle = (1 +sin(theta - PI))*this.servoMax/2; // 0 ~ servoMax
        }
      }
    }
  },

  //=========== addList() ===========
  addList : function(_id) {
    this.pulseIDs.push(_id);
    this.clocks.push(0.0);
    this.clockSpeeds.push(0.1);
    this.lifespans.push(18);

    for (var i = 0; i < modules.length; i++) {
      if (modules[i].id == _id) {
         modules[i].pulseOn = true;
      }
    }
  },

  //=========== removeList() ===========
  removeList : function(_id) {
    if (this.pulseIDs.length > 0) {
      if (this.pulseIDs.indexOf(_id) >= 0) {
        var removeIndex = this.pulseIDs.indexOf(_id);
        this.pulseIDs.splice(removeIndex, 1);
        this.clocks.splice(removeIndex, 1);
        this.clockSpeeds.splice(removeIndex, 1);
        this.lifespans.splice(removeIndex, 1);

        for (var i = 0; i < modules.length; i++) {
          if (modules[i].id == _id) {
            modules[i].servoAngle = this.servoMax/2;
            modules[i].pulseOn = false;
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
