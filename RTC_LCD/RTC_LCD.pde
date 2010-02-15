#include <DS1307.h>
#include <Wire.h>
#include <LiquidCrystal.h>
#include <ThumbStick.h>

#define  LCD_COLS      16
#define  LCD_ROWS       2
#define  MENU_ITEMS    13
#define  LCD_BLANK16    "                "

DS1307 RTC(true, true);
LiquidCrystal lcd(8, 7, 3, 4, 5, 6);
ThumbStick joystick(0, 1, 2);

byte sec, mins, hrs, dow, day, month, year;
char menu[MENU_ITEMS][16] = { "Show Time", "Show Date", "Show DOW", "Show DTC", "Set Time", "Set Date", "Set DTC", "Set DOW", "Disable RTC", "Enable RTC", 
                              "RTC Status", "->24 hour", "->12 hour" };
char DOW[7][10] = { "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY" };
int menu_place;

void setup() {
  lcd.begin(LCD_COLS, LCD_ROWS);
  delay(200);
  RTC.setup();
  lcd.clear();
  lcd.print(" Center");
  lcd.setCursor(0, 1);
  lcd.print("Thumbstick");
  delay(500);
  lcd.clear();
  lcd.print("Calibrating");
  lcd.setCursor(0, 1);
  lcd.print("Thumbstick");
  delay(500);
  joystick.calibrate();
  lcd.clear();
  lcd.print("finished!");
  delay(200);
  display_menu();
}

void loop() {
  if (joystick.isUp()) { menu_scroll_up(); }
  else if (joystick.isDown()) { menu_scroll_down(); }
  else if (joystick.isRight()) { process_main_input(); }
}
  
void LCD_show_DTC() {
    lcd.clear();
    LCD_show_date();
    lcd.setCursor(0, 1);
    LCD_show_time();

}  

void LCD_show_time() {
    RTC.getTime(&sec, &mins, &hrs);
    if (hrs < 10) { lcd.print(0, DEC); }
    lcd.print(hrs, DEC);
    lcd.print(":");
    if (mins < 10) { lcd.print(0, DEC); }
    lcd.print(mins, DEC);
    lcd.print(":");
    if (sec < 10) { lcd.print(0, DEC); }
    lcd.print(sec, DEC);
    lcd.print("  (");
    if (RTC.check24Hour()) { lcd.print("24"); }
    else { lcd.print("12"); }
    lcd.print("H)");
}

void LCD_show_date() {
    RTC.getDate(&day, &month, &year);
    RTC.dayOfWeek(&dow);
    char dowTemp[3];
    for (int i = 0; i < 3; ++i) { dowTemp[i] = DOW[dow - 1][i]; }
    lcd.print(year + DS1307_EPOCH, DEC);
    lcd.print("/");
    if (month < 10) { lcd.print(0, DEC); }
    lcd.print(month, DEC);
    lcd.print("/");
    if (day < 10) { lcd.print(0, DEC); }
    lcd.print(day, DEC);
    lcd.print(" / ");
    lcd.print(dowTemp);
        
}

void LCD_show_DOW() {
  RTC.dayOfWeek(&dow);
  lcd.print(DOW[dow - 1]);
}

void display_menu() {
  lcd.clear();
  lcd.print("MENU:");
  lcd.setCursor(0,1);
  lcd.print(menu[menu_place]);
  delay(200);
}

void menu_scroll_down() {
  menu_place = ++menu_place % MENU_ITEMS;
  display_menu();
}

void menu_scroll_up() {
  --menu_place;
  if (menu_place < 0) { menu_place = MENU_ITEMS - 1; }
  display_menu();
}

void process_main_input() {
  switch (menu_place) {
    case 0:
      menu_show_time();
      break;
     case 1:
       menu_show_date();
       break;
     case 2:
       menu_show_DOW();
       break;
     case 3:
       menu_show_DTC();
       break;
     case 4:
       menu_set_time();
       break;
     case 5:
       menu_set_date();
       break;
     case 6:
       menu_set_DTC();
       break;
     case 7:
       menu_set_DOW();
       break;
     case 8:
       RTC.disableClock();
       lcd.clear();
       lcd.print("RTC disabled!");
       delay(1000);
       break;
     case 9:
       RTC.enableClock();
       lcd.clear();
       lcd.print("RTC enabled!");
       delay(1000);
       break;
     case 10:
       lcd.clear();
       lcd.print("RTC: ");
       if (RTC.isEnabled()) { lcd.print("enabled!"); }
       else { lcd.print("disabled!"); }
       delay(1500);
       break;
     case 11:
       lcd.clear();
       RTC.set24();
       delay(30);
       if (RTC.check24Hour() == true) { lcd.print("24H mode en"); }
       else { lcd.print("failure!"); }
       delay(1000);
       break;
     case 12:
       lcd.clear();
       while (RTC.check24Hour() == true) { RTC.set12(); }
       lcd.print("12H mode en");
       delay(1000);
       break;
     default:
       break;
  }
  
  display_menu();
}

