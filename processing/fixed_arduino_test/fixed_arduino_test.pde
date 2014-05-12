//=========== global variables ===========
import processing.serial.*; 
Serial myPort;
boolean firstContact = false;        // Whether we've heard from the microcontroller

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
}

//=========== draw() ===========
void draw() {
  background(200);

  eManager.process();

  for (Module m : modules) {
    m.display();
  }
  
  for (Module m : modules) {
    //if (m.id == 1){
      m.serialWrite();
    //}
  }
  myPort.write('\0');
  myPort.clear();
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

//=========== serialEvent() ===========
void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  if (inByte == 'A') {
    println("got request from Arduino");
  }
  
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      println("Hand has been shaked");
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    } 
  }
}


