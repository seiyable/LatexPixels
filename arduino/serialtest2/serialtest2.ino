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




const int moduleN = 3;
String inputStrings[moduleN] = {"","",""};  // strings to hold incoming data
boolean stringComplete = false;  // whether the string is complete

void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
  
  // reserve 200 bytes for each of the inputString:
  for (int i = 0; i < moduleN; i++) {
    inputStrings[i].reserve(200);
  }
  
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
    if (inputStrings[0].toInt() == 179) {
      digitalWrite(testLEDPin, HIGH);
      servoAngle1 = inputStrings[0].toInt();
      servoAngle2 = inputStrings[1].toInt();
      servoAngle3 = inputStrings[2].toInt();
    }

    // clear the string:
    for (int i = 0; i < moduleN; i++) {
      inputStrings[i] = "";
    }
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
  String temp_inputString = "";
  int counter = 0;
  
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the temp inputString:
    if  (inChar != '\n' && inChar != '\t'){    
      temp_inputString += inChar;
    }
     // if the incoming character is a new line, move on to next string:
    if (inChar == '\n') {
      inputStrings[counter] = temp_inputString; //put it into array
      temp_inputString = ""; //initialize it
      counter++;
    } 
    
    // if the incoming character is end of line, set a flag
    // so the main loop can do something about it:
    if (inChar == '\t') {
      stringComplete = true;
      //digitalWrite(testLEDPin, HIGH);
      //Serial.write('A');
      //delay(300);
    } 
  }
}
