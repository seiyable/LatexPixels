#define redPin 8
#define yellowPin 9
#define greenPin 10

const int moduleN = 3;
char inputChars[moduleN+1] = {'z','z','z'};  // strings to hold incoming data

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
  if (Serial.available() >= moduleN) {
    for (int i = 0; i < moduleN; i++) {
      inputChars[i] = Serial.read();
    }
    Serial.flush();
  }
  
    if (inputChars[0] == 'a') {
      digitalWrite(redPin, HIGH);
    } else {
      digitalWrite(redPin, LOW);
    }
    
    if (inputChars[1] == 'b') {
      digitalWrite(yellowPin, HIGH);
    } else {
      digitalWrite(yellowPin, LOW);
    }

    if (inputChars[2] == 'c') {
      digitalWrite(greenPin, HIGH);
    } else {
      digitalWrite(greenPin, LOW);
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
