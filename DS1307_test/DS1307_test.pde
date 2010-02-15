#include <DS1307.h>

DS1307 RTC(true, true);
byte seconds, minutes, hours, day, month, year;


void setup() { 
    Serial.begin(9600);
    delay(1000);
    Serial.print("Checking status of DS1307: ");
    
    if ( RTC.isEnabled() ) { 
      Serial.println("enabled"); 
      if (RTC.checkr24Hour()) { Serial.println("24 hour"); }
      else { Serial.println("12 hour"); }
    }
    else { 
      Serial.println("disabled"); 
      
      Serial.print("Attempting to enable RTC: ");
      RTC.enableRTC();
      if ( RTC.isEnabled() ) { Serial.println("enabled"); }
      else { Serial.println("disabled"); }
      
    }

    Serial.println("Running setup():");
    RTC.setup();    
    Serial.println("Time mode: ");
    if (RTC.checkr24Hour()) { Serial.println("24 hour"); }
    else { Serial.println("12 hour"); }
          
    
}

void loop() {
  if ( (RTC.isEnabled()) && ( (millis() % 1000) == 0) ) {
    RTC.getTime(&seconds, &minutes, &hours);
    RTC.getDate(&day, &month, &year);
    Serial.print(year + DS1307_EPOCH, DEC);
    Serial.print(".");
    Serial.print(month, DEC);
    Serial.print(".");
    Serial.print(day, DEC);
    Serial.print("  ");
    Serial.print(hours, DEC);
    Serial.print(":");
    Serial.print(minutes, DEC);
    Serial.print(":");
    Serial.println(seconds, DEC);
  }
}

