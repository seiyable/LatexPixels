#define redPin 8
#define yellowPin 9
#define greenPin 10

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
  
  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  

  establishContact();  // send a byte to establish contact until Processing responds 
}

void loop()
{
  serialEvent(); //for Yun
  if (stringComplete) {
    if (inputStrings[0].toInt() == 179) {
      digitalWrite(redPin, HIGH);
    } else if (inputStrings[0].toInt() == 0) {
      digitalWrite(redPin, LOW);
    }
    delay(10);
    
    if (inputStrings[1].toInt() == 179) {
      digitalWrite(yellowPin, HIGH);
    } else if (inputStrings[1].toInt() == 0) {
      digitalWrite(yellowPin, LOW);
    }
    delay(10);

    if (inputStrings[2].toInt() == 179) {
      digitalWrite(greenPin, HIGH);
    } else if (inputStrings[2].toInt() == 0) {
      digitalWrite(greenPin, LOW);
    }
    delay(10);

    // clear the string:
    for (int i = 0; i < moduleN; i++) {
      inputStrings[i] = "";
    }
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
      digitalWrite(yellowPin, HIGH);
      stringComplete = true;
      break;
      //digitalWrite(testLEDPin, HIGH);
      //Serial.write('A');
      //delay(300);
    }
    
    delay(10);
  }
}
