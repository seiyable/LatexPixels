#define redPin 8
#define yellowPin 9
#define greenPin 10

String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete

void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
  
  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);

  establishContact();  // send a byte to establish contact until Processing responds 
}

void loop()
{
  
  serialEvent(); //for Yun
  
  if (stringComplete) {
    //Serial.println(inputString);
    int val = inputString.toInt();
    if (val > 100 && val < 200) {
      digitalWrite(redPin, HIGH);
      digitalWrite(yellowPin, LOW);
      digitalWrite(greenPin, LOW);
    } else if (val > 200 && val < 300){
      digitalWrite(redPin, LOW);
      digitalWrite(yellowPin, HIGH);
      digitalWrite(greenPin, LOW);
    } else if (val > 300 && val < 400){
      digitalWrite(redPin, LOW);
      digitalWrite(yellowPin, LOW);
      digitalWrite(greenPin, HIGH);
    } else {
      digitalWrite(redPin, LOW);
      digitalWrite(yellowPin, LOW);
      digitalWrite(greenPin, LOW);      
    }
    // clear the string:
    inputString = "";
    stringComplete = false;
  }
  
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
