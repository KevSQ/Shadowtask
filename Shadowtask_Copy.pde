/* Imports */
import processing.sound.*;
//PImage photo;
PImage shadowOne;
PImage shadowTwo;
PImage mainOne;
PImage mainTwo;
PImage streetOne;
PImage streetTwo;
PImage trashCan;
PImage triangle;
PImage mainBack;
PImage shadowTask;


/* Variables */
int objectAmount = 185;
int counter = 0;
float runY = 400;
int jumpVel = 0;
float gravity = 1;
int offset;
int groundLevel = 400;
int runX = 100;
int godMode;
//Arrays
Obstacle [] obstacles = new Obstacle [objectAmount];
int [] objectSelector = new int [objectAmount];
int count = 0;
int second;
int timeReset;
int jumpCount;
float speed = 3;
//Rain
int offsetRain = 15;
Rain [] rain = new Rain [350];
int Y1 = 0;
int X1 = 70;
//Time
int startMillis;
int currentMillis;
float time;
int difference;
int sg;
//Sound
SoundFile caine;
//Background
Background b1;
//Tint
//Tint t1;


/* 
 Note: Complete.
 IDEA: To stop something more than double jump, track amount of jumps,
 put it in an if statement and make it so that any other amount of jump
 after 2 (aka double jump) instantly makes jumpVel = 0; When it lands, reset jumpcount.
 Note: Complete.
 */

//---//
void setup() {
  startMillis = millis();
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER);
  //Construction
  caine = new SoundFile(this, "CaineEdit.mp3");
  b1 = new Background(0, 1180, 1);
  //t1 = new Tint(2);
  shadowOne = loadImage("blackback1.png");
  shadowTwo = loadImage("blackback2.png");
  mainOne = loadImage("thingd.png");
  mainTwo = loadImage("thingg.png");
  streetOne = loadImage("street.png");
  streetTwo = loadImage("street1.png");
  trashCan = loadImage("trashCan.png");
  triangle = loadImage("tri.png");
  mainBack = loadImage("back.png");
  shadowTask = loadImage("shadowtask.jpg");
  //photo = loadImage("thingd.png");
  //Obstacle
  for (int i = 0; i < objectSelector.length; i++) {
    objectSelector[i] = int(random(1, 3));
    ////println(objectSelector[i]);
  }
  for (int i = 0; i < obstacles.length; i++) {
    if (objectSelector[i] == 1) {
      offset = offset + int(random(300, 620));
      obstacles[i] = new Obstacle(600 + offset, groundLevel, 50, 50);
    } else if (objectSelector[i] == 2) {
      offset = offset + int(random(300, 620));
      obstacles[i] = new Obstacle(600 + offset, groundLevel - 25, 100, 50);
    }
  }
  //Rain
  for (int i = 0; i < rain.length; i++) {
    rain[i] = new Rain(X1, Y1, X1 - 10, Y1 + 20, 4);
    rain[i].randomizeAndSet();
    Y1 += offsetRain;
  }
  size(1200, 600);
}

void reset() {
  speed = 3;
  noTint();
  godMode = 0;
  runY = 300;
  jumpVel = 0;
  gravity = 1;
  groundLevel = 400;
  runX = 100;
  offset = 0;
  count = 0;
  second = 0;
  for (int i = 0; i < objectSelector.length; i++) {
    objectSelector[i] = int(random(1, 3));
    //println(objectSelector[i]);
  }
  for (int i = 0; i < obstacles.length; i++) {
    if (objectSelector[i] == 1) {
      offset = offset + int(random(300, 620));
      obstacles[i] = new Obstacle(600 + offset, groundLevel, 50, 50);
    } else if (objectSelector[i] == 2) {
      offset = offset + int(random(300, 620));
      obstacles[i] = new Obstacle(600 + offset, groundLevel - 25, 100, 50);
      //println(groundLevel);
    }
  }
  caine.stop();
}



void draw() {
  currentMillis = millis();
  difference = currentMillis - startMillis;
  time = (difference) / 1000;
  println("Second: " + time, "Counter: " + counter, "Speed: " + speed);
  if (counter == 0) {
    menu();
  } else if (counter == 1) {
    mGame();
    runner();
    musicSequence();
    if (runY <= 0) {
      runY = 1;
    }
    //count++;
    //ob1.Display();
  } else if (counter == 2) {
    gameOver();
  } else {
    text("404 Not Found", 0, 0);
  }
  //tint(0, 153, 204, 255);
}
//---

/* Definitions */

void menu() {
  image(shadowTask, 0, -300);
  textSize(32);
  fill(255, 0, 0);
  text("Press Space to begin!", 600, 500);
}


void mGame() {
  image(mainBack, 0, 0);
  b1.display();
  
  
  //Rain
  for (int i = 0; i < rain.length; i++) {
    strokeWeight(1);
    rain[i].display();
    rain[i].shift();
  }
  strokeWeight(0);
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i].display();
    boolean collision = didCollisionOccur(obstacles[i]);
    if (collision == true) {
      counter = 2;
      sg = millis();
      return;
    }
  }
  strokeWeight(1);
}


void gameOver() {
  speed = 0;
  fill(255, 0, 0);
  text("R.I.P", 600, 300);
  text("You reached: " + (sg - startMillis) / 1000 + " Seconds", 600, 500);
  caine.stop();
}


