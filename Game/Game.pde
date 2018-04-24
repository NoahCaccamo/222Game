import ptmx.*;


//INSTRUCTIONS: WSAD - move
// SPACEBAR or SHIFT - dodge
// Left Click - slash
// Right Click - shoot
import java.awt.geom.*;
import java.awt.*;
import ptmx.*;
import processing.sound.*;

SoundFile introMusic;
SoundFile playMusic;

Ptmx map;

PImage slowFilter;
PGraphics wall;
PImage [] enemyLarge = new PImage [5];
PImage [] enemyLargeflip = new PImage [5];
PImage[] playerFrames = new PImage [9];
PImage[] playerFramesUp = new PImage [9];
PImage[] playerFramesRight = new PImage [9];
PImage[] playerFramesLeft = new PImage [9];
PImage[] magicFrames = new PImage [9];
PImage[] magicFramesv2 = new PImage[9];
PImage[] meleeFrames = new PImage [9];
PImage[] backgroundFrames = new PImage [3];
PImage [] dragon = new PImage [4];
PImage [] dragonflip = new PImage [4];
PImage [] ogre = new PImage [8];
PImage [] ogreflip = new PImage [8];

Area playerHbox;

ArrayList<hitboxSlash> HboxSlashes = new ArrayList<hitboxSlash>();


Player p1;
basicRangedEnemy brec1;
chargerEnemy cec1;
meleeEnemy mec1;


ArrayList<fadePlayer> streak = new ArrayList<fadePlayer>();
ArrayList<projectile> bullets = new ArrayList <projectile>();
ArrayList<enemyProjectile> enemyProjectiles = new ArrayList <enemyProjectile>();
ArrayList<slashBox> slashes = new ArrayList<slashBox>();

ArrayList<meleeEnemy> meleeEnemies = new ArrayList<meleeEnemy>();
ArrayList<chargerEnemy> chargerEnemies = new ArrayList<chargerEnemy>();
ArrayList<basicRangedEnemy> basicRangedEnemies = new ArrayList<basicRangedEnemy>();
ArrayList<tripleRangedEnemy> tripleRangedEnemies = new ArrayList<tripleRangedEnemy>();
ArrayList<turret> turrets = new ArrayList<turret>();

int score;
int ammo;
int ratio = 6;
float ammoParts;
int s;

PVector slashKnockVector;

float mAngle;

boolean time;

int bulletDamage = 3;

int timer, dTimer, sTimer, smTimer, iTimer, timeTimer, cdCombo, comboCounter;
int  cdSlash1, cdSlash2, cdSlash3, lag1, lag2, lag3;
int cdSlash1e = 200;
int cdSlash2e = 250;
int cdSlash3e = 350;
int lag1e = 50;
int lag2e = 100;
int lag3e = 100;

int TIME;

boolean canSlash = true;
boolean cantMove;
boolean combo1, combo2, combo3, isSlashing, click1, click2, click3;
boolean p1Animate = true;
boolean lastR, lastL, lastU, lastD;

int dLength = 120;
int dDist = 10;

int debug;

boolean dUp, dDown, dLeft, dRight, dIag;
boolean isDashing;

int dVert, dHoriz;

int slashPunch;
int slashNum;

float lastForce;
PVector lastSource;

boolean goTime = true;
int slowCounter;

color cd = color(255, 0, 0);


