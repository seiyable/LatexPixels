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

// declares variables to be used to set the servos position, these are intialized as 0
int servoAngle1;
int servoAngle2;
int servoAngle3;
int servoAngle4;
int servoAngle5;
int servoAngle6;

// declares integers to set the amplitude of the servo oscillation
int amp1;
int amp2;
int amp3;
int amp4;
int amp5;
int amp6;

// sets up the analog inputs for the piezo sensors
const int piezoSensor1 = A0;
const int piezoSensor2 = A1;
const int piezoSensor3 = A2;
const int piezoSensor4 = A3;
const int piezoSensor5 = A4;
const int piezoSensor6 = A5;

// declares integers to store the piezo sensor reading
int piezoValue1;
int piezoValue2;
int piezoValue3;
int piezoValue4;
int piezoValue5;
int piezoValue6;


// this sets the threshold for the piezo sensor readings to trigger an event
int threshold = 1000;

// declares a value that will be used to control servo oscillation speed
float frequency = 0.0;

// declare timers for the servos to delay
int countdown1 = 0;
int countdown2 = 0;
int countdown3 = 0;
int countdown4 = 0;
int countdown5 = 0;
int countdown6 = 0;

// declare multipliers for the piezo event trigger
int retMult1 = 1;
int retMult2 = 1;
int retMult3 = 1;
int retMult4 = 1;
int retMult5 = 1;
int retMult6 = 1;

// declare booleans for the piezo trigger
boolean retraction1 = false;
boolean retraction2 = false;
boolean retraction3 = false;
boolean retraction4 = false;
boolean retraction5 = false;
boolean retraction6 = false;


void setup() {
  Serial.begin(9600);

  // Runs the servos library's attach method to assign a digital output pin to each servo
  servoMotor1.attach(servoPin1);
  servoMotor2.attach(servoPin2);
  servoMotor3.attach(servoPin3);
  servoMotor4.attach(servoPin4);
  servoMotor5.attach(servoPin5);
  servoMotor6.attach(servoPin6);

}

void loop() {

  // this is the frequency iterator, it is used inside a sine function to create oscillation of the servo
  frequency += 0.009;

  // read the sensor and store it in the variable sensorReading:
  piezoValue1 = analogRead(piezoSensor1);
  piezoValue2 = analogRead(piezoSensor2);
  piezoValue3 = analogRead(piezoSensor3);
  piezoValue4 = analogRead(piezoSensor4);
  piezoValue5 = analogRead(piezoSensor5);
  piezoValue6 = analogRead(piezoSensor6);

  // countdown functionality >> when an event is triggered by a piezo this delays it
  countdown();
  
  // checks to see if the piezos have triggered an event
  piezoCheck();
  
  // iterates through the event if it has been triggered
  retractionCheck();
  
  servoAngle1 = 180 * abs(sin(frequency));
  servoAngle2 = 180 * abs(sin(frequency +.33));
  servoAngle3 = 180 * abs(sin(frequency + .66));
  servoAngle4 = 180 * abs(sin(frequency + 1));
  servoAngle5 = 180 * abs(sin(frequency + 1.33));
  servoAngle6 = 180 * abs(sin(frequency + 1.66));
  
//  servoAngle1 = 180;
//  servoAngle2 = 180;
//  servoAngle3 = 180;
//  servoAngle4 = 180;
//  servoAngle5 = 180;
//  servoAngle6 = 180;
  
  servoMotor1.write(servoAngle1);
  servoMotor2.write(servoAngle2);
  servoMotor3.write(servoAngle3);
  servoMotor4.write(servoAngle4);
  servoMotor5.write(servoAngle5);
  servoMotor6.write(servoAngle6);
  
  debug();

}

void countdown() {
  while (countdown1 > 0) {
    if (millis() % 5 == 0) {
      countdown1 --;
    }
  }
  while (countdown2 > 0) {
    if (millis() % 5 == 0) {
      countdown2 --;
    }
  }
  while (countdown3 > 0) {
    if (millis() % 5 == 0) {
      countdown3 --;
    }
  }
  while (countdown4 > 0) {
    if (millis() % 5 == 0) {
      countdown4 --;
    }
  }
  while (countdown5 > 0) {
    if (millis() % 5 == 0) {
      countdown5 --;
    }
  }
  while (countdown6 > 0) {
    if (millis() % 5 == 0) {
      countdown6 --;
    }
  }

  if (countdown1 <= 0) {
    retraction1 = false;
  }
  if (countdown2 <= 0) {
    retraction2 = false;
  }
  if (countdown3 <= 0) {
    retraction3 = false;
  }
  if (countdown4 <= 0) {
    retraction4 = false;
  }
  if (countdown5 <= 0) {
    retraction5 = false;
  }
  if (countdown6 <= 0) {
    retraction6 = false;
  }
}


void piezoCheck() {
  if (piezoValue1 >= threshold) {
    retraction1 = true;
    countdown1 = 4000;
    frequency = .025;
  }
  if (piezoValue2 >= threshold) {
    retraction2 = true;
    countdown2 = 3500;
    frequency = .025;
  }
  if (piezoValue3 >= threshold) {
    retraction3 = true;
    countdown3 = 1000;
    frequency = .025;
  }
  if (piezoValue4 >= threshold) {
    retraction4 = true;
    countdown4 = 2000;
    frequency = .025;
  }
  if (piezoValue5 >= threshold) {
    retraction5 = true;
    countdown5 = 10000;
    frequency = .025;
  }
  if (piezoValue6 >= threshold) {
    retraction6 = true;
    countdown6 = 6000;
    frequency = .025;
  }
}

void retractionCheck() {
  while (retraction1 = true && retMult1 > 1) {
    if (millis() % 5 == 0) {
      retMult1 --;
    }
  }
  while (retraction2 = true && retMult2 > 1) {
    if (millis() % 5 == 0) {
      retMult2 --;
    }
  }
  while (retraction2 = true && retMult2 > 1) {
    if (millis() % 5 == 0) {
      retMult2 --;
    }
  }
  while (retraction3 = true && retMult3 > 1) {
    if (millis() % 5 == 0) {
      retMult3 --;
    }
  }
  while (retraction4 = true && retMult4 > 1) {
    if (millis() % 5 == 0) {
      retMult4 --;
    }
  }
  while (retraction5 = true && retMult5 > 1) {
    if (millis() % 5 == 0) {
      retMult5 --;
    }
  }
  while (retraction6 = true && retMult6 > 1) {
    if (millis() % 5 == 0) {
      retMult6 --;
    }
  }
}

void debug(){  
  if (millis() % 1000 == 0) {
    Serial.print("piezo value1 : ");
    Serial.println(piezoValue1);
    Serial.print("piezo value2 : ");
    Serial.println(piezoValue2);
    Serial.print("piezo value3 : ");
    Serial.println(piezoValue3);
    Serial.print("piezo value4 : ");
    Serial.println(piezoValue4);
    Serial.print("piezo value5 : ");
    Serial.println(piezoValue5);
    Serial.print("piezo value6 : ");
    Serial.println(piezoValue6);
    
  }
}
