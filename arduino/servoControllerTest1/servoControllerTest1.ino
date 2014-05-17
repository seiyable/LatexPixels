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


void setup() {
  Serial.begin(9600);

  pwm.begin();
  pwm.setPWMFreq(60);  // Analog servos run at ~60 Hz updates

  pinMode(button_1_pin, INPUT);
  pinMode(button_2_pin, INPUT);
  pinMode(button_3_pin, INPUT);
}

void loop() {

  servonum = 0;
  if (digitalRead(button_1_pin) == HIGH) {
      pwm.setPWM(servonum, 0, SERVOMAX);
  } else {
      pwm.setPWM(servonum, 0, SERVOMIN);
  }

  servonum = 1;
  if (digitalRead(button_2_pin) == HIGH) {
      pwm.setPWM(servonum, 0, SERVOMAX);
  } else {
      pwm.setPWM(servonum, 0, SERVOMIN);
  }
  
  servonum = 2;
  if (digitalRead(button_3_pin) == HIGH) {
      pwm.setPWM(servonum, 0, SERVOMAX);
  } else {
      pwm.setPWM(servonum, 0, SERVOMIN);
  }

}
