#include "DS1307.h"
#include "Wire.h"
#include "EEPROM.h"

#define LASTADDR    0x00
#define STARTADDR   0x01
#define DATESIZE    0x06

DS1307 RTC(true, true);
byte bDTC[DATESIZE];
byte address = 0x00;
int i = 0;

void setup() {
  Serial.begin(9600);
  delay(1000);
  Serial.println("hihi");

  for (i; i <= DATESIZE; ++i) { bDTC[i] = 0; }

  Serial.println("storing DTC...");
  address = EEPROM.read(LASTADDR);
  storeTime(address);
  Serial.print("Read address :");
  Serial.println(address, DEC);
  address = EEPROM.read(LASTADDR);
  Serial.print("is address greater than ");
  Serial.println(STARTADDR + DATESIZE - 1, DEC);
  
  if (address < (STARTADDR + DATESIZE)) {
    Serial.println("This is the first time the arduino was booted with this software.");
  }
  
  else {
    address -= (DATESIZE - 1 );
    Serial.println("Last time the arduino was booted was: ");
    readDate(address);
    printDate();  
  }
}

void loop() { 
//  if (millis() % 1000 == 0) { RTC_print_date(); }

}   


void storeTime(byte address) {
  RTC.getTime(&bDTC[0], &bDTC[1], &bDTC[2]);
  RTC.getDate(&bDTC[3], &bDTC[4], &bDTC[5]);
  
  for (i = 0; i <= DATESIZE; ++i) {
    EEPROM.write(address, bDTC[i]);
    address++;
  }
  
 EEPROM.write(LASTADDR, address);
}

void readDate(byte address) {
  for (i = 0; i <= DATESIZE; ++i) {
    bDTC[i] = EEPROM.read(address);
    address++;
  }
}

void printDate() {
  Serial.print(bDTC[2], DEC);
  Serial.print(":");
  Serial.print(bDTC[1], DEC);
  Serial.print(":");
  Serial.println(bDTC[0], DEC);
  Serial.print(bDTC[5], DEC);
  Serial.print("/");
  Serial.print(bDTC[4], DEC);
  Serial.print("/");
  Serial.println(bDTC[3], DEC);
}

void RTC_print_date() {
  RTC.getTime(&bDTC[0], &bDTC[1], &bDTC[2]);
  RTC.getDate(&bDTC[3], &bDTC[4], &bDTC[5]);
  printDate();
}
