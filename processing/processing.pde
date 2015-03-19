import processing.serial.*;

Serial myPort; 

PFont helvetica;

PImage background, car, deer;
static final int WINDOW_WIDTH = 600;
static final int WINDOW_HEIGHT = 560;

int x_1, x_2, x_3;
static final int increment = 70;
static final String forward = "cycle";

int deerHeight = 600;
int deerCounter = 0;
boolean deerKilled = false;

void setup() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  smooth();
  myPort = new Serial(this, "COM7", 9600);
  myPort.bufferUntil('\n');
  background = loadImage("Background.png");
  car = loadImage("car_blue.png");
  deer = loadImage("deer_left.png");
  helvetica = loadFont("HelveticaNeue-36.vlw");
  textFont(helvetica);
}

void draw() {

  // Draw both images, one next to the other
  image(background, -x_1, 0);
  image(background, background.width - x_2, 0);

  if (x_1 >= 2 * background.width - width) {
    x_1 = background.width - width;
    x_3 = -20;
    deerHeight = (random(0,1) < 0.6) ? 430 : 700;
  } else if (x_2 >= 2 * background.width - width) {
    x_2 = background.width - width;
  }
  
  // Draw car
  image(car, width/2 - car.width/2, 430);
  
  //Deer
  image(deer, width - x_3, deerHeight);
  
  if (x_3 == (-20+3*increment) && deerHeight == 430) {
    deerCounter += 1;
    if (deerCounter == 250) {
      deerHeight = 700;
      deerCounter = 0;
      deerKilled = false;
    }
  }
  
  if (deerKilled == true) {
    rectMode(CENTER);
    fill(#D43B26);
    noStroke();
    rect(width/2, 200, 310, 50, 5);
    textAlign(CENTER, CENTER);
    fill(#FFFFFF);
    text("You killed the deer", width/2, 200);
    delay(1500);
    
    restart();
  }
}

void serialEvent (Serial myPort) {
  
   String inString = myPort.readStringUntil('\n');
   inString = trim(inString);
//  println(inString);
   if (inString.equals(forward) == true) {
       if (x_3 == (-20+3*increment) && deerHeight == 430) {
          println("killed the deer!");
          deerKilled = true;
          
        } else {
          x_1 += increment;
          x_2 += increment;
          x_3 += increment;
          deerKilled = false;
        }
   }
  
 }
//
//void keyPressed() {
//  
//  if (x_3 == (-20+3*increment) && deerHeight == 430) {
//    println("killed the deer!");
//    deerKilled = true;
//    
//  } else {
//    x_1 += increment;
//    x_2 += increment;
//    x_3 += increment;
//    deerKilled = false;
//  }
//}

void restart() {
  x_1 = 0;
  x_2 = 0;
  x_3 = -20;
  deerCounter = 0;
  deerKilled = false;
  deerHeight = 700;
}
