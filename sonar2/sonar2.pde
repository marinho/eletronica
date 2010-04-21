/* Ultrasound Sensor
 *------------------
 *
 * Reads values (00014-01199) from an ultrasound sensor (3m sensor)
 * and writes the values to the serialport.
 *
 * http://www.xlab.se | http://www.0j0.org
 * copyleft 2005 Mackie for XLAB | DojoDave for DojoCorp
 *
 */

int ultraSoundSignal = 5; // Ultrasound signal pin
int val = 0;
float ultrasoundValue = 0;
int timecount = 0; // Echo counter
int ledPin = 13; // LED connected to digital pin 13

void setup() {
  Serial.begin(9600);                  // Sets the baud rate to 9600
  pinMode(ledPin, OUTPUT);            // Sets the digital pin as output
}

void loop() {
 timecount = 0;
 val = 0;
 pinMode(ultraSoundSignal, OUTPUT); // Switch signalpin to output

/* Send low-high-low pulse to activate the trigger pulse of the sensor
 * -------------------------------------------------------------------
 */

digitalWrite(ultraSoundSignal, LOW); // Send low pulse
delayMicroseconds(2); // Wait for 2 microseconds
digitalWrite(ultraSoundSignal, HIGH); // Send high pulse
delayMicroseconds(5); // Wait for 5 microseconds
digitalWrite(ultraSoundSignal, LOW); // Holdoff

/* Listening for echo pulse
 * -------------------------------------------------------------------
 */

pinMode(3, INPUT); // Switch signalpin to input
val = digitalRead(3); // Append signal value to val
while(val == LOW) { // Loop until pin reads a high value
  val = digitalRead(3);
}

while(val == HIGH) { // Loop until pin reads a high value
  val = digitalRead(3);
  timecount = timecount +1;            // Count echo pulse time
}

/* Writing out values to the serial port
 * -------------------------------------------------------------------
 */

ultrasoundValue = timecount; // Append echo pulse time to ultrasoundValue

Serial.println(ultrasoundValue / 1000.0);

/* Lite up LED if any value is passed by the echo pulse
 * -------------------------------------------------------------------
 */

if(timecount > 0){
  digitalWrite(ledPin, HIGH);
}

/* Delay of program
 * -------------------------------------------------------------------
 */

delay(100);
} 
