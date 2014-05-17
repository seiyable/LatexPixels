//work with processing file named "serialtest3"

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

// our servo # counter
uint8_t servonum = 0;


//button pins
#define button_1_pin 5
#define button_2_pin 6
#define button_3_pin 7

int pulselength = 0;

void setup() {
  Serial.begin(9600);

  pwm.begin();
  pwm.setPWMFreq(60);  // Analog servos run at ~60 Hz updates

  pinMode(button_1_pin, INPUT);
  pinMode(button_2_pin, INPUT);
  pinMode(button_3_pin, INPUT);
}

void loop() {

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
      servonum = 0;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
      
    case 'y':
      servonum = 1;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
      
    case 'g':
      servonum = 2;
      pulselength = map(v, 0, 179, SERVOMIN, SERVOMAX);
      pwm.setPWM(servonum, 0, pulselength);
      v = 0;
      break;
    }
  }
}
