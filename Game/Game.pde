//INSTRUCTIONS: WSAD - move
// SPACEBAR or SHIFT - dodge
// Left Click - slash
// Right Click - shoot

Player p1;

ArrayList<fadePlayer> streak = new ArrayList<fadePlayer>();
ArrayList<projectile> bullets = new ArrayList <projectile>();
ArrayList<slashBox> slashes = new ArrayList<slashBox>();


float mAngle;

boolean time;
int timer, dTimer, cdCombo, comboCounter;
int  cdSlash1, cdSlash2, cdSlash3, lag1, lag2, lag3;
int cdSlash1e = 1000;
int cdSlash2e = 1000;
int cdSlash3e = 1000;
int lag1e = 200;
int lag2e = 150;
int lag3e = 100;

int TIME;

boolean canSlash = true;
boolean combo1, combo2, combo3, isSlashing;

int dLength = 120;
int dDist = 10;

int debug;

boolean dUp, dDown, dLeft, dRight, dIag;
boolean isDashing;

int dVert, dHoriz;

void setup() {
  size(900, 900);
  noStroke();
  rectMode(CENTER);

  p1 = new Player(40, 1, 1, 3);
}

void draw () {

  background(135);
  println(canSlash, millis(), cdSlash1, isSlashing);


  for (int i=0; i<bullets.size(); i++) {
    projectile getBullets = bullets.get(i);

    getBullets.display();
    getBullets.update();
  }
  
  for (int i=0; i<slashes.size(); i++){
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
  }


  if (cdSlash1 > millis() && isDashing == false && combo1 == false && combo2 == false && combo3 == false) {
    while (lag1 > millis()) {}
lag1 = 0;

    slash(color(255, 0, 0));
    isSlashing = true;
    combo1 = true;
   
  }
  if (cdSlash2 > millis() && isSlashing == true && combo1 == true && combo2 == false && combo3 == false) {
    while (cdSlash1 > millis()) {}
    while (lag2 > millis()){}
    lag2 = 0;
    
    slash(color(0, 255, 0));
    combo2 = true;
  }
  if (cdSlash3 > millis() && isSlashing == true && combo1 == true && combo2 == true && combo3 == false) {
    while (cdSlash2 > millis()) {}
    while(lag3 > millis()){}
    lag3 = 0;
    
    slash(color(0, 0, 255));
    combo3 = true;
  }


  p1.move();
  p1.display();
}

void keyPressed() {
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

  if (mouseButton == LEFT) {
     int tempT = millis();
     
    if (isDashing == false && combo1 == false && combo2 == false && combo3 == false) {
      lag1 = tempT + lag1e;
      cdSlash1 = tempT + lag1e + cdSlash1e;
    } else if (isDashing == false && combo1 == true && combo2 == false && combo3 == false) {
      lag2 = tempT + lag2e + (cdSlash1 - tempT);
     // if (lag1 > tempT) lag2 += lag1-tempT;
     // if (cdSlash1 > tempT) lag2 += cdSlash1-tempT;
      
      cdSlash2 = tempT + cdSlash2e + (lag2-tempT);
      
    } else if (isDashing == false && combo1 == true && combo2 == true && combo3 == false) {
      lag3 = tempT + lag3e + (cdSlash2-tempT);
      
      cdSlash3 = tempT + cdSlash3e + (lag3-tempT);
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