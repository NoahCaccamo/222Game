//INSTRUCTIONS: WSAD - move
// SPACEBAR or SHIFT - dodge
// Left Click - slash
// Right Click - shoot

import ptmx.*;
import processing.sound.*;

SoundFile introMusic;
SoundFile playMusic;
Player p1;
Enemy e1;
dragonWing d1;
ogreStomp o1;
enemyBigger eb1;
Ptmx map;


int x= 0, y = 0;

boolean isPlaying;

//PImage cobblestoneBackground;
PGraphics wall;
PImage[] enemyFrames = new PImage [5];
PImage [] enemyLarge = new PImage [5];
PImage[] playerFrames = new PImage [9];
PImage[] playerFramesUp = new PImage [9];
PImage[] playerFramesRight = new PImage [9];
PImage[] playerFramesLeft = new PImage [9];
PImage[] magicFrames = new PImage [9];
PImage[] meleeFrames = new PImage [9];
PImage[] backgroundFrames = new PImage [3];
PImage [] dragon = new PImage [4];
PImage [] ogre = new PImage [8];
PImage b0, b1, b2;

boolean lastR, lastL, lastU, lastD;
boolean p1Animate = true;

ArrayList<fadePlayer> streak = new ArrayList<fadePlayer>();
ArrayList<projectile> bullets = new ArrayList <projectile>();
ArrayList<slashBox> slashes = new ArrayList<slashBox>();


float mAngle;

boolean time;
int timer, dTimer, cdCombo, comboCounter;
int  cdSlash1, cdSlash2, cdSlash3, lag1, lag2, lag3;
int cdSlash1e = 400;
int cdSlash2e = 400;
int cdSlash3e = 600;
int lag1e = 200;
int lag2e = 150;
int lag3e = 100;

int TIME;

boolean canSlash = true;
boolean combo1, combo2, combo3, isSlashing, click1, click2, click3;

int dLength = 120;
int dDist = 10;

int debug;

boolean dUp, dDown, dLeft, dRight, dIag;
boolean isDashing;

int dVert, dHoriz;

int INTRO = 0;  
int RUN_GAME = 1;
int gameState = INTRO;
int score = 0;

void setup() {
  
  map = new Ptmx(this, "brick.tmx");
  wall = createGraphics(32, 32);
  size(900, 900);
  noStroke();
  imageMode(CENTER);
  rectMode(CENTER);
  //cobblestoneBackground = loadImage("brick.png");

  p1 = new Player(40, 1, 1, 3);
  e1 = new Enemy();
  d1 = new dragonWing();
  o1 = new ogreStomp();
  eb1 = new enemyBigger();

  //Loads Enemy
  for (int i=0; i< enemyFrames.length; i++) {
    String filename = "enemy" + i + ".png";
    enemyFrames[i] = loadImage(filename);
  }
  
  //Loads Larger Enemy
  for (int i=0; i< enemyLarge.length; i++) {
    String filename = "enemybigger" + i + ".png";
    enemyLarge[i] = loadImage(filename);
  }
  
  //Loads Ogre
  for (int i=0; i< ogre.length; i++) {
    String filename = "OGRESPRITE_" + i + ".png";
    ogre[i] = loadImage(filename);
  }
  //Loads Dragon
  for (int i=0; i< dragon.length; i++) {
    String filename = "dragonsprite_" + i + ".png";
    dragon[i] = loadImage(filename);
  }
  
  //Loads Player
  for (int i=0; i< playerFrames.length; i++) {
    String filename = "sprite_0" + i + ".png";
    playerFrames[i] = loadImage(filename);
  }


  for (int i=0; i< playerFramesUp.length; i++) {
    String filename = "spriteUp_0" + i + ".png";
    playerFramesUp[i] = loadImage(filename);
  }


  for (int i=0; i< playerFramesRight.length; i++) {
    String filename = "spriteRightLeft_0" + i + ".png";
    playerFramesRight[i] = loadImage(filename);
  }
  
  for (int i=0; i< playerFramesLeft.length; i++) {
    String filename = "spriteLeft_0" + i + ".png";
    playerFramesLeft[i] = loadImage(filename);
  }
  
  //Loads Magic

  for (int i=0; i< magicFrames.length; i++) {
    String filename = "fireball_0" + i + ".png";
    magicFrames[i] = loadImage(filename);
  }

  //Loads Melee
  for (int i=0; i< meleeFrames.length; i++) {
    String filename = "melee_0" + i + ".png";
    meleeFrames[i] = loadImage(filename);
  }

  //Loads Music
  introMusic = new SoundFile(this, "Intro_Music.mp3");
  playMusic = new SoundFile(this, "Game_Music.mp3");
    if (gameState == INTRO) {
    introMusic.loop();
    
  }
  
  if (gameState == RUN_GAME) {
    introMusic.stop(); 
  }
}

