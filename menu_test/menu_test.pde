#include <LiquidCrystal.h>
#include <ThumbStick.h>


ThumbStick joystick;
LiquidCrystal lcd(8, 7, 3, 4, 5, 6);

int superPin = 11;      // supervisor pin

int menu_place = 0;
int menu_items = 4;
char *menu[4];

void setup() {
  pinMode(superPin, OUTPUT);
  digitalWrite(superPin, HIGH);
  lcd.begin(16, 2);
  delay(200);
  lcd.clear();
  lcd.print("calibrating");
  lcd.setCursor(0,1);
  lcd.print("joystick... ");
  joystick.calibrate();
  lcd.print("done!");
  menu_init();
  lcd.print("Booting...");  
  delay(500);
  display_menu();
  Serial.begin(9600);
}

void loop() {
  if ( (millis() % 400) == 0 ) { wdt_strobe(); }
  if ( joystick.isUp() ) { menu_scroll_up(); }
  if ( joystick.isDown() ) { menu_scroll_down(); }
  if ( joystick.isPressed() ) { menu_process(); } 
}

void menu_init() {
  menu[0] = (char *) malloc(sizeof(char) * 15);
  menu[1] = (char *) malloc(sizeof(char) * 15);
  menu[2] = (char *) malloc(sizeof(char) * 15);
  menu[3] = (char *) malloc(sizeof(char) * 15);  
  
  menu[0] = "BUTTON TEST";
  menu[1] = "RUN TIME";
  menu[2] = "CAL JOYSTICK";
  menu[3] = "SUPERVISOR TEST";
}

void display_menu() {
  lcd.clear();
  lcd.print("MENU:");
  lcd.setCursor(0,1);
  lcd.print(menu[menu_place]);
  delay(200);
}

void menu_scroll_down() {
  menu_place = ++menu_place % menu_items;
  display_menu();
}

void menu_scroll_up() {
  --menu_place;
  if (menu_place < 0) { menu_place = menu_items - 1; }
  display_menu();
}

void menu_process() {
  lcd.clear();

  switch (menu_place) {
    case 0:
      lcd.print("    BUTTON");
      lcd.setCursor(0, 1);
      lcd.print("  PRESSED");
      delay(1000);
      break;
    case 1:
      show_runtime();
      break;
    case 2:
      lcd.print("Center Joystick");
      delay(1000);
      lcd.clear();
      lcd.print("calibrating...");
      delay(200);
      joystick.calibrate();
      delay(200);
      lcd.setCursor(0, 1);
      lcd.print("done!");
      delay(500);
      break;
     case 3:
     lcd.print("WDT TEST");
     delay(500);
     while (!(joystick.isPressed())) { delay(250); }
    default:
      break;
  }
  
  display_menu();
}

void show_runtime() {
  int seconds;
  int minutes;
  delay(300);
  while (!(joystick.isPressed())) {
      if ((millis() % 1000) == 0) {
        Serial.println(millis());
        seconds = millis() / 1000;
        minutes = seconds / 60;
        seconds %= 60;
        lcd.clear();
        lcd.print(minutes);
        lcd.print(" minutes");
        lcd.setCursor(0,1);
        lcd.print(seconds);
        lcd.print(" seconds");
        wdt_strobe();
      }
  }
  
  return;
}

void wdt_strobe(void) {
  digitalWrite(superPin, HIGH);
  delay(2);
  digitalWrite(superPin, LOW);
  delay(2);
  digitalWrite(superPin, HIGH);
  return;
}