void runner() {
  stroke(0, 0, 0);
  fill(255, 255, 255);
  rect(runX, runY, 50, 50);

  if (jumpVel > 0) {
    jumpVel -= gravity;
    runY -= jumpVel;
  } else if (runY < 400) {
    jumpVel -= gravity;
    runY -= jumpVel;
    runY = min(runY, 400);
  } else if (runY == 400) {
    jumpCount = 0;
  }
}


/* Events */

// Key Events //

void keyPressed() {
  if (key == ' ') {
    if (counter == 0) {
      startMillis = currentMillis;
      counter = 1;
      caine.stop();
      reset();
      caine.play();
    } else if (counter == 1 && jumpCount < 2) {
      jumpVel = 20;
      jumpCount++;
    } else if (jumpCount > 2) {
      jumpVel = 0;
    } else if (counter == 2) {
      counter = 0;
    }
  }
  if (key == 'g') {
    print("God Mode Activated");
    godMode = 1;
  }
  if (key == 'h') {
    print("God Mode Off");
    godMode = 0;
  }
}


boolean didCollisionOccur(Obstacle obstacle) {
  float runnerBottom = runY + 25;
  float runnerLeft = runX - 25;
  float runnerRight = runX + 25;

  float obstacleTop = obstacle.getObstacleTop();
  float obstacleLeft = obstacle.getObstacleLeft();
  float obstacleRight = obstacle.getObstacleRight();
  if (godMode == 1) {
    return false;
  }
  if (speed == 0) {
    return false;
  }
  if (runnerBottom >= obstacleTop) {
    if (runnerRight >= obstacleLeft && runnerRight <= obstacleRight) {
      return true;
    } else if (runnerLeft >= obstacleLeft && runnerLeft <= obstacleRight) {
      return true;
    }
  }
  return false;
}


/* WARNING: BELOW IS ONLY MUSIC SEQUENCE */
/* WARNING: BELOW IS ONLY MUSIC SEQUENCE */
/* WARNING: BELOW IS ONLY MUSIC SEQUENCE */
/* WARNING: BELOW IS ONLY MUSIC SEQUENCE */
/* WARNING: BELOW IS ONLY MUSIC SEQUENCE */
/* WARNING: BELOW IS ONLY MUSIC SEQUENCE */



void musicSequence() {
  if (time == 12) {
    tint(0, 0, 255);
    speed = 8;
  }

  //if (time == 23) {
  //  speed = 9;
  //}

  if (time == 24) {
    tint(128, 255);
    speed = 9;
  } else if (time == 25) {
    tint(64, 255);
    speed = 3;
  } else if (time == 26) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 27) {
    tint(128, 255);
    speed = 9;
  } else if (time == 28) {
    tint(64, 255);
    speed = 3;
  } else if (time == 29) {
    tint(32, 255);
    speed = 1;
  }
  if (time == 31) {
    tint(128, 255);
    speed = 9;
  } else if (time == 32) {
    tint(64, 255);
    speed = 3;
  } else if (time == 33) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 34) {
    tint(128, 255);
    speed = 9;
  } else if (time == 35) {
    tint(64, 255);
    speed = 3;
  } else if (time == 36) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 37) {
    tint(255, 0, 0, 255);
    speed = 12;
  }

  if (time == 49) {
    tint(100, 0, 0, 255);
    speed = 15;
  }

  if (time == 62) {
    tint(128, 255);
    speed = 9;
  } else if (time == 69) {
    tint(64, 255);
    speed = 3;
  } else if (time == 70) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 71) {
    tint(128, 255);
    speed = 9;
  } else if (time == 72) {
    tint(64, 255);
    speed = 3;
  } else if (time == 73) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 74) {
    tint(128, 255);
    speed = 9;
  } else if (time == 75) {
    tint(64, 255);
    speed = 3;
  } else if (time == 76) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 77) {
    tint(128, 255);
    speed = 9;
  } else if (time == 78) {
    tint(64, 255);
    speed = 3;
  } else if (time == 79) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 80) {
    tint(128, 255);
    speed = 9;
  } else if (time == 81) {
    tint(64, 255);
    speed = 3;
  } else if (time == 82) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 83) {
    tint(128, 255);
    speed = 9;
  } else if (time == 84) {
    tint(64, 255);
    speed = 3;
  } else if (time == 85) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 86) {
    tint(128, 255);
    speed = 9;
  } else if (time == 87) {
    tint(64, 255);
    speed = 3;
  } else if (time == 88) {
    tint(32, 255);
    speed = 1;
  }

  if (time == 89) {
    tint(128, 255);
    speed = 9;
  } else if (time == 90) {
    tint(64, 255);
    speed = 3;
  } else if (time == 91) {
    tint(32, 255);
    speed= 1;
  }

  if (time == 93) {
    tint(255, 0, 0, 255);
    speed = 13;
  }

  if (time == 117) {
    tint(80, 238, 255, 255);
    speed = 17;
  }

  if (time == 143) {
    noTint();
    speed = 6;
  }

  if (time == 144) {
    speed = 5;
  }

  if (time == 145) {
    speed = 4;
  }

  if (time == 146) {
    speed = 3;
  }

  if (time == 147) {
    speed = 2;
  }

  if (time == 148) {
    speed = 1;
  }
}