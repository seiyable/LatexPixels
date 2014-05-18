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
#define servoPin1 2
#define servoPin2 7
#define servoPin3 12
#define servoPin4 4
#define servoPin5 8
#define servoPin6 13
#define testLEDPin 9

// sets up the analog inputs for the piezo sensors
#define piezoSensor1 A0
#define piezoSensor2 A1
#define piezoSensor3 A2
#define piezoSensor4 A3
#define piezoSensor5 A4
#define piezoSensor6 A5

//=================== setup() ===================
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

//=================== loop() ===================
void loop()
{
  receiveServoValuesFromServer();
  moveServoMotors();
}

//=================== reeciveServoValuesFromServer() ===================
void receiveServoValuesFromServer(){
  
  static int v = 0;
  if (Serial.available()) {
    char ch = Serial.read();
    switch(ch) {
    case '0'...'9':
      v = v * 10 + ch - '0';
      break;
      
    case 'A':
      //rise on

      v = 0;
      break;
      
    case 'B':
      //rise off

      v = 0;
      break;
      
    case 'C':
      //fall on

      v = 0;
      break;
      
    case 'D':
      //fall off

      v = 0;
      break;  

    case 'E':
      //pulse on

      v = 0;
      break;

    case 'F':
      //pulse off

      v = 0;
      break;

    case 'G':
      //ripple on

      v = 0;
      break;

    case 'H':
      //ripple off

      v = 0;
      break;




    case 'Z':
      //reset

      v = 0;
      break;
    }
  }
}

//=================== moveServoMotors() ===================
void moveServoMotors(){
  //move servos
  
}


