import processing.serial.*;
Serial myPort;                       // The serial port

boolean firstContact = false;        // Whether we've heard from the microcontroller
boolean redMouseOn = false;
boolean yellowMouseOn = false;
boolean greenMouseOn = false;
char sentValue = 'a';

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
  
  //------- red button to servoAngle1 -------
  if (redMouseOn) {
    fill(255, 0, 0);
    sentValue = 'a';
    myPort.write(sentValue);
    println("servoAngle1: " + sentValue);
  } else {
    fill(255);
    sentValue = 'z';
    myPort.write(sentValue);
    println("servoAngle1: " + sentValue);
  }
  ellipse(width/4, height/2, 40, 40);


  //------- yellow button to servoAngle2 -------
  if (yellowMouseOn) {
    fill(255, 255, 0);
    sentValue = 'b';
    myPort.write(sentValue);
    println("servoAngle2: " + sentValue);
  } else {
    fill(255);
    sentValue = 'z';
    myPort.write(sentValue);
    println("servoAngle2: " + sentValue);
  }
  ellipse(width/2, height/2, 40, 40);  

  //------- green button to servoAngle2 -------
  if (greenMouseOn) {
    fill(0, 255, 0);
    sentValue = 'c';
    myPort.write(sentValue);
    println("servoAngle3: " + sentValue);
  } else {
    fill(255);
    sentValue = 'z';
    myPort.write(sentValue);
    println("servoAngle3: " + sentValue);
  }
  ellipse(width*3/4, height/2, 40, 40);  
}

void mousePressed() {
  if (dist(mouseX, mouseY, width/4, height/2) < 20) {
    redMouseOn = true;
  } else if (dist(mouseX, mouseY, width/2, height/2) < 20) {
    yellowMouseOn = true;
  } else if (dist(mouseX, mouseY, width*3/4, height/2) < 20) {
    greenMouseOn = true;
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
      println("Hand has been shaken");
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      //myPort.write('A');       // ask for more
    } 
  }
}

