//=========== global variables ===========
import processing.serial.*; 
Serial myPort;
String incommingString = null;
boolean readyToReceive = true;
boolean readyToTransmit = false;
boolean sentSignalOnce = false;

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
  //incommingString = myPort.readStringUntil('\t');
  //incommingString = null;
}

//=========== draw() ===========
void draw() {
  background(200);  
  eManager.process();
  for (Module m : modules) {
    m.display();
  }

  serialWriting();
  serialReading();
}

//=========== serialWriting() ===========
void serialWriting() {

  //if ready to receive sensor values, send a signal to let Arduino transmit those values
  if (readyToReceive) {
    if (sentSignalOnce == false) {
      myPort.write('\n');
      println("sent n-signal");
      sentSignalOnce = true;
    }
  }

  //if ready to transmit servo values, transmit servo values to Arduino
  else if (readyToTransmit) {
    print("transmitted servo values: ");
    for (Module m : modules) {
      m.serialWrite();
    }
    println();
    myPort.write('\t'); //send a signal to tell Aduino that I've done transmitting servo values
    println("sent t-signal");
  }
}

//=========== serialReading() ===========
void serialReading() {
  while (myPort.available() > 0) {
    if (readyToReceive) {
      //receive sensor values from Arduino
      incommingString = myPort.readStringUntil('\n');

      if (incommingString != null) { //incommingString is null until it finds '\n'
        println("received sensor values: " + incommingString);
        println("received n-signal, so switch RX -> TX");
        //split it into array and store the data
        //~~~
        //~~~

        //now switch the flag
        readyToReceive = false;
        readyToTransmit = true;
        incommingString = null; //reset
      }
    }

    else if (readyToTransmit) {
      //wait for receiving a signal from Arduino
      int inByte = myPort.read();
      if (inByte == '\t') {
        println("received t-signal, so switch RX -> TX");

        //now switch the flag
        readyToReceive = true;
        readyToTransmit = false;
        sentSignalOnce = false;
      }
    }
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