void menu_show_time() {
  lcd.clear();
  delay(250);
  while (!joystick.isLeft()) {
    if ((millis() % 500) == 0) { 
      lcd.clear();
      LCD_show_time(); 
    }
  }
  
  display_menu();
}

void menu_show_date() {
  lcd.clear();
  delay(250);
  while (!joystick.isLeft()) {
    if ((millis() % 500) == 0) { 
      lcd.clear();
      LCD_show_date(); 
    }
  }
  
  display_menu();
}

void menu_show_DTC() {
  delay(250);
  while (!joystick.isLeft()) {
    if ((millis() % 500) == 0) { LCD_show_DTC(); }
  }
  
  display_menu();
}

void menu_show_DOW() {
  while (!joystick.isLeft()) {
    if ((millis() % 500) == 0) { 
      lcd.clear(); 
      LCD_show_DOW();
    }
  }
}

void menu_set_time() {
  boolean flag;
  lcd.clear();
  LCD_show_time();
  lcd.setCursor(0, 1);
  while (flag == false) {
    flag = LCD_mod_hours();
    lcd.setCursor(0,1);
    lcd.print(LCD_BLANK16);
    lcd.setCursor(0, 1);
    flag = LCD_mod_minutes();
    lcd.setCursor(0,1);
    lcd.print(LCD_BLANK16);
    lcd.setCursor(0, 1);

  }
  
  sec = 0;
  
  RTC.setTime(&sec, &mins, &hrs);
  
}

void menu_set_date() {
  boolean flag = false;
  byte place = 0;
  lcd.clear();
  LCD_show_date();
  lcd.setCursor(0, 1);
  while (flag == false) {
    lcd.setCursor(0,1);
    lcd.print(LCD_BLANK16);
    lcd.setCursor(0, 1);
    switch (place) {
      case 0:
        flag = LCD_mod_year();
        break;
      case 1:
        flag = LCD_mod_month();
        break;
      case 2:
        flag = LCD_mod_day();
        break;
      default:
        break;    
    }
    
    if (joystick.isLeft()) { place = (--place > 3) ? 2 : place ; }
    if (joystick.isRight()) { ++place %= 3; }

    lcd.setCursor(0, 1);
    lcd.print(LCD_BLANK16);
    lcd.setCursor(0, 1);

  }
  
  RTC.setDate(&day, &month, &year);
  
}

void menu_set_DOW() {
  boolean flag = false;
  byte place = 0;
  lcd.clear();
  LCD_show_DOW();
  lcd.setCursor(0, 1);
  while (flag == false) {
    flag = LCD_mod_dow();
  }
  
  RTC.setDayOfWeek(&dow);
  
}


void menu_set_DTC() {
  boolean flag = false;
  byte place = 0;
  lcd.clear();
  LCD_show_date();
  lcd.print(" | ");
  lcd.print(place, DEC);
  lcd.setCursor(0, 1);
  while (flag == false) {
    lcd.setCursor(0, 1);
    lcd.print(LCD_BLANK16);
    lcd.setCursor(0, 1);
    switch (place) {
      case 0:
        flag = LCD_mod_year();
        break;
      case 1:
        flag = LCD_mod_month();
        break;
      case 2:
        flag = LCD_mod_day();
        break;
      case 3:
        flag = LCD_mod_hours();
        break;
      case 4:
        flag = LCD_mod_minutes();
        break;
      case 5:
        flag = LCD_mod_dow();
        break;
      default:
        break;    
    }
    
    if (joystick.isLeft()) { place = (--place > 5) ? 5 : place ; }
    if (joystick.isRight()) { ++place %= 6; }

    lcd.setCursor(0,1);
    lcd.print(LCD_BLANK16);
    lcd.setCursor(0, 1);

  }
  
  sec = 0;
  
  RTC.setTime(&sec, &mins, &hrs);
  RTC.setDate(&day, &month, &year);
  
  
}


boolean LCD_mod_hours() {
  boolean flag;
  delay(200);
  lcd.setCursor(0, 1);
  lcd.print(LCD_BLANK16);
  lcd.print("HOUR: ");
  if (hrs < 10) { lcd.print(0, DEC); }
  lcd.print(hrs, DEC);
  
  while (!joystick.isPressed() && ( !joystick.isRight() && !joystick.isLeft())) {
    delay(150);
    if (joystick.isUp()) { (++hrs) %= 24;  }
    
    if (joystick.isDown()) { --hrs = hrs > 23 ? 23 : hrs; flag = true; }

    if (flag) {
      lcd.setCursor(0, 1);
      lcd.print(LCD_BLANK16);
      lcd.setCursor(0, 1);
      lcd.print("HOUR: ");
      if (hrs < 10) { lcd.print(0, DEC); }
      lcd.print(hrs, DEC);
    }
  }
  
  return joystick.isPressed() ? true : false;
}  

