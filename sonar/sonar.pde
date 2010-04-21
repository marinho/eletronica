int pinIn = 3;
int pinOut = 5;

void setup() {
//  pinMode(pinIn, INPUT);
  pinMode(pinOut, OUTPUT);
  digitalWrite(pinOut, HIGH);

  Serial.begin(9600); 
}

void loop() {
  delay(250);
  Serial.println(172.1 * analogRead(pinIn));
}

