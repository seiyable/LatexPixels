function Module(_polyN, _r, _lx, _ly, _id) {
  //=========== in-class variables ===========
  this.polyN = _polyN; //must be even number to use magnet()

  this.location = new PVector(_lx, _ly);
  this.radius = _r;
  this.body = new MShape(this.polyN, this.radius);

  this.h = 0, this.s = 255, this.v = 255;
  this.angle = 0;
  this.dragging = false;
  this.connectedCheck = new Array(this.polyN);

  this.id = _id; //this ID data
  this.neibor_ids = new Array(this.polyN);  //neiborhood's ID data

  this.clock = 0;
  this.clockSpeed = 0.1;
  this.servoMax = 180;
  this.servoAngle = 0;
}

Module.prototype = {

  //=========== display() ===========
  display : function() {
    pushMatrix();
    translate(this.location.x, this.location.y);
    rotate(this.angle);
    
    /*
    //change color when it is connected to others
    var count = 0;
    for (var i = 0; i < this.polyN; i++){
      if (this.neibor_ids[i] > 0) {
        count += 1;
      }
    }
    if (count > 0){
      this.h = 0, this.s = 255, this.v = 255;
    } else {
      this.h = 0, this.s = 0, this.v = 200;
    }
    */

    var fillColors = this.hsv2rgb(this.h, this.s, this.v);
    fill(fillColors.r, fillColors.g, fillColors.b);
    
    this.body.display();
    fill(0);
    text(this.id, 0, 0);
    
    popMatrix();
  },

  //=========== outputID() ===========
  outputID : function() {

  },

  //=========== startOrStopDragging ===========
  startOrStopDragging : function() {
    //start dragging
    if (this.dragging == false) {
      var incircleRadius = this.radius*0.7;

      if ((mouseX > this.location.x - incircleRadius && mouseX < this.location.x + incircleRadius) &&
        (mouseY > this.location.y - incircleRadius && mouseY < this.location.y + incircleRadius)) {
        this.dragging = true;
      }
    } 
    //start dragging
    else if (this.dragging == true) {
      this.dragging = false;
      this.magnet();
    }
  },

  //=========== dragging ===========
  draggingOn : function() {
    if (this.dragging == true) {
      this.location.set(mouseX, mouseY);
    }
  },

  //=========== checkDragging ===========
  checkDragging : function() {
    if (this.dragging == true) {
      var count = 1;
      return count;
    } 
    else {
      var count = 0;
      return count;
    }
  },

  //=========== rotateModule() ===========
  rotateModule : function() {
    var incircleRadius = this.radius*0.7;

    if ((mouseX > this.location.x - incircleRadius && mouseX < this.location.x + incircleRadius) &&
      (mouseY > this.location.y - incircleRadius && mouseY < this.location.y + incircleRadius)) {
      this.angle += 2*PI / this.polyN;
      if (this.angle >= 2*PI) {
        this.angle -= 2*PI;
      }
    }
  },

  //=========== resetConnectedCheck() ===========
  resetConnectedCheck : function() {
    for (var i = 0; i < this.polyN; i++) {
      this.connectedCheck[i] = 0;
    }
  },

  //=========== updateConnectedCheck() ===========
  updateConnectedCheck : function(_ignoreMe) {
    for (var i = 0; i < this.polyN; i++) {
        this.connectedCheck[i] = this.neibor_ids[i];
    }
    if (_ignoreMe != -1) {
      this.connectedCheck[_ignoreMe] = 0;
    }
  },

  //=========== magnet() ===========
  magnet : function() {
    var magnetRegionWidth = 20.0;

    //reset connection values first
    for(var i = 0; i < modules.length; i++){
      modules[i].resetConnectedCheck();
      
      
      if (modules[i].id != this.id) {
        var ignoreMe = -1;
        for (var j = 0; j < this.polyN; j++){
          if(this.neibor_ids[j] == modules[i].id) {
            ignoreMe = j + this.polyN/2;
            if(ignoreMe >= this.polyN){
              ignoreMe -= this.polyN;
            }
          }
        }
        modules[i].updateConnectedCheck(ignoreMe);
      }
    }

    //check every module
    for(var i = 0; i < modules.length; i++){
      if (modules[i].id != this.id) {
        //vectors about this module
        var thisVertex1 = new PVector(0, -this.radius);
        var thisVertex2 = new PVector(0, -this.radius);
        thisVertex2.rotate2D(2*PI / this.polyN);

        //vectors about each one of other modules
        var otherVertex1 = new PVector(0, -this.radius);
        var otherVertex2 = new PVector(0, -this.radius);
        otherVertex1.rotate2D(PI); //opposite side of the module above
        otherVertex2.rotate2D(PI); //opposite side of the module above        
        otherVertex2.rotate2D(2*PI / this.polyN);

        //check each face of the module
        for (var j = 0; j < this.polyN; j++) {

          //calc the location of the middle point on each face of this module
          var thisFaceMiddle = new PVector(this.location.x, this.location.y);
          var thisFaceSegment = new PVector(0, 0);
          thisFaceSegment = PVector.sub(thisVertex2, thisVertex1);
          thisFaceSegment.mult(0.5);
          thisFaceMiddle.add(thisVertex1);
          thisFaceMiddle.add(thisFaceSegment);

          //calc the location of the ends of the face, 
          //which corresponds to the module's face calced above, 
          //of each one of other modules
          var otherFaceEnd1 = new PVector(modules[i].location.x, modules[i].location.y);
          var otherFaceEnd2 = new PVector(modules[i].location.x, modules[i].location.y);
          otherFaceEnd1.add(otherVertex1);
          otherFaceEnd2.add(otherVertex2);

          //magnet region box
          var boxVertex1 = otherFaceEnd1.get();
          var boxVertex2 = otherFaceEnd1.get();
          var boxVertex3 = otherFaceEnd2.get();
          var boxVertex4 = otherFaceEnd2.get();
          var boxWidth = new PVector(0, -magnetRegionWidth);
          boxWidth.rotate2D((2*PI / this.polyN)*(j+1) - (2*PI / this.polyN) / 2);
          boxVertex1.add(boxWidth);
          boxVertex3.add(boxWidth);
          boxWidth.rotate2D(PI);
          boxVertex2.add(boxWidth);
          boxVertex4.add(boxWidth);

          //prepare for magnet judge
          thisFaceMiddle.sub(this.location);
          boxVertex1.sub(this.location);
          boxVertex2.sub(this.location);
          boxVertex3.sub(this.location);
          boxVertex4.sub(this.location);
          var delta = new PVector(0, 0); //will be used for new location
          delta = thisFaceMiddle.get();

          //PVector base = new PVector(0, -10);
          //float angleBtw = PVector.angleBetween(base, thisFaceMiddle);
          var rotateAngle = -((2*PI / this.polyN)*(j+1) - (2*PI / this.polyN) / 2);          
          thisFaceMiddle.rotate2D(rotateAngle);
          boxVertex1.rotate2D(rotateAngle);
          boxVertex2.rotate2D(rotateAngle);
          boxVertex3.rotate2D(rotateAngle);
          boxVertex4.rotate2D(rotateAngle);  

          //magnet check
          if (
          ((thisFaceMiddle.x > boxVertex3.x) && (thisFaceMiddle.y > boxVertex3.y)) &&
            ((thisFaceMiddle.x < boxVertex2.x) && (thisFaceMiddle.y < boxVertex2.y))  
            ) {
            //text("true:  " + i, 20, 20);
            var newLocation = new PVector(0, 0);
            newLocation = modules[i].location.get();
            delta.rotate2D(PI);
            delta.mult(2);
            newLocation.add(delta);

            this.location.set(newLocation);
            this.connectedCheck[j] = modules[i].id;
            var k = j + this.polyN/2;
            if (k >= this.polyN) {
              k -= this.polyN;
            }
            modules[i].connectedCheck[k] = this.id;
          }

          //move to next face
          thisVertex1.rotate2D(2*PI / this.polyN);
          thisVertex2.rotate2D(2*PI / this.polyN);
          otherVertex1.rotate2D(2*PI / this.polyN);
          otherVertex2.rotate2D(2*PI / this.polyN);
        }
      }
    }

    for(var i = 0; i < modules.length; i++){
      var print = "myID: " + modules[i].id + ",  neiborsID: ";         ///////////// for debugging
      for (var j = 0; j < this.polyN; j++) {
        if (modules[i].connectedCheck[j] > 0) {
          modules[i].neibor_ids[j] = modules[i].connectedCheck[j];
        } 
        else {
          modules[i].neibor_ids[j] = 0;
        }
        print += modules[i].neibor_ids[j] + " ";       ///////////// for debugging
      }
      console.log(print);      ///////////// for debugging
    }
    console.log("-------------------");     ///////////// for debugging
  },

  //=========== hsv2rgb() ===========
  hsv2rgb : function(h, s, v) {
    var r, g, b; // 0~255
    
    while (h < 0) {
      h += 360;
    }

    h = h % 360;

    // special case: saturation = 0
    if (s == 0) {
      // → each value of rgb equals to v
      v = Math.round(v);
      return {'r': v, 'g': v, 'b': v};
    }

    s = s / 255;

    var i = Math.floor(h / 60) % 6,
        f = (h / 60) - i,
        p = v * (1 - s),
        q = v * (1 - f * s),
        t = v * (1 - (1 - f) * s);

    switch (i) {
      case 0 :
        r = v;  g = t;  b = p;  break;
      case 1 :
        r = q;  g = v;  b = p;  break;
      case 2 :
        r = p;  g = v;  b = t;  break;
      case 3 :
        r = p;  g = q;  b = v;  break;
      case 4 :
        r = t;  g = p;  b = v;  break;
      case 5 :
        r = v;  g = p;  b = q;  break;
    }

    return {'r': Math.round(r), 'g': Math.round(g), 'b': Math.round(b)};
  },

  //=========== sinwaveBlink() ===========
  sinwaveBlink : function() {
    var theta = radians(this.clock % 360);
    this.servoAngle = (1 +sin(theta - PI))*this.servoMax/2; // 0 ~ servoMax
  
    this.s = map(this.servoAngle, 0, this.servoMax, 0, 255);
  },

  //=========== updateClock() ===========  
  updateClock : function() {
    this.clock += this.clockSpeed;
  },
}
