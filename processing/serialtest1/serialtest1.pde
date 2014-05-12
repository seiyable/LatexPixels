import processing.serial.*;
Serial myPort;                       // The serial port

boolean firstContact = false;        // Whether we've heard from the microcontroller
boolean redMouseOn = false;
boolean yellowMouseOn = false;
boolean greenMouseOn = false;
int sentValue = 0;

void setup() {
  size(256, 256);  // Stage size
  noStroke();      // No border on the next thing drawn

  // Print a list of the serial ports, for debugging purposes:
  printArray(Serial.list());

  String portName = Serial.list()[9];
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(200);
  if (redMouseOn) {
    fill(255, 0, 0); 
  } else {
    fill(255);
  }
  ellipse(width/4, height/2, 40, 40);

  if (yellowMouseOn) {
    fill(255, 255, 0); 
  } else {
    fill(255);
  }
  ellipse(width/2, height/2, 40, 40);  

  if (greenMouseOn) {
    fill(0, 255, 0); 
  } else {
    fill(255);
  }
  ellipse(width*3/4, height/2, 40, 40);  
  
}

void mousePressed() {
  if (dist(mouseX, mouseY, width/4, height/2) < 20) {
    redMouseOn = true;
    sentValue = 150;
    myPort.write(str(sentValue));
    myPort.write('\n');
  } else if (dist(mouseX, mouseY, width/2, height/2) < 20) {
    yellowMouseOn = true;
    sentValue = 250;
    myPort.write(str(sentValue));
    myPort.write('\n');
  } else if (dist(mouseX, mouseY, width*3/4, height/2) < 20) {
    greenMouseOn = true;
    sentValue = 350;
    myPort.write(str(sentValue));
    myPort.write('\n');
  } else {
    redMouseOn = false;
    yellowMouseOn = false;
    greenMouseOn = false; 
  }
}

void mouseReleased() {
  redMouseOn = false;
  yellowMouseOn = false;
  greenMouseOn = false; 
  sentValue = 50;
  myPort.write(str(sentValue));
  myPort.write('\n');
}

void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      println("Hand has been shaked");
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      //myPort.write('A');       // ask for more
    } 
  }
}

