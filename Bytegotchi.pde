import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
int ledPin = 13; // Set the pin to digital I/O 13
boolean[] buttons = new boolean[4];
float xPos = 300;
float yPos = 300;
PImage cutie;
PImage bluemage;
PImage redknight;
PImage greenbard;
int state = 0;
int chosenCharacter = 0;
// Bytegotchi :D

void setup()
{
  bluemage = loadImage("graphics/bluemage/bluemage.png");
  redknight = loadImage("graphics/redknight/redknight.png");
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

    redknight.resize(200, 275);
    image(redknight, 205, yPos);
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
    //character moving
    background(100);
    cutie.resize(90, 100);
    image(cutie, xPos, yPos);
    
    //bars on the top
    //red bar, fight
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(5);
    rect(120, 460, 250, 100);
    textSize(40);
    fill(255,0,0);
    text("Fight", 190, 530); 
    
    //green bar, feed
    fill(255);
    stroke(100, 255, 120);
    strokeWeight(5);
    rect(400, 460, 250, 100);
    textSize(40);
    fill(100, 255, 120);
    text("Feed", 480, 530);
    
    //blue bar, wash
    fill(255);
    stroke(0, 150, 255);
    strokeWeight(5);
    rect(680, 460, 250, 100);
    textSize(40);
    fill(0, 150, 255);
    text("Wash", 750, 530);  
    break;
  }
}

void serialEvent(Serial myPort) {
  if (myPort.available() > 0) { 

    val = myPort.readStringUntil('\n');
  }

  if (val != null) {

    String[] data = split(val, ' ');

    if (data.length == 6) {
      xPos += -(int(data[1]) - 511)/50; //changes x position of character
      //println(xPos);
      //println(yPos);
      buttons[0] = int(data[2]) == 1; //joystick button
      buttons[1] = int(data[3]) == 1; //red
      buttons[2] = int(data[4]) == 1; //green
      buttons[3] = int(data[5].substring(0, 1)) == 1; //blue
    }
    switch(state) {
    case 0:
      //warrior picked
      if (buttons[1]) {
        print("red");
        cutie = redknight;
        state = 1;
        chosenCharacter = 0;
        break;
      }
      //bard picked
      if (buttons[2]) {
        print("green");
        cutie = greenbard;
        state = 1;
        chosenCharacter = 1;
        break;
      }
      //mage picked
      if (buttons[3]) {
        print("blue");
        cutie = bluemage;
        state = 1;
        chosenCharacter = 2;
        break;
      }
    case 1:
      //limits character going out of boundaries
      if (xPos < 0) 
        xPos = 0;

      if (xPos > 1010) 
        xPos = 1010;

      //jump
      if (buttons[0]) {
        yPos -= 25;
        delay(50);
        yPos += 25;
        
      }
        
        //fight stage, goes to stage 2
        if (buttons[1]) {
          print("red");
          //state = 2;
        }
        
        //feeding if green button pressed
        if (buttons[2]) {
          print("green");
          println("entered eating anim!");
  
          switch(chosenCharacter) {
            
            case 0: // knight eating
              println("knight is eating!");
              cutie = loadImage("graphics/redknight/redknight_eat.png");
              delay(500);
              cutie = loadImage("graphics/redknight/redknight.png");
              println("knight is done eating!");
              break;
            case 1: // bard eating
              println("bard is eating!");
              cutie = loadImage("graphics/greenbard/greenbard_eat.png");
              delay(500);
              cutie = loadImage("graphics/greenbard/greenbard.png");
              println("bard is done eating!");
              break;
            case 2: // mage eating
              println("mage is eating!");
              cutie = loadImage("graphics/bluemage/bluemage_eat.png");
              delay(500);
              cutie = loadImage("graphics/bluemage/bluemage.png");
              println("mage is done eating!");
              break;
            
          }
         
        }
        //washing if blue button pressed
        if (buttons[3]) {
          print("blue");
          println("entered washing anim!");
  
          switch(chosenCharacter) {
            
            case 0: // knight washing
              println("knight is washing!");
              cutie = loadImage("graphics/redknight/redknight_wash.png");
              delay(500);
              cutie = loadImage("graphics/redknight/redknight.png");
              println("knight is done washing!");
              break;
            case 1: // bard eating
              println("bard is washing!");
              cutie = loadImage("graphics/greenbard/greenbard_wash.png");
              delay(500);
              cutie = loadImage("graphics/greenbard/greenbard.png");
              println("bard is done washing!");
              break;
            case 2: // mage eating
              println("mage is washing!");
              cutie = loadImage("graphics/bluemage/bluemage_wash.png");
              delay(500);
              cutie = loadImage("graphics/bluemage/bluemage.png");
              println("mage is done washing!");
              break;
            
          }
         
        
      }
    }
  }
}

//void joystick(Serial myPort) {
//  switch(state){
//   case 1:
//  }

//  }



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


/*
void serialEvent(Serial myPort) {
 val = myPort.readStringUntil('\n');
 
 if(val != null) {
 val = trim(val);
 int[] vals = int(splitTokens(val, ","));
 xPos = vals[0];
 yPos = vals[1];
 } */