void setup() {
  //fullScreen();
  imageMode(CENTER);
  map = new Ptmx(this, "brick.tmx");
  wall = createGraphics(32, 32);
  size(900, 900);
  noStroke();
  rectMode(CENTER);

  slowFilter = loadImage("purp-FILTER.png");

  //add the player
  p1 = new Player(40, 1, 1, 3);
  brec1 = new basicRangedEnemy();
  meleeEnemies.add( new meleeEnemy(60, width/2, height/2, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2, 0, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2+1, 0, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2+10, 0, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2+15, 0, 3));
  basicRangedEnemies.add( new basicRangedEnemy(125, width/2, height/2, 1));
  //basicRangedEnemies.add( new basicRangedEnemy(50, width/2, 0, 56));

  //tripleRangedEnemies.add( new tripleRangedEnemy(50, 800, 0, 56));
  //turrets.add(new turret(30, width/2, height/2));

  //chargerEnemies.add(new chargerEnemy(50, width/2, height/2, 12));
  chargerEnemies.add(new chargerEnemy(60, width/2, 0, 12));
  //chargerEnemies.add(new chargerEnemy(10, width/2, height, 12));
  //chargerEnemies.add(new chargerEnemy(10, width, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width + 1, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width + 2, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width + 3, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width+4, height/2, 12));
  
  //Loads Larger Enemy
  for (int i=0; i< enemyLarge.length; i++) {
    String filename = "enemybigger" + i + ".png";
    enemyLarge[i] = loadImage(filename);    
  }
  
    for (int i=0; i< enemyLarge.length; i++) {
    String filename = "enemybigger" + i + " copy" + ".png";
    enemyLargeflip[i] = loadImage(filename);    
  }
  

  //Loads Ogre
  for (int i=0; i< ogre.length; i++) {
    String filename = "OGRESPRITE_" + i + ".png";
    ogre[i] = loadImage(filename);
  }
  
 for (int i =0; i < ogreflip.length; i++) {
   String filename = "OGRESPRITE_" + i + " copy" + ".png";
   ogreflip[i] = loadImage (filename);
 }
 
  //Loads Dragon
  for (int i=0; i< dragon.length; i++) {
    String filename = "dragonsprite_" + i + ".png";
    dragon[i] = loadImage(filename);
  }
  
   for (int i=0; i< dragonflip.length; i++) {
    String filename = "dragonsprite_" + i + " copy" + ".png";
    dragonflip[i] = loadImage(filename);
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
  for (int i=0; i <magicFrames.length; i++) {
    String filename = "fireball_0" + i + ".png";
    magicFrames[i] = loadImage(filename);
    magicFrames[i].resize(16, 16);
  }

  //Loads Magicv2

  for (int i=0; i <magicFramesv2.length; i++) {
    String filename = "enemyfireball_0" + i + ".png";
    magicFramesv2[i] = loadImage(filename);
    magicFramesv2[i].resize(16, 16);
  }

  //Loads Melee
  for (int i=0; i< meleeFrames.length; i++) {
    String filename = "melee_0" + i + ".png";
    meleeFrames[i] = loadImage(filename);
  }
}

void draw () {
  background(map.getBackgroundColor());
  map.draw(0, 0);
  PVector p1Map = map.canvasToMap(p1.xpos, p1.ypos);
  map.draw(wall, 1, p1Map.x, p1Map.y);
  // println(canSlash, millis(), cdSlash1, isSlashing);
  p1.animate();

  //temp mouse display hitbox
  pushMatrix(); 
  translate(mouseX, mouseY);
  fill(cd);
  rect(0, 0, 25, 25); 
  popMatrix();


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
    slashPunch = 10;

    slash(color(255, 0, 0));
    HboxSlashes.add(new hitboxSlash(50, 100));
    slashKnockVector.setMag(slashPunch);


    isSlashing = true;
    combo1 = true;
    cantMove = true;
  }
  if (cdSlash2 > millis() && isSlashing == true && combo1 == true && combo2 == false && combo3 == false && cdSlash1 <= millis() && lag2 <= millis()) {
    // while (cdSlash1 > millis()) {}
    // while (lag2 > millis()){}
    lag2 = 0;
    slashPunch = 10;

    slash(color(0, 255, 0));
    HboxSlashes.add(new hitboxSlash(50, 100));
    slashKnockVector.setMag(slashPunch);

    combo2 = true;
    cantMove = true;
  }
  if (cdSlash3 > millis() && isSlashing == true && combo1 == true && combo2 == true && combo3 == false && cdSlash2 <= millis() && lag3 <= millis()) {
    //  while (cdSlash2 > millis()) {}
    //sd while(lag3 > millis()){}
    lag3 = 0;
    slashPunch = 10;

    slash(color(0, 0, 255));
    HboxSlashes.add(new hitboxSlash(50, 100));
    slashKnockVector.setMag(slashPunch);
    combo3 = true;
    cantMove = true;
  }


  //////////////////////TESTING ZONE/////////////////////////////////
  //Area ar1 = new Area(new Rectangle(width/2 - 25/2, height/2 -25/2, 25, 25));
  //rect(width/2, height/2, 25, 25);
  //if (HboxSlashes.size() >= 1) {
  //  hitboxSlash theSlash = HboxSlashes.get(0);
  //  enemy getEnemy = meleeEnemies.get(0);
  //  theSlash.refresh();
  //  getEnemy.refresh();

  //  theSlash.a1.intersect(getEnemy.hbox);


  //  if (theSlash.a1.isEmpty() == false) {
  //    cd = color(0, 0, 255);
  //    println("slash hit" + millis() + "   " +HboxSlashes.size()+"    " + slashNum);
  //  } else {
  //    cd = color(255);
  //  }
  //}

  ////////////////////////////////////////////////////


  for (int i=0; i<bullets.size(); i++) {
    projectile getBullets = bullets.get(i);

    getBullets.display();
    getBullets.update();
  }

  for (int i=0; i<enemyProjectiles.size(); i++) {
    enemyProjectile getProjectile = enemyProjectiles.get(i);

    getProjectile.display();
    getProjectile.update();
  }

  for (int i=0; i<slashes.size(); i++) {
    slashBox getSlashes = slashes.get(i);

    getSlashes.display();
    if (millis()>getSlashes.life) {
      slashes.remove(i);
      HboxSlashes.clear();
    }
  }





  //BULLET COLLISION CHECKING
  if (bullets.size() >=1) {

    if (meleeEnemies.size() >= 1) {
      shootMeleeEnemy();
    }
    if (chargerEnemies.size() >= 1) {
      shootChargerEnemy();
    }
    if (basicRangedEnemies.size() >= 1) {
      shootBasicRangedEnemy();
    }
  }
  if (enemyProjectiles.size() >= 1) {
    shootPlayer();
  }


  if (HboxSlashes.size() >= 1) {
    slashEnemy();
  }


  p1.move();
  p1.display();

  //DISPLAY AND UPDATE ENEMIES

  for (int i=0; i < meleeEnemies.size(); i++) {
    meleeEnemy getEnemy = meleeEnemies.get(i);
    getEnemy.display();
    getEnemy.collide();
  }
  for (int i=0; i < chargerEnemies.size(); i++) {
    chargerEnemy getCharger = chargerEnemies.get(i);
    getCharger.display();
  }
  for (int i=0; i < basicRangedEnemies.size(); i++) {
    basicRangedEnemy getEnemy = basicRangedEnemies.get(i);
    getEnemy.display();
    getEnemy.collide();
  }
  for (int i=0; i < tripleRangedEnemies.size(); i++) {
    tripleRangedEnemy getEnemy = tripleRangedEnemies.get(i);
    getEnemy.display();
    getEnemy.collide();
  }
  for (int i=0; i < turrets.size(); i++) {
    turret getTurret = turrets.get(i);
    getTurret.display();
    getTurret.collide();
  }



  slowTime();

  checkEnemies();
  collideCharger();
  //  stagger();
  // invulCheck();
  convertParts();
  fill(0);
  textSize(40);
  text("Ammo: " + ammo, 20, 100); 
  text("HP: " + p1.hp, 20, 50);
  //////////end of draw
}

