int pinLed = 13;
int pinIR = 12;

void setup() {
  pinMode(pinLed, OUTPUT);
  pinMode(pinIR, INPUT);
  
  Serial.begin(9600);
}

void loop() {
  digitalWrite(pinLed, HIGH);
  Serial.println(digitalRead(pinIR));
  delay(1000);
  
  //digitalWrite(pinLed, LOW);
  //Serial.println(digitalRead(pinIR));
  //delay(1000);
}

