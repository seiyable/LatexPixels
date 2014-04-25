class Module {

  int polyN = 6; //must be even number to use magnet()

  PVector location;
  float radius = 20;
  PShape body;

  float h = 0, s = 90, v = 90;
  float angle = 0;
  boolean dragging = false;
  int[] connectedCheck;

  int id; //this ID data
  int[] neibor_ids;  //neiborhood's ID data

  float localClock = 0;
  float localClockSpeed = 3;
  float servoMax = 180;
  float servoAngle = 0;

  //=========== constructor ===========
  Module(float _lx, float _ly, int _id) {
    location = new PVector(_lx, _ly);
    id = _id;
    connectedCheck = new int[polyN];
    neibor_ids = new int[polyN];

    body = createShape();
    PVector outline = new PVector(0, -radius);
    body.beginShape();
    body.fill(300);
    for (int i = 0; i < polyN; i++) {
      body.vertex(outline.x, outline.y);
      outline.rotate(2*PI / polyN);
    }
    body.endShape(CLOSE);
    body.disableStyle();
  }

  //=========== display() ===========
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);

    /*
    int count = 0;
    for (int i = 0; i < polyN; i++){
      if (neibor_ids[i] > 0) {
        count += 1;
      }
    }
    if (count > 0){
      fill(0, 80, 100);
    } else {
      fill(300);
    }
    */
    fill(h, s, v);
    
    shape(body);
    fill(0);
    text(id, 0, 0);
    
    popMatrix();
  }

  //=========== outputID() ===========
  void outputID() {
  }

  //=========== startOrStopDragging ===========
  void startOrStopDragging() {
    //start dragging
    if (dragging == false) {
      float incircleRadius = radius*0.7;

      if ((mouseX > location.x - incircleRadius && mouseX < location.x + incircleRadius) &&
        (mouseY > location.y - incircleRadius && mouseY < location.y + incircleRadius)) {
        dragging = true;
      }
    } 
    //start dragging
    else if (dragging == true) {
      dragging = false;
      magnet();
    }
  }

  //=========== dragging ===========
  void dragging() {
    if (dragging == true) {
      location.set(mouseX, mouseY);
    }
  }

  //=========== checkDragging ===========
  int checkDragging() {
    if (dragging == true) {
      int count = 1;
      return count;
    } 
    else {
      int count = 0;
      return count;
    }
  }

  //=========== rotateModule() ===========
  void rotateModule() {
    float incircleRadius = radius*0.7;

    if ((mouseX > location.x - incircleRadius && mouseX < location.x + incircleRadius) &&
      (mouseY > location.y - incircleRadius && mouseY < location.y + incircleRadius)) {
      angle += 2*PI / polyN;
      if (angle >= 2*PI) {
        angle -= 2*PI;
      }
    }
  }

  //=========== resetConnectedCheck() ===========
  void resetConnectedCheck() {
    for (int i = 0; i < polyN; i++) {
      connectedCheck[i] = 0;
    }
  }

  //=========== updateConnectedCheck() ===========
  void updateConnectedCheck(int _ignoreMe) {
    for (int i = 0; i < polyN; i++) {
        connectedCheck[i] = neibor_ids[i];
    }
    if (_ignoreMe != -1) {
      connectedCheck[_ignoreMe] = 0;
    }
  }

  //=========== magnet() ===========
  void magnet() {
    float magnetRegionWidth = 20.0;

    //reset connection values first
    for (Module m : modules) {
      m.resetConnectedCheck();
      
      
      if (m.id != id) {
        int ignoreMe = -1;
        for (int i = 0; i < polyN; i++){
          if(neibor_ids[i] == m.id) {
            ignoreMe = i + polyN/2;
            if(ignoreMe >= polyN){
              ignoreMe -= polyN;
            }
          }
        }
        m.updateConnectedCheck(ignoreMe);
      }
    }

    //check every module
    for (Module m : modules) {
      if (m.id != id) {
        //vectors about this module
        PVector thisVertex1 = new PVector(0, -radius);
        PVector thisVertex2 = new PVector(0, -radius);
        thisVertex2.rotate(2*PI / polyN);

        //vectors about each one of other modules
        PVector otherVertex1 = new PVector(0, -radius);
        PVector otherVertex2 = new PVector(0, -radius);
        otherVertex1.rotate(PI); //opposite side of the module above
        otherVertex2.rotate(PI); //opposite side of the module above        
        otherVertex2.rotate(2*PI / polyN);

        //check each face of the module
        for (int i = 0; i < polyN; i++) {
          /*
          //for debugging ////////////////////////////////////////////
           int dbg_id = 1;
           int dbg_m_id = 2;
           int dbg_face = 3;
           ////////////////////////////////////////////////////////////
           */

          //calc the location of the middle point on each face of this module
          PVector thisFaceMiddle = new PVector(location.x, location.y);
          PVector thisFaceSegment = new PVector(0, 0);
          thisFaceSegment = PVector.sub(thisVertex2, thisVertex1);
          thisFaceSegment.mult(0.5);
          thisFaceMiddle.add(thisVertex1);
          thisFaceMiddle.add(thisFaceSegment);

          //calc the location of the ends of the face, 
          //which corresponds to the module's face calced above, 
          //of each one of other modules
          PVector otherFaceEnd1 = new PVector(m.location.x, m.location.y);
          PVector otherFaceEnd2 = new PVector(m.location.x, m.location.y);
          otherFaceEnd1.add(otherVertex1);
          otherFaceEnd2.add(otherVertex2);

          //magnet region box
          PVector boxVertex1 = otherFaceEnd1.get();
          PVector boxVertex2 = otherFaceEnd1.get();
          PVector boxVertex3 = otherFaceEnd2.get();
          PVector boxVertex4 = otherFaceEnd2.get();
          PVector boxWidth = new PVector(0, -magnetRegionWidth);
          boxWidth.rotate((2*PI / polyN)*(i+1) - (2*PI / polyN) / 2);
          boxVertex1.add(boxWidth);
          boxVertex3.add(boxWidth);
          boxWidth.rotate(PI);
          boxVertex2.add(boxWidth);
          boxVertex4.add(boxWidth);

          /*
          //for debugging ////////////////////////////////////////////
           if (id == dbg_id && m.id == dbg_m_id && i == dbg_face) {
           //region
           fill(150);
           noStroke();
           beginShape();
           vertex(boxVertex1.x, boxVertex1.y);
           vertex(boxVertex2.x, boxVertex2.y);
           vertex(boxVertex4.x, boxVertex4.y);
           vertex(boxVertex3.x, boxVertex3.y);
           endShape(CLOSE);
           fill(0, 100, 100);
           text("1", boxVertex1.x, boxVertex1.y);
           text("2", boxVertex2.x, boxVertex2.y);
           text("3", boxVertex3.x, boxVertex3.y);
           text("4", boxVertex4.x, boxVertex4.y);
           fill(0);
           
           //points
           strokeWeight(3);
           stroke(0);
           point(location.x, location.y);
           stroke(0, 0, 255);
           point(thisFaceMiddle.x, thisFaceMiddle.y);
           stroke(255, 0, 0);
           point(m.location.x, m.location.y);
           strokeWeight(1);
           line(otherFaceEnd1.x, otherFaceEnd1.y, otherFaceEnd2.x, otherFaceEnd2.y);
           }
           ////////////////////////////////////////////////////////////
           */

          //prepare for magnet judge
          thisFaceMiddle.sub(location);
          boxVertex1.sub(location);
          boxVertex2.sub(location);
          boxVertex3.sub(location);
          boxVertex4.sub(location);
          PVector delta = new PVector(0, 0); //will be used for new location
          delta = thisFaceMiddle.get();

          //PVector base = new PVector(0, -10);
          //float angleBtw = PVector.angleBetween(base, thisFaceMiddle);
          float rotateAngle = -((2*PI / polyN)*(i+1) - (2*PI / polyN) / 2);          
          thisFaceMiddle.rotate(rotateAngle);
          boxVertex1.rotate(rotateAngle);
          boxVertex2.rotate(rotateAngle);
          boxVertex3.rotate(rotateAngle);
          boxVertex4.rotate(rotateAngle);  

          //magnet check
          if (
          ((thisFaceMiddle.x > boxVertex3.x) && (thisFaceMiddle.y > boxVertex3.y)) &&
            ((thisFaceMiddle.x < boxVertex2.x) && (thisFaceMiddle.y < boxVertex2.y))  
            ) {
            //text("true:  " + i, 20, 20);
            PVector newLocation = new PVector(0, 0);
            newLocation = m.location.get();
            delta.rotate(PI);
            delta.mult(2);
            newLocation.add(delta);

            location.set(newLocation);
            connectedCheck[i] = m.id;
            int k = i + polyN/2;
            if (k >= polyN) {
              k -= polyN;
            }
            m.connectedCheck[k] = id;
          }

          /*
          //for debugging ////////////////////////////////////////////
           if (id == dbg_id && m.id == dbg_m_id && i == dbg_face) {
           text("id: " + id + ",  m.id: " + m.id + ",  face: " + i, 20, height - 120);
           text("thisMiddleX - otherUpperLeftX: " + (thisFaceMiddle.x - boxVertex3.x), 20, height - 100);
           if (thisFaceMiddle.x > boxVertex3.x) { 
           text("true", 300, height - 100);
           }
           text("thisMiddleY - otherUpperLeftY: " + (thisFaceMiddle.y - boxVertex3.y), 20, height - 80);
           if (thisFaceMiddle.y > boxVertex3.y) { 
           text("true", 300, height - 80);
           }
           text("thisMiddleX - otherLowerRightX: " + (thisFaceMiddle.x - boxVertex2.x), 20, height - 60);
           if (thisFaceMiddle.x < boxVertex2.x) { 
           text("true", 300, height - 60);
           }
           text("thisMiddleY - otherLowerRightY: " + (thisFaceMiddle.y - boxVertex2.y), 20, height - 40);
           if (thisFaceMiddle.y < boxVertex2.y) { 
           text("true", 300, height - 40);
           }
           }
           ////////////////////////////////////////////////////////////
           */

          //move to next face
          thisVertex1.rotate(2*PI / polyN);
          thisVertex2.rotate(2*PI / polyN);
          otherVertex1.rotate(2*PI / polyN);
          otherVertex2.rotate(2*PI / polyN);
        }
      }
    }

    for (Module m : modules) {    
      print("my id: " + m.id + ", ");         ///////////// for debugging
      for (int i = 0; i < polyN; i++) {
        if (m.connectedCheck[i] > 0) {
          m.neibor_ids[i] = m.connectedCheck[i];
        } 
        else {
          m.neibor_ids[i] = 0;
        }
        print(m.neibor_ids[i] + " ");       ///////////// for debugging
      }
      println();      ///////////// for debugging
    }
    println();     ///////////// for debugging
  }

  //=========== sinwaveBlink() ===========  
  void sinwaveBlink() {
    float theta = radians(floor(localClock) % 360);
    servoAngle = (1 +sin(theta - PI))*servoMax/2; // 0 ~ servoMax
    
    s = map(servoAngle, 0, servoMax, 0, 100);
  } 
  
  //=========== updateClock() ===========  
  void updateClock() {
    localClock += localClockSpeed;
  }
}

