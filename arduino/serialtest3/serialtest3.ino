#define redPin 8
#define yellowPin 9
#define greenPin 10

void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
    
  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  
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
      if (v == 179) { 
        digitalWrite(redPin, HIGH);
      } else if (v == 0){
        digitalWrite(redPin, LOW);
      }
      v = 0;
      break;
      
    case 'y':
    if (v == 179) {
      digitalWrite(yellowPin, HIGH);
    } else if (v == 0) {
        digitalWrite(yellowPin, LOW);
    }
      v = 0;
      break;
      
    case 'g':
    if (v == 179) {
      digitalWrite(greenPin, HIGH);
    } else if (v == 0) {
        digitalWrite(greenPin, LOW);
    }
      v = 0;
      break;
    }
  }
}