void keyPressed() {
  p1.keysCheckP();
  if (key == ' '||keyCode == SHIFT) {
    if (isDashing == false && p1.isStaggered == false) {
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

    if (isDashing == false && click1 == false && click2 == false && click3 == false && canSlash == true) {
      lag1 = tempT + lag1e;
      cdSlash1 = tempT + lag1e + cdSlash1e;
      click1 = true;
    } else if (isDashing == false && click1 == true && click2 == false && click3 == false && canSlash == true) {
      cdSlash1 -= 100;

      lag2 = tempT + lag2e + (cdSlash1 - tempT);      
      cdSlash2 = tempT + cdSlash2e + (lag2-tempT);
      click2 = true;
    } else if (isDashing == false && click1 == true && click2 == true && click3 == false && canSlash == true) {
      cdSlash2 -=100;

      lag3 = tempT + lag3e + (cdSlash2-tempT);
      cdSlash3 = tempT + cdSlash3e + (lag3-tempT);
      click3 = true;
    }
  }
  ////////////
  if (mouseButton == RIGHT) {
    if (ammo > 0) {
      ammo -= 1;
      bullets.add (new projectile());
    }
  }
}

void slash(color c) {

  PVector mouseVec = new PVector(p1.xpos - mouseX, p1.ypos - mouseY);
  mouseVec.normalize();
  mouseVec.mult(10);
  p1.xpos -= mouseVec.x;
  p1.ypos -= mouseVec.y;

  slashes.add(new slashBox(color(c)));
}

void slashEnemy() {
  for (int i=0; i < meleeEnemies.size(); i++) {
    meleeEnemy getEnemy = meleeEnemies.get(i);
    hitboxSlash getSlash = HboxSlashes.get(0);

    //slash begin
    if (getEnemy.lastSlash < getSlash.num) {
      getEnemy.lastSlash = getSlash.num;

      //check for melee enemy getting slashed
      getSlash.a1.intersect(getEnemy.hbox);

      if (getSlash.a1.isEmpty() == false) {
        ammoParts += 1;

        getEnemy.hp -= 1; 

        getEnemy.stun(100); 

        slashBox getSlashAngle = slashes.get(0);
        PVector knockback = new PVector(getEnemy.position.x + 100, getEnemy.position.y);

        knockback.rotate(getSlashAngle.angle);


        getEnemy.position.x -= slashKnockVector.x;
        getEnemy.position.y -= slashKnockVector.y;

        if (getEnemy.hp <= 0) {
          ammoParts += 3;
          meleeEnemies.remove(i);
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }


  for (int i=0; i < chargerEnemies.size(); i++) {
    chargerEnemy getEnemy = chargerEnemies.get(i);
    hitboxSlash getSlash = HboxSlashes.get(0);

    //slash begin
    if (getEnemy.lastSlash < getSlash.num) {
      getEnemy.lastSlash = getSlash.num;

      //check for melee enemy getting slashed
      getSlash.a1.intersect(getEnemy.hbox);

      if (getSlash.a1.isEmpty() == false) {
        if (getEnemy.size <= 25) {
          ammoParts += 1;
        } else {
          ammoParts += 2;
        }
        getEnemy.hp -= 1; 

        getEnemy.stun(100); 

        slashBox getSlashAngle = slashes.get(0);
        PVector knockback = new PVector(getEnemy.position.x + 100, getEnemy.position.y);

        knockback.rotate(getSlashAngle.angle);


        getEnemy.position.x -= slashKnockVector.x;
        getEnemy.position.y -= slashKnockVector.y;

        if (getEnemy.hp <= 0) {
          chargerEnemies.remove(i);
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }

  for (int i=0; i < basicRangedEnemies.size(); i++) {
    basicRangedEnemy getEnemy = basicRangedEnemies.get(i);
    hitboxSlash getSlash = HboxSlashes.get(0);

    //slash begin
    if (getEnemy.lastSlash < getSlash.num) {
      getEnemy.lastSlash = getSlash.num;

      //check for melee enemy getting slashed
      getSlash.a1.intersect(getEnemy.hbox);

      if (getSlash.a1.isEmpty() == false) {
        ammoParts += 1;

        getEnemy.hp -= 1; 

        getEnemy.stun(100); 

        slashBox getSlashAngle = slashes.get(0);
        PVector knockback = new PVector(getEnemy.position.x + 100, getEnemy.position.y);

        knockback.rotate(getSlashAngle.angle);


        getEnemy.position.x -= slashKnockVector.x;
        getEnemy.position.y -= slashKnockVector.y;

        if (getEnemy.hp <= 0) {
          ammoParts += 3;
          basicRangedEnemies.remove(i);
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }

  for (int i=0; i < enemyProjectiles.size(); i++) {
    enemyProjectile getProjectile = enemyProjectiles.get(i);
    hitboxSlash getSlash = HboxSlashes.get(0);

    if (enemyProjectiles.size()-1 < i) {
      break;
    }

    //check for projectile being slashed
    if (getProjectile.canSlash == true) {

      getSlash.a1.intersect(getProjectile.hbox);

      if (getSlash.a1.isEmpty() == false) {
        bullets.add(new projectile());
        projectile getBullet = bullets.get(bullets.size()-1);

        getBullet.position = getProjectile.position;
        getBullet.projectileVec = (getProjectile.projectileVec.mult(-1));
        getBullet.projectileVec.setMag(getProjectile.speed * 2);
        enemyProjectiles.remove(i);
      }
    }
    getSlash.refresh();
    getProjectile.refresh();
  }
}

void shootMeleeEnemy() {

  for (int a=0; a < meleeEnemies.size(); a++) {

    for (int b=0; b < bullets.size(); b++) {
      meleeEnemy getEnemy = meleeEnemies.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          meleeEnemies.remove(a);
        }
        break;
      }
      getEnemy.refresh();
      getBullet.refresh();
    }
  }
}

void shootChargerEnemy() {

  for (int a=0; a < chargerEnemies.size(); a++) {

    for (int b=0; b < bullets.size(); b++) {
      chargerEnemy getEnemy = chargerEnemies.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          chargerEnemies.remove(a);
        }
        break;
      }
      getEnemy.refresh();
      getBullet.refresh();
    }
  }
}

void shootBasicRangedEnemy() {

  for (int a=0; a < basicRangedEnemies.size(); a++) {

    for (int b=0; b < bullets.size(); b++) {
      basicRangedEnemy getEnemy = basicRangedEnemies.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          basicRangedEnemies.remove(a);
        }
        break;
      }
      getEnemy.refresh();
      getBullet.refresh();
    }
  }
}

void checkEnemies() {
  for (int a=0; a < meleeEnemies.size(); a++) {
    meleeEnemy getEnemy = meleeEnemies.get(a); 


    //////WIP player - enemy collision pushback
    //if(getEnemy.position.x - getEnemy.size/2>= p1.xpos + p1.size/2 && p1.ypos < getEnemy.position.y + getEnemy.size/2 && p1.ypos > getEnemy.position.y - getEnemy.size/2) {
    // PVector playerCollision = new PVector(getEnemy.position.x - p1.xpos, getEnemy.position.y - p1.ypos);

    // playerCollision.setMag(1.5);

    // getEnemy.position.x += playerCollision.x;
    // getEnemy.position.y += playerCollision.y;
    //}

    for (int b= a; b <meleeEnemies.size(); b++) {
      if (a != b) {
        meleeEnemy getEnemy1 = meleeEnemies.get(a);
        meleeEnemy getEnemy2 = meleeEnemies.get(b);

        if (dist(getEnemy1.position.x, getEnemy1.position.y, getEnemy2.position.x, getEnemy2.position.y) <= getEnemy1.size/2 + getEnemy2.size/2 + 5) {
          PVector between = new PVector(getEnemy1.position.x - getEnemy2.position.x, getEnemy1.position.y - getEnemy2.position.y);
          between.setMag(2.5); //1.5

          getEnemy1.position.x += between.x;
          getEnemy1.position.x += between.y;


          if (dist(getEnemy2.position.x, getEnemy2.position.y, p1.xpos, p1.ypos) >= 70) {
            getEnemy2.position.x -= between.x;
            getEnemy2.position.y -= between.y;
          }
        }
      }
    }
  } //end melee
  //charger enemies check
  for (int a=0; a < chargerEnemies.size(); a++) {
    for (int b=0; b < chargerEnemies.size(); b++) {
      if (a != b) {
        chargerEnemy getEnemy1 = chargerEnemies.get(a);
        chargerEnemy getEnemy2 = chargerEnemies.get(b);

        if (dist(getEnemy1.position.x, getEnemy1.position.y, getEnemy2.position.x, getEnemy2.position.y) <= getEnemy1.size/2 + getEnemy2.size/2 + 5) {
          PVector between = new PVector(getEnemy1.position.x - getEnemy2.position.x, getEnemy1.position.y - getEnemy2.position.y);
          between.setMag(1.5); 

          getEnemy1.position.x += between.x;
          getEnemy1.position.x += between.y;

          getEnemy2.position.x -= between.x;
          getEnemy2.position.y -= between.y;
        }
      }
    }
  }
}

void convertParts() {
  if (ammoParts >= ratio) {
    ammoParts -= ratio;
    ammo += 1;
  }
}

void shootPlayer() {
  for (int i=0; i < enemyProjectiles.size(); i++) {
    enemyProjectile getProjectile = enemyProjectiles.get(i);

    getProjectile.hbox.intersect(p1.hbox);
    if (getProjectile.hbox.isEmpty() == false) {
      //DAMAGE PLAYER
      damage(getProjectile.position, 7, 1);

      if (p1.invulnerable == true && isDashing == true && p1.isStaggered == false && timeTimer < millis() + 1000) {
        ///SLOW TIME 
        slowTimeTimer();
        iTimer = dTimer;
      } else {
        enemyProjectiles.remove(i);
      }


      break;
    }
    getProjectile.refresh();
    p1.refresh();
  }
}

void slowTimeTimer() {
  timeTimer = millis() + 2500;
}

void slowTime() {
  if (timeTimer > millis()) {
    tint(255, 50);
    image(slowFilter, 0, 0);
    println("TIME SLOWED" + millis());

    if (goTime == true) {
      goTime = false; 
      slowCounter = 0;
    }
    if (goTime == false) {
      slowCounter += 1;
    }
    if (goTime == false && slowCounter >= 3) {
      goTime = true;
    }
  } else {
    goTime = true;
  }
}