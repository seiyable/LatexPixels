//control servos

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

//// declares variables to be used to set the servos position, these are intialized as 0
//int servoAngle1;
//int servoAngle2;
//int servoAngle3;
//int servoAngle4;
//int servoAngle5;
//int servoAngle6;

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
}

void loop()
{
  getSerialData();
}

void getSerialData(){
  static int v = 0;
  if (Serial.available()) {
    char ch = Serial.read();
    switch(ch) {
    case '0'...'9':
      v = v * 10 + ch - '0';
      break;
      
    case 'r':
      servoMotor1.write(v);
      v = 0;
      break;
      
    case 'y':
      servoMotor2.write(v);
      v = 0;
      break;
      
    case 'g':
      servoMotor3.write(v);
      v = 0;
      break;
    }
  }
}
