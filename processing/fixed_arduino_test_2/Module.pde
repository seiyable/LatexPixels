class Module {
  //=========== in-class variables ===========
  int polyN;

  float radius;
  PVector location;
  MShape body;
  float moduleWidth;
  float moduleSide;

  float h = 0, s = 90, v = 90;

  int id; //this module's ID
  int[] neighbor_ids = {0, 0, 0, 0, 0, 0}; //neiborhoods' ID

  float servoMax = 179;
  float servoAngle = 120;
  
  int inputValue = 0;

  //=========== constructor ===========
  Module(int _polyN, float _r, float _lx, float _ly, int _id) {
    polyN = _polyN;
    radius = _r;
    location = new PVector(_lx, _ly);
    moduleWidth = 2*radius*sin((PI - (2*PI/polyN))/2);
    moduleSide = 2*radius*sin(PI/polyN);
    
    id = _id;
    body = new MShape(polyN, radius);
    
  }

  //=========== display() ===========
  void display() {
    pushMatrix();
    translate(location.x, location.y);

    s = map(servoAngle, servoMax, 0, 0, 100);

    fill(h, s, v);
    body.display();
    fill(0);
    text(id, 0, 0);
    
    popMatrix();
  }

  //=========== setMyNeighbors() ===========
  void setMyNeighbors() {
    for (Module m : modules) {
      float error = 2;
      
      if (((m.location.x - location.x > moduleWidth/2 - error) &&
           (m.location.x - location.x < moduleWidth/2 + error))
       && ((m.location.y - location.y > -(radius + moduleSide/2) - error) &&
           (m.location.y - location.y < -(radius + moduleSide/2) + error))) {
        neighbor_ids[0] = m.id;        
      }
      
      
      if (((m.location.x - location.x > moduleWidth - error) &&
           (m.location.x - location.x < moduleWidth + error))
       && ((m.location.y - location.y > -error) &&
           (m.location.y - location.y < error))) {
        neighbor_ids[1] = m.id;        
      }
      
      if (((m.location.x - location.x > moduleWidth/2 - error) &&
          (m.location.x - location.x < moduleWidth/2 + error))
      && ((m.location.y - location.y > radius + moduleSide/2 - error) &&
          (m.location.y - location.y < radius + moduleSide/2 + error))) {
        neighbor_ids[2] = m.id;        
      }
      
      if (((m.location.x - location.x > -moduleWidth/2 - error) &&
          (m.location.x - location.x < -moduleWidth/2 + error))
      && ((m.location.y - location.y > radius + moduleSide/2 - error) &&
          (m.location.y - location.y < radius + moduleSide/2 + error))) {
        neighbor_ids[3] = m.id;        
      }
      
      if (((m.location.x - location.x > -moduleWidth - error) &&
          (m.location.x - location.x < -moduleWidth + error))
      && ((m.location.y - location.y > -error) &&
          (m.location.y - location.y < error))) {
        neighbor_ids[4] = m.id;
        
      }
      if (((m.location.x - location.x > -moduleWidth/2 - error) &&
          (m.location.x - location.x < -moduleWidth/2 + error))
      && ((m.location.y - location.y > -(radius + moduleSide/2) - error) &&
          (m.location.y - location.y < -(radius + moduleSide/2) + error))) {
        neighbor_ids[5] = m.id;
      }
    }
  }
  
  //=========== showState() ===========
  void showState() {
    print("myID: " + id + " myNeighbors: ");
    for(int i = 0; i < polyN; i++){
      print(neighbor_ids[i] + " ");      
    }
    println();
  }
  
  //=========== serialWrite() ===========
  void serialWrite() {
    int sentValue = (int) floor(servoAngle);
    String tag =str(char(id + 64)); //convert int to char using ASCII,  id:1 -> 'A'
    myPort.write(sentValue + tag);
    //println(sentValue + tag);
  }
}