boolean LCD_mod_minutes() {
  boolean flag;
  delay(200);
  lcd.setCursor(0, 1);
  lcd.print(LCD_BLANK16);
  lcd.print("MINUTES: ");
  if (mins < 10) { lcd.print(0, DEC); }
  lcd.print(mins, DEC);
  
  while (!joystick.isPressed() && ( !joystick.isRight() && !joystick.isLeft())) {
    delay(150);
    if (joystick.isUp()) { (++mins) %= 60; flag = true; }
    
    if (joystick.isDown()) { --mins = mins > 59 ? 59 : mins; flag = true; }

    if (flag) {
      lcd.setCursor(0, 1);
      lcd.print(LCD_BLANK16);
      lcd.setCursor(0, 1);
      lcd.print("MINUTES: ");
      if (mins < 10) { lcd.print(0, DEC); }
      lcd.print(mins, DEC);
    }
  }
  
  return joystick.isPressed() ? true : false;
}  

boolean LCD_mod_year() {
  boolean flag;
  delay(200);
  lcd.setCursor(0, 1);
  lcd.print(LCD_BLANK16);
  lcd.print("YEAR: ");
  if (year < 10) { lcd.print(0, DEC); }
  lcd.print(year, DEC);
  
  while (!joystick.isPressed() && ( !joystick.isRight() && !joystick.isLeft())) {
    delay(150);
    if (joystick.isUp()) { (++year) %= 100; flag = true; }
    
    if (joystick.isDown()) { --year = year > 99 ? 99 : year; flag = true; }

    if (flag) {
      lcd.setCursor(0, 1);
      lcd.print(LCD_BLANK16);
      lcd.setCursor(0, 1);
      lcd.print("YEAR: ");
      if (year < 10) { lcd.print(0, DEC); }
      lcd.print(year, DEC);
    }
  }
  
  return joystick.isPressed() ? true : false;
}  

boolean LCD_mod_month() {
  boolean flag;
  delay(200);
  lcd.setCursor(0, 1);
  lcd.print(LCD_BLANK16);
  lcd.print("MONTH: ");
  if (month < 10) { lcd.print(0, DEC); }
  lcd.print(month, DEC);
  
  while (!joystick.isPressed() && ( !joystick.isRight() && !joystick.isLeft())) {
    delay(150);
    if (joystick.isUp()) { (++month) = (month % 12) + 1; flag = true; }
    
    if (joystick.isDown()) { --month = (month > 12) || (month < 1)  ? 12 : month; flag = true; }

    if (flag) {
      lcd.setCursor(0, 1);
      lcd.print(LCD_BLANK16);
      lcd.setCursor(0, 1);
      lcd.print("MONTH: ");
      if (year < 10) { lcd.print(0, DEC); }
      lcd.print(month, DEC);
    }
  }
  
  return joystick.isPressed() ? true : false;
}  

boolean LCD_mod_day() {
  boolean flag;
  delay(200);
  lcd.setCursor(0, 1);
  lcd.print(LCD_BLANK16);
  lcd.print("DAY: ");
  if (day < 10) { lcd.print(0, DEC); }
  lcd.print(day, DEC);
  
  while (!joystick.isPressed() && ( !joystick.isRight() && !joystick.isLeft())) {
    delay(150);
    if (joystick.isUp()) { (++day) = (day % 31) + 1; flag = true; }
    
    if (joystick.isDown()) { --day = (day > 31) || (day < 1) ? 31 : day; flag = true; }

    if (flag) {
      lcd.setCursor(0, 1);
      lcd.print(LCD_BLANK16);
      lcd.setCursor(0, 1);
      lcd.print("DAY: ");
      if (year < 10) { lcd.print(0, DEC); }
      lcd.print(day, DEC);
    }
  }
  
  return joystick.isPressed() ? true : false;
}  

boolean LCD_mod_dow() {
  boolean flag;
  delay(200);
  RTC.dayOfWeek(&dow);
  lcd.setCursor(0, 1);
  lcd.print(LCD_BLANK16);
  lcd.print("DOW: ");
  lcd.print(dow, DEC);
  lcd.print(" - ");
  lcd.print(DOW[dow - 1]);
  
  while (!joystick.isPressed() && ( !joystick.isRight() && !joystick.isLeft())) {
    delay(150);
    if (joystick.isUp()) { (++dow) = (dow % 7) + 1; flag = true; }
    
    if (joystick.isDown()) { --dow = (dow > 7) || (dow < 1) ? 7 : dow; flag = true; }

    if (flag) {
      lcd.setCursor(0, 1);
      lcd.print(LCD_BLANK16);
      lcd.setCursor(0, 1);
      lcd.print("DOW: ");
      lcd.print(DOW[dow - 1]);
    }
  }
  
  return joystick.isPressed() ? true : false;
}  