void draw () {
  //map drawing
  background(map.getBackgroundColor());
  map.draw(x, y);
  PVector p1Map = map.canvasToMap(p1.xpos, p1.ypos);
  map.draw(wall, 1, p1Map.x, p1Map.y);
  
 //background(cobblestoneBackground);
 if (gameState == RUN_GAME && isPlaying == false) {
    introMusic.stop();
    playMusic.loop();
  }
  
if (gameState == RUN_GAME && isPlaying == false) {
    introMusic.stop();
    playMusic.loop();
    isPlaying = true;
}
  
  println(canSlash, millis(), cdSlash1, isSlashing);


  for (int i=0; i<bullets.size(); i++) {
    projectile getBullets = bullets.get(i);

    getBullets.display();
    getBullets.update();
  }

  for (int i=0; i<slashes.size(); i++) {
    slashBox getSlashes = slashes.get(i);

    getSlashes.display();
    if (millis()>getSlashes.life) {
      slashes.remove(i);
    }
  }



  if (dTimer < millis()) {
    isDashing = false;
  }

  if (timer > millis()) {
    streak.add(new fadePlayer(40, p1.xpos, p1.ypos, 1000));
    if (dUp == true||dDown == true) {
      p1.ypos += dDist*dVert;
    } 
    if (dLeft == true|| dRight == true) {
      p1.xpos += dDist*dHoriz;
    }
  } else {
    dUp = false;
    dDown = false;
    dLeft = false;
    dRight = false;
  }


  for (int i=0; i<streak.size(); i++) {
    fadePlayer gotFade = streak.get(i);
    gotFade.fade();
    gotFade.display();
    if (gotFade.trans <= 0) {
      streak.remove(i);
    }
  }


  if (cdSlash1 < millis() && cdSlash2 < millis() && cdSlash3 < millis()) {
    isSlashing = false; 
    combo1 = false; 
    combo2 = false; 
    combo3 = false;
    click1 = false;
    click2 = false;
    click3 = false;
  }


  if (cdSlash1 > millis() && isDashing == false && combo1 == false && combo2 == false && combo3 == false && lag1 <= millis()) {
    //while (lag1 > millis()) {}
    lag1 = 0;

    slash(color(255, 0, 0));
    isSlashing = true;
    combo1 = true;
  }
  if (cdSlash2 > millis() && isSlashing == true && combo1 == true && combo2 == false && combo3 == false && cdSlash1 <= millis() && lag2 <= millis()) {
    // while (cdSlash1 > millis()) {}
    // while (lag2 > millis()){}
    lag2 = 0;

    slash(color(0, 255, 0));
    combo2 = true;
  }
  if (cdSlash3 > millis() && isSlashing == true && combo1 == true && combo2 == true && combo3 == false && cdSlash2 <= millis() && lag3 <= millis()) {
    //  while (cdSlash2 > millis()) {}
    //sd while(lag3 > millis()){}
    lag3 = 0;

    slash(color(0, 0, 255));
    combo3 = true;
  }
  
  //////////////
  //GAMESTATE
   if (gameState == INTRO) intro();
  if (gameState == RUN_GAME) runGame();

}

void keyPressed() {
  
 // if(keyCode == LEFT) x-=map.getTileSize().x;
  //if(keyCode == RIGHT) x+=map.getTileSize().x;
  //if(keyCode == UP) y-=map.getTileSize().y;
  //if(keyCode == DOWN) y+=map.getTileSize().y;
  p1.keysCheckP();
  if (key == ' '||keyCode == SHIFT) {
    if (isDashing == false) {
      p1.dash();
      isDashing = true;
    }
  }
}

void keyReleased() {
  p1.keysCheckR();
}

void mousePressed() {
  
  if (gameState == INTRO) { 
    gameState = RUN_GAME;
  }

  if (mouseButton == LEFT) {
    int tempT = millis();

    if (isDashing == false && click1 == false && click2 == false && click3 == false) {
      lag1 = tempT + lag1e;
      cdSlash1 = tempT + lag1e + cdSlash1e;
      click1 = true;
    } else if (isDashing == false && click1 == true && click2 == false && click3 == false) {
      lag2 = tempT + lag2e + (cdSlash1 - tempT);      
      cdSlash2 = tempT + cdSlash2e + (lag2-tempT);
      click2 = true;
    } else if (isDashing == false && click1 == true && click2 == true && click3 == false) {
      lag3 = tempT + lag3e + (cdSlash2-tempT);
      cdSlash3 = tempT + cdSlash3e + (lag3-tempT);
      click3 = true;
    }

    //add command to array
    //new comType(1) add this to array list



    //  if (canSlash == true && comboCounter == 0) {


    //isSlashing = true;
    //canSlash = false;
    //cdSlash = millis() + 1000;


    //}
    //if (isSlashing = true) {

    //}
  }
  ////////////
  if (mouseButton == RIGHT) {
    bullets.add (new projectile());
    for (int i=0; i<bullets.size(); i++) {
      projectile getBullets = bullets.get(i);

      getBullets.update();
    }
  }
}

void slash(color c) {
  /*mAngle = atan2(mouseY-p1.ypos, mouseX - p1.xpos);
   
   if (mAngle < 0) {
   mAngle += TWO_PI;
   }
   
   pushMatrix();
   translate(p1.xpos, p1.ypos);
   
   rotate(mAngle);
   translate(50, 0);
   fill(c);
   */
  slashes.add(new slashBox(color(c)));
  //popMatrix();
}

int intTimer(int timerLength) {
  int remainingTime = timerLength-millis();

  if (remainingTime%1000>0) {
    int actualTime = (remainingTime/1000);
    return actualTime;
  } else {
    time = false;
    return 0;
  }
}