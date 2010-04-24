// Variaveis de controle do sonar
int pinSonarIn = 12;
int pinSonarOut = 11;
int timer = 0;
int val = 0;
float dist = 0;
int ativa_serial = 0;

// Variaveis de controle dos servos
#define servo1control OCR1A
#define servo2control OCR1B
#define servonull 3050
int pinServo1 = 10;
int pinServo2 = 9;
int ativa_servos = 1;

void setup() {
  // Abre porta serial
  if (ativa_serial) {
    Serial.begin(9600);
  }
  
  // Modos dos pinos dos servos
  pinMode(pinServo1, OUTPUT);
  pinMode(pinServo2, OUTPUT);
  TCCR1A = 0b10100010;
  TCCR1B = 0b00011010;
  ICR1 = 39999;
  servo1control = servonull;
  servo2control = servonull;
}

void loop() {
  // Prepara contador de tempo
  timer = 0;
  val = 0;
  
  // Define porta 12 como saida (input do sonar)
  pinMode(pinSonarOut, OUTPUT);
  
  // Envia sinal
  digitalWrite(pinSonarOut, LOW);
  delayMicroseconds(2);
  digitalWrite(pinSonarOut, HIGH);
  delayMicroseconds(5);
  digitalWrite(pinSonarOut, LOW);
  
  // Espera pelo sinal de retorno
  pinMode(pinSonarIn, INPUT);
  while (digitalRead(pinSonarIn) == LOW) { }
  while (digitalRead(pinSonarIn) == HIGH) { timer++; }

  // Calcula distancia
  dist = float(timer) / 1300.0;
  
  // Escreve distancia na porta serial
  if (ativa_serial) {
    Serial.println(dist);
  }
 
  // Ativa motores
  if (!ativa_servos) {
    servo1control = servonull;
    servo2control = servonull;
  } else if (dist <= 0.5) { // 40 centimetros
    if (random(0,2) == 0) {
      // Volta um pouco antes de mudar de rota
      servo1control = 3150;
      servo2control = 2960;
      delay(400);
      servo1control = 2600; // Avança
      servo2control = 2800; // Retorna
    } else {
      // Volta um pouco antes de mudar de rota
      servo1control = 3150;
      servo2control = 2960;
      delay(400);
      servo1control = 3300; // Retorna
      servo2control = 3500; // Avança
    }
    delay(500);
  } else {
    servo1control = 2990; // Toada normal
    servo2control = 3120;
  }
  
  // Espera tempo entre uma varredura e outra  
  delay(100);
}
