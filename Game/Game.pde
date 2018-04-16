
//INSTRUCTIONS: WSAD - move
// SPACEBAR or SHIFT - dodge
// Left Click - slash
// Right Click - shoot
import java.awt.geom.*;
import java.awt.*;

// declare player health
playerHealth pH; 

// declare game state variables
int mainM = 0;
int controlM = 1;
int runGame = 2;
int gameO = 3;

// current game state
int gameState = mainM;

// declare obj variables for menus
mainMenu mM;
buttonPlay bP;
controlMenu cM;
gameOver gO;

Area playerHbox;

ArrayList<hitboxSlash> HboxSlashes = new ArrayList<hitboxSlash>();

Player p1;
enemy e1;

ArrayList<fadePlayer> streak = new ArrayList<fadePlayer>();
ArrayList<projectile> bullets = new ArrayList <projectile>();
ArrayList<slashBox> slashes = new ArrayList<slashBox>();


float mAngle;

boolean time;
int timer, dTimer, cdCombo, comboCounter;
int  cdSlash1, cdSlash2, cdSlash3, lag1, lag2, lag3;
int cdSlash1e = 300;
int cdSlash2e = 350;
int cdSlash3e = 450;
int lag1e = 50;
int lag2e = 100;
int lag3e = 100;

int TIME;

boolean canSlash = true;
boolean cantMove;
boolean combo1, combo2, combo3, isSlashing, click1, click2, click3;

int dLength = 120;
int dDist = 10;

int debug;

boolean dUp, dDown, dLeft, dRight, dIag;
boolean isDashing;

int dVert, dHoriz;


int slashNum;

color cd = color(255, 0, 0);

void setup() {
  size(900, 900);
  noStroke();
  rectMode(CENTER);

  // for player health
  pH = new playerHealth(1000);

  // add menus
  mM = new mainMenu();
  bP = new buttonPlay();
  cM = new controlMenu();
  gO = new gameOver();

  // add the player
  p1 = new Player(40, 1, 1, 3);
  e1 = new enemy(50, width/2, height/2, 3);
}

void draw() {
  // for changing game states
  if (gameState == mainM) {
    mM.display(); // display main menu
    bP.display(); // display play button
    reset(); // reset the game
  } else if (gameState == runGame) { 
    runGame(); // run the game
    pH.display(); // display health bar image
  } else if (gameState == controlM) { 
    cM.display(); // display controls menu
  } else if (gameState == gameO) {
    gO.display(); // display game over screen
  }
}

// runs the game
void runGame () {

  background(135);
  // println(canSlash, millis(), cdSlash1, isSlashing);

  // add hitboxes for player and mouse
  Area mouse = new Area(new Rectangle(mouseX - 25/2, mouseY -25/2, 25, 25));
  playerHbox = new Area(new Rectangle2D.Float(p1.xpos - 40/2, p1.ypos - 40/2, 40, 40));

  //temp mouse display hitbox
  pushMatrix(); 
  translate(mouseX, mouseY);
  fill(cd);
  rect(0, 0, 25, 25); 
  popMatrix();

  //mouse.intersect(player);

  //if (mouse.isEmpty() == false) {
  //  cd = color(255, 0, 0);
  //  println("player hit");
  //}
  //else {
  //  cd = color(255);  
  //}





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
      HboxSlashes.clear();
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
    cantMove = false;
  }

  if (cdSlash1 + 100 < millis() && cdSlash2 + 100 < millis() && cdSlash3 < millis()) {
    combo1 = false; 
    combo2 = false; 
    combo3 = false;
    click1 = false;
    click2 = false;
    click3 = false;
    isSlashing = false;
  }


  if (cdSlash1 > millis() && isDashing == false && combo1 == false && combo2 == false && combo3 == false && lag1 <= millis()) {
    //while (lag1 > millis()) {}
    lag1 = 0;

    slash(color(255, 0, 0));
    HboxSlashes.add(new hitboxSlash(50, 100));

    isSlashing = true;
    combo1 = true;
    cantMove = true;
  }
  if (cdSlash2 > millis() && isSlashing == true && combo1 == true && combo2 == false && combo3 == false && cdSlash1 <= millis() && lag2 <= millis()) {
    // while (cdSlash1 > millis()) {}
    // while (lag2 > millis()){}
    lag2 = 0;

    slash(color(0, 255, 0));
    HboxSlashes.add(new hitboxSlash(50, 100));

    combo2 = true;
    cantMove = true;
  }
  if (cdSlash3 > millis() && isSlashing == true && combo1 == true && combo2 == true && combo3 == false && cdSlash2 <= millis() && lag3 <= millis()) {
    //  while (cdSlash2 > millis()) {}
    //sd while(lag3 > millis()){}
    lag3 = 0;

    slash(color(0, 0, 255));
    HboxSlashes.add(new hitboxSlash(50, 100));

    combo3 = true;
    cantMove = true;
  }

  if (HboxSlashes.size() >= 1) {
    hitboxSlash theSlash = HboxSlashes.get(0);
    theSlash.a1.intersect(mouse);


    if (theSlash.a1.isEmpty() == false) {
      cd = color(0, 0, 255);
      //println("slash hit" + millis() + "   " +HboxSlashes.size()+"    " + slashNum);
    } else {
      cd = color(255);
    }
  }

  // let players & enemies display & collide only if player health > 0
  //if (pH.hp > 0) {
  if (gameState == runGame && pH.hp > 0) {
    p1.move();
    p1.display();
    e1.display();
    e1.collide();
  }
}

