/*
 * ThumbStick_LCD
 * ThumbStick example using LCD
 */
 
 
#include "LiquidCrystal.h"

LiquidCrystal lcd(8, 7, 3, 4, 5, 6);
int spin = 2;
int sel_last_debounce = 0;
int sel_last_state = LOW;
const int sel_debounce_delay = 40;

void setup() {
  lcd.begin(16,2);
  
  pinMode(spin, INPUT);
  digitalWrite(spin, HIGH);
}

void loop() {
  if ( (millis() % 1000) == 0 ) {
    lcd.clear();
    lcd.home();
    lcd.print("SELECT:");
    lcd.setCursor(0, 1);  
    if ( digitalRead(spin) == HIGH ) { lcd.print("HIGH"); }
    else if (digitalRead(spin) == LOW) { lcd.print("LOW"); }
    else { lcd.print("WTF"); }
  }
}
