//INSTRUCTIONS: WSAD - move
// SPACEBAR or SHIFT - dodge
// Left Click - slash
// Right Click - shoot

Player p1;

ArrayList<fadePlayer> streak = new ArrayList<fadePlayer>();
ArrayList<projectile> bullets = new ArrayList <projectile>();

float mAngle;


int timer, dTimer;
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



for (int i=0; i<bullets.size();i++) {
  projectile getBullets = bullets.get(i);

getBullets.display();
getBullets.update();


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
  mAngle = atan2(mouseY-p1.ypos, mouseX - p1.xpos);

if (mAngle < 0){
 mAngle += TWO_PI; 
}

pushMatrix();
translate(p1.xpos, p1.ypos);

rotate(mAngle);
translate(50, 0);
rect(0,0, 50, 100);
popMatrix();
  }
  
  if (mouseButton == RIGHT) {
  bullets.add (new projectile());
  for (int i=0; i<bullets.size();i++) {
  projectile getBullets = bullets.get(i);

getBullets.update();

  }
}

}