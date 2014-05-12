
const int moduleN = 3;
String inputStrings[moduleN] = {"","",""};  // strings to hold incoming data
boolean stringComplete = false;  // whether the string is complete

#define buttonPin 7

void setup()
{
  // start serial port at 9600 bps:
  Serial.begin(9600);
  pinMode(buttonPin, INPUT);
  
  // reserve 200 bytes for each of the inputString:
  for (int i = 0; i < moduleN; i++) {
    inputStrings[i].reserve(200);
  }
}

void loop()
{
  if (digitalRead(buttonPin)) {
    Serial.println("button on");
    parseTest();
  } else {
    //Serial.println("button off");
  }
}


void parseTest(){
  String incoming = "179\n0\n179\n\t";
  String temp_inputString = "";
  int counter = 0;
  
  for (int i = 0; i < 11; i++) {
    char inChar = incoming[i];
    //if  (inChar != '\n' && inChar != '\t'){
      temp_inputString += inChar;
    //}
    
    if (inChar == '\n') {
      inputStrings[counter] = temp_inputString; //put it into array
      temp_inputString = ""; //initialize it
      counter++;
    }
    if (inChar == '\t') {
      stringComplete = true;
    }
  }
  
  if (stringComplete) {
    Serial.print("String:  ");
    Serial.print(inputStrings[0] + " ");
    Serial.print(inputStrings[1] + " ");    
    Serial.println(inputStrings[2]);
    Serial.print("Integer:  ");
    Serial.println(inputStrings[0].toInt());
    Serial.println(inputStrings[1].toInt());    
    Serial.println(inputStrings[2].toInt());
    /*
    String var0 = inputStrings[0];
    String var1 = inputStrings[1];
    String var2 = inputStrings[2];
    int int_var0 = var0.toInt();
    int int_var1 = var1.toInt();
    int int_var2 = var2.toInt();
    Serial.println(int_var0);
    Serial.println(int_var1);
    Serial.println(int_var2);
    */
  }
}
