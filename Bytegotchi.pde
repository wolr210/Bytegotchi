import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
int ledPin = 13; // Set the pin to digital I/O 13
boolean[] buttons = new boolean[4];
float xPos = 300;
float yPos = 300;
PImage cutie;
PImage bluemage;
PImage redwarrior;
PImage greenbard;
int state = 0;
// Bytegotchi :D

void setup()
{
  bluemage = loadImage("graphics/bluemage/bluemage.png");
  redwarrior = loadImage("graphics/redwarrior/redwarrior.png");
  greenbard = loadImage("graphics/greenbard/greenbard.png");

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  size(1100, 600);
  noStroke();
}


void draw() {
  switch(state) {
  case 0:
    background(100);
    textSize(100);
    fill(255);
    text("Pick a character", 170, 120); 

    redwarrior.resize(200, 275);
    image(redwarrior, 205, yPos);
    fill(255, 0, 0);
    circle(300, 200, 100);

    greenbard.resize(150, 230);
    image(greenbard, 480, yPos + 40);
    fill(100, 255, 120);
    circle(550, 200, 100);

    bluemage.resize(190, 260);
    image(bluemage, 755, yPos);
    fill(0, 150, 255);
    circle(830, 200, 100);

    println();
    break;

  case 1:
    background(100);
    cutie.resize(90, 100);
    image(cutie, xPos, yPos);
    println();
    break;
  }
  /*
  background(255);
   bluemage.resize(90, 100);
   image(bluemage, xPos, yPos);
   
   redwarrior.resize(90, 100);
   image(redwarrior, xPos, yPos);
   
   greenbard.resize(90, 100);
   image(greenbard, xPos, yPos);
   
   println();
   */
}

void serialEvent(Serial myPort) {
  if (myPort.available() > 0) { 
   
   val = myPort.readStringUntil('\n');
   }
   
   if (val != null) {
   
   String[] data = split(val, ' ');
   
   if (data.length == 6) {
     buttons[1] = int(data[3]) == 1;
     buttons[2] = int(data[4]) == 1;
     buttons[3] = int(data[5].substring(0, 1)) == 1;
   }
  switch(state) {
  case 0:
    if (buttons[1]) {
      print("red");
      cutie = redwarrior;
      state = 1;
      break;
    }

    if (buttons[2]) {
      print("green");
      cutie = greenbard;
      state = 1;
      break;
    }

    if (buttons[3]) {
      print("blue");
      cutie = bluemage;
      state = 1;
      break;
    }
  }

  /*
  if (myPort.available() > 0) { 
   
   val = myPort.readStringUntil('\n');
   }
   
   if (val != null) {
   
   String[] data = split(val, ' ');
   
   if (data.length == 6) {
   
   xPos += -(int(data[1]) - 511)/50;
   println(xPos);
   println(yPos);
   
   
   buttons[0] = int(data[2]) == 1;
   buttons[1] = int(data[3]) == 1;
   buttons[2] = int(data[4]) == 1;
   buttons[3] = int(data[5].substring(0, 1)) == 1;
   
   
   if (xPos < 0) {
   xPos = 0;
   }
   if (xPos > 1010) {
   xPos = 1010;
   }
   
   if (buttons[0]) {
   
   yPos -= 25;
   delay(50);
   yPos += 25;
   }
   
   if (buttons[1]) {
   
   print("RED");
   }
   
   if (buttons[2]) {
   
   print("GREEN ");
   }
   
   if (buttons[3]) {
   
   print("BLUE ");
   }
   }
   }*/
}

/*
void serialEvent(Serial myPort) {
 val = myPort.readStringUntil('\n');
 
 if(val != null) {
 val = trim(val);
 int[] vals = int(splitTokens(val, ","));
 xPos = vals[0];
 yPos = vals[1];
 } */
 } 
