int pinA = 2;
int pinB = 3;
int pinC = 4;
int pinD = 5;
int pinE = 6;
int pinF = 7;
int pinG = 8;

void setup() {
  pinMode(pinA, OUTPUT);
  pinMode(pinB, OUTPUT);
  pinMode(pinC, OUTPUT);
  pinMode(pinD, OUTPUT);
  pinMode(pinE, OUTPUT);
  pinMode(pinF, OUTPUT);
  pinMode(pinG, OUTPUT);
  turnOffDisplay();
}

void turnOffDisplay() {
  digitalWrite(pinA, HIGH);
  digitalWrite(pinB, HIGH);
  digitalWrite(pinC, HIGH);
  digitalWrite(pinD, HIGH);
  digitalWrite(pinE, HIGH);
  digitalWrite(pinF, HIGH);
  digitalWrite(pinG, HIGH);
}

void loop() {
  turnOffDisplay();
  show0f();
  delay(1000);
  show1();
  delay(1000);
  show2();
  delay(1000);
  show3();
  delay(1000);
  show4();
  delay(1000);
  show5();
  delay(1000);
  show6();
  delay(1000);
  show7();
  delay(1000);
  show8();
  delay(1000);
  show9();
  delay(1000);
  showA();
  delay(1000);
  showB();
  delay(1000);
  showC();
  delay(1000);
  showD();
  delay(1000);
  showE();
  delay(1000);
  showF();
  delay(1000);
 
}

void show0() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
}

void show1() {
  turnOffDisplay();
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
}

void show2() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinG, LOW);
}

void show3() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinG, LOW);
}

void show4() {
  turnOffDisplay();
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void show5() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void show6() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void show7() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
}

void show8() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void show9() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void showA() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void showB() {
  turnOffDisplay();
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void showC() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
}

void showD() {
  turnOffDisplay();
  digitalWrite(pinB, LOW);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinG, LOW);
}

void showE() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinD, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}

void showF() {
  turnOffDisplay();
  digitalWrite(pinA, LOW);
  digitalWrite(pinE, LOW);
  digitalWrite(pinF, LOW);
  digitalWrite(pinG, LOW);
}
