/**
 * I2CScanner.pde -- I2C bus scanner for Arduino
 *
 * 2009, Tod E. Kurt, http://todbot.com/blog/
 *
 * Modified 2010 by Kyle Isom <isomk@kyleisom.net>
 *
 */


#include "Wire.h"
extern "C" { 
  #include "utility/twi.h" // from Wire library, so we can do bus scanning
}


// Scan the I2C bus between addresses from_addr and to_addr.
// On each address, call the callback function with the address and result.
// If result==0, address was found, otherwise, address wasn't found
// (can use result to potentially get other status on the I2C bus, see twi.c)
// Assumes Wire.begin() has already been called
void scanI2CBus(byte from_addr, byte to_addr, 
                void(*callback)(byte address, byte result) ) {
  byte rc;
  byte data = 0; // not used, just an address to feed to twi_writeTo()
  for( byte addr = from_addr; addr <= to_addr; addr++ ) {
    rc = twi_writeTo(addr, &data, 0, 1);
    callback( addr, rc );
  }
}

// Called when address is found in scanI2CBus()
// Feel free to change this as needed
// (like adding I2C comm code to figure out what kind of I2C device is there)
void scanFunc( byte addr, byte result ) {
  Serial.print("addr: 0x");
  if (addr < 0x10) { Serial.print("0"); }
  Serial.print(addr,HEX);
  Serial.print( (result==0) ? "+\t":"\t");
  if (addr % 4 == 0) { Serial.println(""); }
  else { Serial.print("\t"); }
//  Serial.print( (addr % 4) ? "\t":"\n");
}


byte start_address = 1;
byte end_address = 128;

// standard Arduino setup()
void setup() {
    Serial.begin(9600);
    delay(5000);
    Wire.begin();

    Serial.println("\nI2CScanner ready!");

    Serial.print("scanning of I2C bus, devices at addresses ");
    Serial.print(start_address, HEX);
    Serial.print(" to ");
    Serial.print(end_address, HEX);
    Serial.println("...");

    // start the scan, will call "scanFunc()" on result from each address
    scanI2CBus( start_address, end_address, scanFunc );
    
    Serial.println("");
    Serial.println("done. Hit reset to scan again.");
}

// standard Arduino loop()
void loop() { }