// reset the game if player dies
void reset() {
  pH.hp = 1000; // reset player HP to full health
  pH.resetFrame(); // reset health bar image to full health

  p1.xpos = 0; // reset player x-position
  p1.ypos = 0; // reset player y-position
}

// checks to see if keys are pressed
void keyPressed() {
  p1.keysCheckP();
  if (key == ' '||keyCode == SHIFT) {
    if (isDashing == false) {
      p1.dash();
      isDashing = true;
    }
  }
}

// checks to see if keys have been released
void keyReleased() {
  p1.keysCheckR();
}

// checks to see if mouse has been pressed
void mousePressed() {

  // To switch game states on main menu screen
  if (gameState == mainM) {
    // To switch game state from main menu to run game
    if ((mouseX >= 400 && mouseX <= 510) && (mouseY >= 450 && mouseY <= 510)) {
      gameState = runGame;
      bP.display();
      //tint(0, 153, 204, 126);
    }
    //To switch game state from main menu to controls menu
    if ((mouseX >= 320 && mouseX <= 580) && (mouseY >= 565 && mouseY <= 610)) {
      gameState = controlM;
    }
  }

  // To switch game state on controls screen
  if (gameState == controlM) {
    // To switch game state from controls menu to run game
    if ((mouseX >= 400 && mouseX <= 510) && (mouseY >= 750 && mouseY <= 810)) {
      gameState = runGame;
    }
  }

  // To switch game state on game over screen
  if (gameState == gameO) {
    // To switch game state from game over to main menu
    if ((mouseX >= 380 && mouseX <= 520) && (mouseY >= 450 && mouseY <= 520)) {
      gameState = mainM;
    }
  }

  if (mouseButton == LEFT) {
    int tempT = millis();

    if (isDashing == false && click1 == false && click2 == false && click3 == false) {
      lag1 = tempT + lag1e;
      cdSlash1 = tempT + lag1e + cdSlash1e;
      click1 = true;
    } else if (isDashing == false && click1 == true && click2 == false && click3 == false) {
      cdSlash1 -= 100;

      lag2 = tempT + lag2e + (cdSlash1 - tempT);      
      cdSlash2 = tempT + cdSlash2e + (lag2-tempT);
      click2 = true;
    } else if (isDashing == false && click1 == true && click2 == true && click3 == false) {
      cdSlash2 -=100;

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

// melee attack for player
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


  PVector mouseVec = new PVector(p1.xpos - mouseX, p1.ypos - mouseY);
  mouseVec.normalize();
  mouseVec.mult(10);
  p1.xpos -= mouseVec.x;
  p1.ypos -= mouseVec.y;

  slashes.add(new slashBox(color(c)));
  //popMatrix();
}