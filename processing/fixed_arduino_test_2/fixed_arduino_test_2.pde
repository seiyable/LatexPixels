//=========== global variables ===========
import processing.serial.*; 
Serial myPort;
String incommingString = null;

ArrayList<Module> modules = new ArrayList<Module>();
int initialModulesN = 6;
ExpManager eManager = new ExpManager();

//=========== setup() ===========
void setup() {
  size(1000, 600, P2D); 
  colorMode(HSB, 360, 100, 100);

  for (int i = 1; i <= initialModulesN; i++) {
    int polyN = 6;
    float r = 40;
    float moduleWidth = 2*r*sin((PI - (2*PI/polyN))/2);
    float moduleSide = 2*r*sin(PI/polyN);
    float lx = 0;
    float ly = 0;

    if (i >= 1 && i <= 3) {
      lx = width/2 - moduleWidth*3/2 + moduleWidth*(i-1);
      ly = height/2 - r*3 - moduleSide*3/2;
    } 
    else if (i >= 4 && i <= 6) {
      lx = width/2 + moduleWidth*(i-5);
      ly = height/2 - r*2 - moduleSide;
    } 

    int id = i;
    
    modules.add(new Module(polyN, r, lx, ly, id));
  }

  for (Module m : modules) {
    m.setMyNeighbors();
  }
  
  printArray(Serial.list());
  String portName = Serial.list()[9];
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  incommingString = myPort.readStringUntil('\n');
  incommingString = null;
}

//=========== draw() ===========
void draw() {
  background(200);
  getSerialData();
  myPort.clear();

  eManager.process();

  for (Module m : modules) {
    m.display();
  }
  
  for (Module m : modules) {
      m.serialWrite();
  }
}

//=========== keyPressed() ===========
void keyPressed() {
  int id = 0;
    //get module's id at the current mouse position
    for (Module m : modules) {
      float incircleRadius = m.radius*0.7;
      if ((mouseX > m.location.x - incircleRadius && mouseX < m.location.x + incircleRadius) &&
        (mouseY > m.location.y - incircleRadius && mouseY < m.location.y + incircleRadius)) {
        id = m.id;
      }
    }
    
  eManager.keyHandler(key, id);

  //-------- debug --------
  if (key == 'z') {
    for (Module m : modules) {
      m.showState();
    }
  }
}

//=========== mousePressed() ===========
void mousePressed() {
}


//=========== getSerialData() ===========
void getSerialData() {
  while(myPort.available() > 0){
    incommingString = myPort.readStringUntil('\n');
    if (incommingString != null) {
      println(incommingString);
    }
  }

  /*
  if (inByte == '\t') { //start byte
    startStoring = true; 
  } else if (inByte == '\n') { //end byte
    startStoring = false; 
  }
  
  if (startStoring) {
  // Add the latest byte from the serial port to array:
  serialInArray[serialCount] = inByte;
  serialCount++;

    // If we have 12 bytes:
    if (serialCount > 11 && serialInArray[0] == '\t') {
      for (int i = 0; i < modules.size(); i++) {
        //Module m = modules.get(i);
        //m.inputValule = serialInArray[2*i+1]; // read i+1 to ignore start byte '/t'
        //println(m.id + ": " + m.inputValule);
        //print("id: " + i + " value: " + serialInArray[2*i+1] + ", ");
      }
      //println();
      // Reset serialCount:
      serialCount = 0;
    }
  }
  */
}



