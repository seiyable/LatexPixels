//control servos with adafruit servo controller

#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

// called this way, it uses the default address 0x40
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();
// you can also call it with a different address you want
//Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x41);

// Depending on your servo make, the pulse width min and max may vary, you
// want these to be as small/large as possible without hitting the hard stop
// for max range. You'll have to tweak them as necessary to match the servos you
// have!
#define SERVOMIN  150 // this is the 'minimum' pulse length count (out of 4096)
#define SERVOMAX  600 // this is the 'maximum' pulse length count (out of 4096)

uint8_t servonum = 0;
int pulselength = 0;



// sets up the analog inputs for the piezo sensors
#define piezoSensor1 A0
#define piezoSensor2 A1
#define piezoSensor3 A2
#define piezoSensor4 A3
#define piezoSensor5 A4
#define piezoSensor6 A5

#define testLEDPin 13

boolean readyToTransmit = false;
boolean readyToReceive = true;

//=================== setup() ===================
void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
  pinMode(testLEDPin, OUTPUT);
  
  pwm.begin();
  pwm.setPWMFreq(60);  // Analog servos run at ~60 Hz updates

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
      Serial.print('\t'); //send a signal to tell Processing tharrrt I'm done transmitting sensor values
      break;
      
    case 'A':
      servonum = 0;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
      
    case 'B':
      digitalWrite(testLEDPin, HIGH);
      servonum = 1;
      pulselength = map(v, 0, 179, 150, 450);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
      
    case 'C':
      servonum = 2;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
      
    case 'D':
      servonum = 3;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;  

    case 'E':
      servonum = 4;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;

    case 'F':
      servonum = 5;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
    }
  }
}
