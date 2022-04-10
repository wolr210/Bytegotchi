#define joyX A0
#define joyY A1
#define joystick_switch 2
#define red_button 4
#define green_button 7
#define blue_button 8

int buttonPins[] = {2,4,7,8};
int buttonReadings[] = {0,0,0,0};
int buttonStates[] = {0,0,0,0};
int lastButtonStates[] = {0,0,0,0};

unsigned long lastDebounceTime = 0;
unsigned long debounceDelay = 50;

// we got the buttons to work

// nuts
// fells fuzzy balls
void setup() {
  Serial.begin(9600);
  pinMode(joystick_switch, INPUT_PULLUP);
  pinMode(red_button, INPUT);
  pinMode(green_button, INPUT);
  pinMode(blue_button, INPUT);
}

void loop() {
  float xValue = analogRead(joyX);
  float yValue = analogRead(joyY);

  Serial.print(xValue);
  Serial.print(" ");
  Serial.print(yValue);
  Serial.print(" ");
  Serial.print(!digitalRead(joystick_switch));
  Serial.print(" ");
  Serial.print(digitalRead(red_button));
  Serial.print(" ");
  Serial.print(digitalRead(green_button));
  Serial.print(" ");
  Serial.println(digitalRead(blue_button));

  delay(150);
  
}
