#include <Wire.h>

byte test;

void setup() {
  Serial.begin(9600);
  delay(1000);
  Serial.println("Checking RTC");
  Wire.begin();
  Wire.beginTransmission(104);
  Wire.send(0);
  Wire.endTransmission();
  
  Wire.requestFrom(104, 1);
  test = Wire.receive();
  if ( test & (1 << 0x07) ) { Serial.println("RTC enabled"); }
  else { Serial.println("RTC disabled"); }
  Serial.println("Done.");
}

void loop() {
}


