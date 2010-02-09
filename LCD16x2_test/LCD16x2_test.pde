#include <LiquidCrystal.h>
#define  MENU_ITEMS        3
#define  LCD_COL          16
#define  LCD_ROW           2


LiquidCrystal lcd(8, 7, 3, 4, 5, 6);
int pbPin = 2;
boolean pbState = true;
char menu[2][16] = { "time", "owner" };

void setup() {
  lcdsetup();

  delay(2000);
  pinMode(pbPin, INPUT);
}

void lcdboot() {
  lcd.begin(LCD_COL, LCD_ROW);
  lcd.home();
  lcd.clear();
  lcd.print("Arduino Handheld");
  lcd.setCursor(0,1);
  lcd.print("technomage labs");
  delay(1500);
  lcd.home();
  lcd.clear();
  lcd.print("in conjunction");
  lcd.setCursor(6,1);
  lcd.print("with");
  delay(1000);
  lcd.home();
  lcd.clear();
  lcd.print("brokenLCD labs");
  delay(1500);
  lcd.clear();
  lcd.home();
  lcd.print("MENU:");
  lcd.setCursor(0,1);
}

void loop() { 
  
}


