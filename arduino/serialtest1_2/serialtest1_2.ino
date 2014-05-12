#include <Servo.h>      // include the servo library

// instantiates 6 servo motors using the Servo library
Servo servoMotor1;
Servo servoMotor2;
Servo servoMotor3;
Servo servoMotor4;
Servo servoMotor5;
Servo servoMotor6;

// declares the digital pins on the arduino board to send signal to the servos
const int servoPin1 = 2;
const int servoPin2 = 4;
const int servoPin3 = 7;
const int servoPin4 = 8;
const int servoPin5 = 12;
const int servoPin6 = 13;
const int testLEDPin = 9;

// declares variables to be used to set the servos position, these are intialized as 0
int servoAngle1;
int servoAngle2;
int servoAngle3;
int servoAngle4;
int servoAngle5;
int servoAngle6;




String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete

void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
  
  // Runs the servos library's attach method to assign a digital output pin to each servo
  servoMotor1.attach(servoPin1);
  servoMotor2.attach(servoPin2);
  servoMotor3.attach(servoPin3);
  servoMotor4.attach(servoPin4);
  servoMotor5.attach(servoPin5);
  servoMotor6.attach(servoPin6);
  pinMode(testLEDPin, OUTPUT);
  

  establishContact();  // send a byte to establish contact until Processing responds 
}

void loop()
{
  
  serialEvent(); //for Yun
  
  if (stringComplete) {
    digitalWrite(testLEDPin, HIGH);
    //Serial.println(inputString);
    int val = inputString.toInt();
    if (val > 100 && val < 200) {
      servoAngle1 = 179;
      servoAngle2 = 0;
      servoAngle3 = 0;
    } else if (val > 200 && val < 300){
      servoAngle1 = 0;
      servoAngle2 = 179;
      servoAngle3 = 0;
    } else if (val > 300 && val < 400){
      servoAngle1 = 0;
      servoAngle2 = 0;
      servoAngle3 = 179;
    } else {
      servoAngle1 = 0;
      servoAngle2 = 0;
      servoAngle3 = 0;
    }
    // clear the string:
    inputString = "";
    stringComplete = false;
  } 
  
  servoMotor1.write(servoAngle1);
  servoMotor2.write(servoAngle2);
  servoMotor3.write(servoAngle3);
  //servoMotor4.write(servoAngle4);
  //servoMotor5.write(servoAngle5);
  //servoMotor6.write(servoAngle6);
  
  delay(100);
  Serial.write('A');
}

void establishContact() {
 while (Serial.available() <= 0) {
      Serial.write('A');   // send a capital A
      delay(300);
  }
}

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    } 
  }
}
