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

boolean readyToTransmit = false;
boolean readyToReceive = true;

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

  if (readyToTransmit) transmitSensorValuesToProcessing();  
  if (readyToReceive) receiveServoValuesFromProcessing();
  
}

//=================== transmitSensorValuesToProcessing() ===================
void transmitSensorValuesToProcessing(){
  
    Serial.print(analogRead(piezoSensor1));
    Serial.print(',');
    Serial.print(analogRead(piezoSensor2));
    Serial.print(',');
    Serial.print(analogRead(piezoSensor3));
    Serial.print(',');
    Serial.print(analogRead(piezoSensor4));
    Serial.print(',');
    Serial.print(analogRead(piezoSensor5));
    Serial.print(',');
    Serial.print(analogRead(piezoSensor6));
    Serial.print('\n'); //send a signal to tell Processing that I'm done transmitting sensor values

    //now switch the flag
    readyToTransmit = false;
    readyToReceive = true;
}

//=================== reeciveServoValuesFromProcessing() ===================
void receiveServoValuesFromProcessing(){
  
  static int v = 0;
  if (Serial.available()) {
    char ch = Serial.read();
    switch(ch) {
    case '0'...'9':
      v = v * 10 + ch - '0';
      break;

    case '\n':  //this means that Processing is ready to receive sensor values
      //now switch the flag
      readyToTransmit = true;
      readyToReceive = false;
    
      v = 0;
      break;
      
    case '\t':  //this means that Processing has done transmiting all of the servo values
      v = 0;
      Serial.print('\t'); //send a signal to tell Processing that I'm done transmitting sensor values
      break;
      
    case 'A':
      servoMotor1.write(v);
      v = 0;
      break;
      
    case 'B':
      servoMotor2.write(v);
      v = 0;
      break;
      
    case 'C':
      servoMotor3.write(v);
      v = 0;
      break;
      
    case 'D':
      servoMotor4.write(v);
      v = 0;
      break;  

    case 'E':
      servoMotor5.write(v);
      v = 0;
      break;

    case 'F':
      servoMotor6.write(v);
      v = 0;
      break;
    }
  }
}


