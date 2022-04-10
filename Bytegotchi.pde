import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
int ledPin = 13; // Set the pin to digital I/O 13
boolean[] buttons = new boolean[4];
float xPos = 300;
float yPos = 300;
PImage cutie;
PImage meanie;
PImage bluemage;
PImage redknight;
PImage greenbard;
int state = 0;
int chosenCharacter = 0;
float hWidth = 350;
float fWidth = 350;
float attackWidth = 350;
float yourWidth = 350;
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
  case 0: // choosing character, state = 0
    background(60);
    stroke(255);
    strokeWeight(10);
    fill(60);
    rect(0, 0, width, height);
    noStroke();
    fill(101, 12, 103);
    ellipse(width/2, height/2, 550, 550);
    fill(63, 8, 64);
    ellipse(width/2, height/2, 500, 500);
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
    break;

  case 1: // main tomogachi screen, state = 1
    //character moving
    //background
    background(191, 255, 253);
    fill(98, 87, 76);
    triangle(200, 400, 500, 20, 800, 400);
    fill(108, 94, 80);
    triangle(-10, 500, 200, 40, 300, 500);
    fill(165, 146, 127);
    triangle(-50, 400, 79, 100, 150, 400);
    fill(118,101,85);
    triangle(600,400,750,50,1000,500);
    fill(152,137,123);
    triangle(800,400,900,100,1200,500);
    fill(131, 206, 102);
    rect(0, 400, width, 200);
    
    
    cutie.resize(150, 180);
    image(cutie, xPos, yPos - 75);

    //bars on the top
    //red bar, fight
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(5);
    rect(120, 460, 250, 100);
    textSize(40);
    fill(255, 0, 0);
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

    //hunger bar
    noStroke();
    fill(0);
    rect(45, 25, 350, 30);
    fill(0, 255, 0); 
    rect(50, 30, fWidth-100, 20);
    fill(0);
    textSize(20);
    text("Hunger bar: ", 50, 20);
    if (frameCount>0) {
      fWidth-=0.1;//0.1
      if (fWidth > 350) {
        fWidth = 350;
      }
    }

    //hygiene bar
    noStroke();
    fill(0);
    rect(725, 25, 350, 30);
    fill(0, 255, 0); 
    rect(730, 30, hWidth-100, 20);
    fill(0);
    textSize(20);
    text("Hygiene bar: ", 730, 20);
    if (frameCount>0) {
      hWidth-=0.1;//0.1
      if (hWidth > 1000) {
        hWidth = 1000;
      }
    }
    break;

  case 2: //fight sequences
  //background
    background(191, 255, 253);
    fill(98, 87, 76);
    triangle(200, 400, 500, 20, 800, 400);
    fill(108, 94, 80);
    triangle(-10, 500, 200, 40, 300, 500);
    fill(121, 106, 92);
    triangle(-50, 400, 79, 100, 150, 400);
    fill(77,85,98);
    triangle(300,400,150,50,600,500);
    fill(77,85,98);
    triangle(800,400,900,50,1150,500);
    fill(119,131,149);
    rect(0, 400, width, 200);
    
    //GUI buttons for attacking, healing, fleeing
    fill(255, 0, 0);
    strokeWeight(4);
    stroke(255);
    circle(1000, 150, 130);
    fill(100, 255, 120);
    circle(1000, 300, 130);
    fill(0, 150, 255);
    circle(1000, 450, 130);
    fill(255);
    textSize(30);
    text("Attack",955, 155);
    text("Heal",970, 305);
    text("Flee",970, 455);
    
    //Make player
    cutie.resize(150, 180);
    image(cutie, xPos, yPos);

    //Make enemy
    meanie = loadImage("graphics/enemy/enemy.png");
    meanie.resize(150, 180);
    image(meanie, xPos + 300, yPos);

    //fighting health bars
    noStroke();
    fill(0);
    rect(45, 25, 350, 30);
    fill(0, 255, 0); 
    rect(50, 30, yourWidth-10, 20);
    fill(0);
    textSize(20);
    text("Your health bar: ", 50, 20);

    noStroke();
    fill(0);
    rect(725, 25, 350, 30);
    fill(0, 255, 0); 
    rect(730, 30, attackWidth-10, 20);
    fill(0);
    textSize(20);
    text("Enemy's health bar: ", 730, 20);
    break;
  case 4:
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textSize(100);
    text("GAME OVER", 250, 350);
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
      buttons[0] = int(data[2]) == 1; //joystick button
      buttons[1] = int(data[3]) == 1; //red
      buttons[2] = int(data[4]) == 1; //green
      buttons[3] = int(data[5].substring(0, 1)) == 1; //blue
    }
    switch(state) {
    case 0: // choosing character
      //warrior picked
      if (buttons[1]) {
        cutie = redknight;
        state = 1;
        chosenCharacter = 0;
        break;
      }
      //bard picked
      if (buttons[2]) {
        cutie = greenbard;
        state = 1;
        chosenCharacter = 1;
        break;
      }
      //mage picked
      if (buttons[3]) {
        cutie = bluemage;
        state = 1;
        chosenCharacter = 2;
        break;
      }
      break;
    case 1: // main tomogachi string
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
      
      //Sends to gameover state if hunger/hygene meter deplete
      if (hWidth < 89.487045 || fWidth < 89.487045) {
        state = 4;
        break;
      }

      //fight stage, goes to stage 2
      if (buttons[1]) {
        state = 2;
      }

      //feeding if green button pressed
      if (buttons[2]) {

        switch(chosenCharacter) {

        case 0: // knight eating
          cutie = loadImage("graphics/redknight/redknight_eat.png");
          delay(500);
          cutie = loadImage("graphics/redknight/redknight.png");
          fWidth += 10;
          break;
        case 1: // bard eating
          cutie = loadImage("graphics/greenbard/greenbard_eat.png");
          delay(500);
          cutie = loadImage("graphics/greenbard/greenbard.png");
          fWidth += 10;

          break;
        case 2: // mage eating
          cutie = loadImage("graphics/bluemage/bluemage_eat.png");
          delay(500);
          cutie = loadImage("graphics/bluemage/bluemage.png");
          fWidth += 10;
          break;
        }
      }

      //washing if blue button pressed
      if (buttons[3]) {

        switch(chosenCharacter) {

        case 0: // knight washing
          cutie = loadImage("graphics/redknight/redknight_wash.png");
          delay(500);
          cutie = loadImage("graphics/redknight/redknight.png");
          hWidth += 10;
          break;
        case 1: // bard eating
          cutie = loadImage("graphics/greenbard/greenbard_wash.png");
          delay(500);
          cutie = loadImage("graphics/greenbard/greenbard.png");
          hWidth += 10;
          break;
        case 2: // mage eating
          cutie = loadImage("graphics/bluemage/bluemage_wash.png");
          delay(500);
          cutie = loadImage("graphics/bluemage/bluemage.png");
          hWidth += 10;
          break;
        }
      }
      break;
    case 2: // battle, player turn
      if (buttons[1]) { // red - attack

        // attack
        attackWidth -= 50;
        if (attackWidth < 150) {
          textSize(40);
          text("You won!!!", width/2 - 90, height/2);
          attackWidth = 350;
          yourWidth = 350;
          state = 1;
          break;
        } else {
          state = 3;
          break;
        }
      }

      if (buttons[2]) { // green - heal

        // heal
        yourWidth += 80;
        state = 3;
        break;
      }

      if (buttons[3]) { // blue - flee
        state = 1;
        attackWidth = 350;
        yourWidth = 350;
        break;
      }

      break;
    case 3: // battle, enemy turn
      yourWidth -= random(40, 120);
      if(yourWidth < 50) {
        yourWidth = 350;
        attackWidth = 350;
        state = 4;
        break;
      }
      else
        state = 2;

      break;
      case 4:
      if(buttons[0] || buttons[1] || buttons[2] || buttons[3]){
        state = 0;
        break;
      }
    }
  }
}
