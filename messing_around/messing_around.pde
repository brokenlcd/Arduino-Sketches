int ledPin[5] = { 2, 3, 4, 5, 6 };    // output LEDs
int led = 2, ledState = HIGH;         // current LED
int hpin = 0, ch = 0;                 // joystick horizontal pin and center value
int vpin = 1, cv = 0;            // joystick vertical pin and center value
int center = 10;                      // center value range (i.e. dvert +/- center)
int selPin = 9;                       // joystick 'select' button
int buttonState;
int debounceTime = 0;
const int debounceDelay = 40;

void setup() { 
  Serial.begin(9600);
  for (int i = 0; i < 5; ++i) {
    pinMode(ledPin[i], OUTPUT);
    Serial.print("LED: ");
    Serial.println(i);
    if ( i == led ) { digitalWrite(ledPin[i], HIGH); }
    else { digitalWrite(ledPin[i], LOW); }
  }
}

void loop() { 
  int selState = getSelect();
  int h = getHoriz();
  int v = getVert();
  int delVal = 0;
  
  Serial.println("Joystick State: ");
  Serial.println("---------------");
  Serial.print("Select: ");
  Serial.println(selState);  
 
  if ( h < (cv - center) ) { upLED(); }
  else if ( h > (ch + center) ) { downLED(); }
  
  delVal = (255 - abs(h)) * 2;
  
  if ( getSelect() == true ) { 
    Serial.println("Center button pressed!");
    toggleLED(); 
  }

  delay(delVal);
  
}

void cycleLED() {
  int i = 0;
  delay(500);
  for (i = 0; i < 12; ++i) { 
    upLED(); 
    delay(500);
  }
  for (i = 0; i < 12; ++i) { 
    downLED(); 
    delay(500);
  }
}

void upLED() {
  digitalWrite(ledPin[led], LOW);
  led = (led + 1) % 5;
  digitalWrite(ledPin[led], ledState);
}

void downLED() {
  digitalWrite(ledPin[led], LOW);
  led = led--;
  if ( led == -1 ) { led = 4; }
  digitalWrite(ledPin[led], ledState);
}

int getHoriz() {

  int h = analogRead(hpin);
  h = map(h, 0, 1023, -255, 254);
  
  return h;
}

int getVert() {
  int v = analogRead(vpin);
  v = map(v, 0, 1023, -255, 254);
  
  return v;
}

boolean getSelect() {
  int lastButtonState = digitalRead(selPin);
  delay(10);
  int buttonState = digitalRead(selPin);
  if ( lastButtonState != buttonState ) { return false; }
  if ( buttonState = LOW ) { return true; }
  else { return false; }
}

void toggleLED() {
  if ( ledState == LOW ) { ledState = HIGH; }
  else { ledState = LOW; }
  
  digitalWrite(led, ledState);
}
