//-----------------------------------------------------------------------------------
// setting
//=============================================================
////////////////////// include libraries //////////////////////
//=============================================================
#include <SoftwareSerial.h>
SoftwareSerial mySerial(10, 11); // RX, TX


//=============================================================
////////////////////// global constants //////////////////////
//=============================================================
#define polyN 6
#define a_pin 7
#define b_pin 8


//=============================================================
////////////////// properties of this module //////////////////
//=============================================================
int myID = 1;
String ourConfiguration[10];




//-----------------------------------------------------------------------------------
// setup and main loop
//=============================================================
/////////////////////////// setup() ///////////////////////////
//=============================================================
void setup() {
  //Serial port for laptop
  Serial.begin(9600);
  while (!Serial) {
    //wait for serial port to connect. Needed for Leonardo only
  }
  Serial.println("Serial Port is open");

  //Serial ports for other modules
  mySerial.begin(9600);



  //for the case of communication without using Software Serial
  //pinMode(a_pin, INPUT);
  //pinMode(b_pin, OUTPUT);
}


//=============================================================
/////////////////////////// loop() ////////////////////////////
//=============================================================
void loop() {

  //receive data from neighbors
  //String receivedData = receiveDataFromNeighbors();
  receiveDataFromNeighbors();

  //update my data table
  //updateMyDataTable(receivedData);

  //transmit data to neighbors
  transmitDataToNeighbors();

  //delay(1000);

}



//-----------------------------------------------------------------------------------
// main three functions
//=============================================================
///////////////// receiveDataFromNeighbors() //////////////////
//=============================================================
//String receiveDataFromNeighbors() {
void receiveDataFromNeighbors() {
  //read data through Software Serial
  
  String receivedData = "";

  if (!mySerial.available()){
    Serial.println("not available");
  }

  while (mySerial.available() > 0) {
    char incomingByte = mySerial.read();
    receivedData += incomingByte;
    Serial.println(incomingByte);
  }

 

  //char receivedData = mySerial.read();

  Serial.println(receivedData);
  Serial.println("------------");

  //return receivedData;


  //read data without using Software Serial
  //int a_id = digitalRead(a_pin);
  //Serial.println( digitalRead(a_pin) );
}


//=============================================================
///////////////////// updateMyDataTable() /////////////////////
//=============================================================
void updateMyDataTable(String _receivedData) {
  //store the received data into my data table
  ourConfiguration[0] = _receivedData;
  if (Serial.available() > 0) {
    Serial.println(ourConfiguration[0]);
  }
}


//=============================================================
////////////////// transmitDataToNeighbors() //////////////////
//=============================================================
void transmitDataToNeighbors() {
  if (mySerial.available() > 0) {
    mySerial.write("abcd");
  }


  //send data without using Software Serial
  //digitalWrite(b_pin, HIGH);
}




//-----------------------------------------------------------------------------------
// helper functions that are called from the main three functions above
/*
//=============================================================
////////////////// format() //////////////////
//=============================================================
String format() {
  String tmp_myNeighbors = "";
  tmp_myNeighbors += "id";
  tmp_myNeighbors += myID;
  tmp_myNeighbors += ',';

  char letter = 'a';
  for (int i = 0; i < polyN; i++) {
    tmp_myNeighbors += letter;
    tmp_myNeighbors += a_id;
    tmp_myNeighbors += ',';
    letter += 1;
  }
  tmp_myNeighbors += "age0";
}
*/
