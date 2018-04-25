
//INSTRUCTIONS: WSAD - move
// SPACEBAR or SHIFT - dodge
// Left Click - slash
// Right Click - shoot
import java.awt.geom.*;
import java.awt.*;

//////////////////////////////////////////

// declare game state variables
int mainM = 0;
int controlM = 1;
int runGame = 2;
int gameO = 3;

// current game state
int gameState = mainM;

// declare obj variables for menus
mainMenu mM;
controlMenu cM;
gameOver gO;

//////////////////////////////////////////

PImage slowFilter;
PImage emptyHeart, fullHeart;

Area playerHbox;

ArrayList<hitboxSlash> HboxSlashes = new ArrayList<hitboxSlash>();

Player p1;
basicRangedEnemy e1, e2;

ArrayList<fadePlayer> streak = new ArrayList<fadePlayer>();

ArrayList<projectile> bullets = new ArrayList <projectile>();
ArrayList<enemyProjectile> enemyProjectiles = new ArrayList <enemyProjectile>();

ArrayList<slashBox> slashes = new ArrayList<slashBox>();

ArrayList<pickup> pickups = new ArrayList<pickup>();
ArrayList<maxPickup> maxPickups = new ArrayList<maxPickup>();
//Enemy Arrays
ArrayList<meleeEnemy> meleeEnemies = new ArrayList<meleeEnemy>();
ArrayList<chargerEnemy> chargerEnemies = new ArrayList<chargerEnemy>();
ArrayList<basicRangedEnemy> basicRangedEnemies = new ArrayList<basicRangedEnemy>();
ArrayList<tripleRangedEnemy> tripleRangedEnemies = new ArrayList<tripleRangedEnemy>();
ArrayList<turret> turrets = new ArrayList<turret>();
ArrayList<spiralRangedEnemy> spiralRangedEnemies = new ArrayList<spiralRangedEnemy>();

int score;
int ammo;
int ratio = 6;
float ammoParts;

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

int wave;
int wavePoints;

int chanceMelee, chanceCharger, chanceRanged, chanceTriple, chanceSpiral, chanceTurret, chanceSwarm;
int meleeCost = 1;
int chargerCost = 1;
int rangedCost = 1;
int tripleCost = 2;
int spiralCost = 10;
int turretCost = 5;
int swarmCost = 3;

int collideTimer = 1000;
int pickupTimer;
int normalRate = 25;
int lowRate = 5;
int highRate = 80;

int damageTaken;
color cd = color(255, 0, 0);

void setup() {
  fullScreen();
  //size(900, 900);
  noStroke();
  rectMode(CENTER);

  // add menus
  mM = new mainMenu();
  cM = new controlMenu();
  gO = new gameOver();

  slowFilter = loadImage("purp-FILTER.png");
  slowFilter.resize(width, height);
  fullHeart = loadImage("fill.png");
  emptyHeart = loadImage("empty.png");

  //add the player
  p1 = new Player(40, 1, 1, 3);
  //meleeEnemies.add( new meleeEnemy(30, width/2, height/2, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2, 0, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2+1, 0, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2+10, 0, 3));
  //meleeEnemies.add( new meleeEnemy(30, width/2+15, 0, 3));
  //basicRangedEnemies.add( new basicRangedEnemy(40, width/2, height/2, 1));
  //basicRangedEnemies.add( new basicRangedEnemy(50, width/2, 0, 56));

  //tripleRangedEnemies.add( new tripleRangedEnemy(50, 800, 0, 56));
  // turrets.add(new turret(30, width/2, height/2));

  //chargerEnemies.add(new chargerEnemy(10, width/2, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width/2, 0, 12));
  //chargerEnemies.add(new chargerEnemy(10, width/2, height, 12));
  //chargerEnemies.add(new chargerEnemy(10, width, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width + 1, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width + 2, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width + 3, height/2, 12));
  //chargerEnemies.add(new chargerEnemy(10, width+4, height/2, 12));

  //spiralRangedEnemies.add(new spiralRangedEnemy(30, width/2, height/2, 0.3));
  //spiralRangedEnemies.add(new spiralRangedEnemy(30, width/2 + 200, height/2+ 300, 0.3));
}

void draw() {
  // for changing game states
  if (gameState == mainM) {
    mM.display(); // display main menu
    // reset game elements
    score = 0;
    p1.hp = 6;
    ammo = 0;
    ammoParts = 0;
    wave = 0;
    wavePoints = 0;
    p1.xpos = 0;
    p1.ypos = 0;
    collideTimer = 1000;
    meleeEnemies.clear();
    chargerEnemies.clear();
    basicRangedEnemies.clear();
    tripleRangedEnemies.clear(); 
    spiralRangedEnemies.clear(); 
    turrets.clear();
    maxPickups.clear();
    bullets.clear();
    enemyProjectiles.clear();
  } else if (gameState == runGame) { 
    runGame(); // run the game
  } else if (gameState == controlM) { 
    cM.display(); // display controls menu
  } else if (gameState == gameO) {
    gO.display(); // display game over screen
    fill(255);
    textSize(48);
    text(score + " points", (width/4)*2.9, (height/4)*3.1);
  }
}

void runGame () {
  int millis = millis();
  background(135);
  // println(canSlash, millis(), cdSlash1, isSlashing);


  //temp mouse display hitbox///Make reticle here later
  pushMatrix(); 
  translate(mouseX, mouseY);
  fill(cd);
  rect(0, 0, 25, 25); 
  popMatrix();
  ////////////////////////

  //DASHING

  //stop dashing when the dash timer ends
  if (dTimer < millis()) {
    isDashing = false;
  }

  //Dash movement + FX
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

  //Display dash FX
  for (int i=0; i<streak.size(); i++) {
    fadePlayer gotFade = streak.get(i);
    gotFade.fade();
    gotFade.display();
    if (gotFade.trans <= 0) {
      streak.remove(i);
    }
  }

  //SLASHING

  //cant move while slashing
  if (cdSlash1 < millis() && cdSlash2 < millis() && cdSlash3 < millis()) {
    cantMove = false;
  }

  //End combo state
  if (cdSlash1 + 100 < millis() && cdSlash2 + 100 < millis() && cdSlash3 < millis()) {
    combo1 = false; 
    combo2 = false; 
    combo3 = false;
    click1 = false;
    click2 = false;
    click3 = false;
    isSlashing = false;
  }


  //Execute slashes based on flags and timers
  if (cdSlash1 > millis() && isDashing == false && combo1 == false && combo2 == false && combo3 == false && lag1 <= millis()) {
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


  //DISPLAY BULLETS AND SLASHES

  //despawn bullets out of bounds
  for (int i=0; i < bullets.size(); i++) {
    projectile getBullets = bullets.get(i);
    if (getBullets.position.x > width || getBullets.position.x < 0 || getBullets.position.y > height || getBullets.position.y < 0) {
      bullets.remove(i);
      break;
    }
  }

  for (int i=0; i<bullets.size(); i++) {
    projectile getBullets = bullets.get(i);

    getBullets.display();
    getBullets.update();
  }

  for (int i=0; i < enemyProjectiles.size(); i++) {
    enemyProjectile getProjectile = enemyProjectiles.get(i);
    if (getProjectile.position.x > width || getProjectile.position.x < 0 || getProjectile.position.y > height || getProjectile.position.y < 0) {
      enemyProjectiles.remove(i);
      break;
    }
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
  if (bullets.size() >=1 && collideTimer < millis) {

    if (meleeEnemies.size() >= 1) {
      shootMeleeEnemy();
    }
    if (chargerEnemies.size() >= 1) {
      shootChargerEnemy();
    }
    if (basicRangedEnemies.size() >= 1) {
      shootBasicRangedEnemy();
    }
    if (tripleRangedEnemies.size() >= 1) {
      shootTripleRangedEnemy();
    }
    if (spiralRangedEnemies.size() >= 1) {
      shootSpiralRangedEnemy();
    }
    if (turrets.size() >=1) {
      shootTurrets();
    }
  }
  if (enemyProjectiles.size() >= 1) {
    shootPlayer();
  }

  //SLASH COLISION CHECKING
  if (HboxSlashes.size() >= 1 && collideTimer < millis) {
    slashEnemy();
  }

  if (p1.xpos + p1.size/2 > width) {
    p1.xpos = width - p1.size/2;
  } else if (p1.xpos - p1.size/2 < 0) {
    p1.xpos = 0 + p1.size/2;
  }

  if (p1.ypos + p1.size/2 > height) {
    p1.ypos = height - p1.size/2;
  } else if (p1.ypos - p1.size/2 < 0) {
    p1.ypos = 0 + p1.size/2;
  }

  //display player
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
  for (int i=0; i < spiralRangedEnemies.size(); i++) {
    spiralRangedEnemy getSpiral = spiralRangedEnemies.get(i);
    getSpiral.display();
    getSpiral.collide();
  }
  for (int i=0; i < pickups.size(); i++) {
    pickup getPickup = pickups.get(i);
    if (getPickup.life < millis) {
      pickups.remove(i);
    }
  }

  for (int i=0; i < pickups.size(); i++) {
    pickup getPickup = pickups.get(i);
    getPickup.display();
  }
  for (int i=0; i < maxPickups.size(); i++) {
    maxPickup getPickup = maxPickups.get(i);
    getPickup.display();
  }




  //Check stuff
  slowTime();
  collideCharger();
  if (pickupTimer < millis) collidePickup();
  collideMaxPickup();
  checkEnemies();
  stagger();
  invulCheck();
  convertParts();

  //DISPLAY HUD
  fill(0);
  textSize(40);
  text("Ammo: " + ammo, 30, 110); 
  displayHealth();
  spawner();
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

  // To switch game states on main menu screen
  if (gameState == mainM) {
    // To switch game state from main menu to run game
    if ((mouseX >= width/2 && mouseX <= width) && (mouseY >= 0 && mouseY <= height/2)) {
      gameState = runGame;
    }
    //To switch game state from main menu to controls menu
    if ((mouseX >= width/2 && mouseX <= width) && (mouseY >= height/2 && mouseY <= height)) {
      gameState = controlM;
    }
  }

  // To switch game state on controls screen
  if (gameState == controlM) {
    // To switch game state from controls menu to run game
    if ((mouseX >= width/2 && mouseX <= width) && (mouseY >= 0 && mouseY <= height/2)) {
      gameState = runGame;
    }
  }

  // To switch game state on game over screen
  if (gameState == gameO) {
    // To switch game state from game over to main menu
    if ((mouseX >= width/2 && mouseX <= width) && (mouseY >= 0 && mouseY <= height/2)) {
      gameState = mainM;
    }
  }

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
      bullets.add (new projectile(10, false));
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
    if ( i+1 > meleeEnemies.size()) break;

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
          rollPickup(getEnemy.position, normalRate);
          meleeEnemies.remove(i);
          score++; // increase score if player kills enemy
          ///TEMP REMOVE
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }

  if (chargerEnemies.size() > 0) {
    for (int i=0; i < chargerEnemies.size(); i++) {
      chargerEnemy getEnemy = chargerEnemies.get(i);
      hitboxSlash getSlash = HboxSlashes.get(0);

      //slash begin
      if (getEnemy.lastSlash < getSlash.num) {
        getEnemy.lastSlash = getSlash.num;

        if (i+1 > chargerEnemies.size()) {
          break;
        }
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
            if (getEnemy.size >= 30) {
              rollPickup(getEnemy.position, normalRate);
            } else rollPickup(getEnemy.position, lowRate);
            chargerEnemies.remove(i);
            score++;
          }
        }
      }
      getSlash.refresh();
      getEnemy.refresh();
      //slash end
    }
  }

  for (int i=0; i < basicRangedEnemies.size(); i++) {
    basicRangedEnemy getEnemy = basicRangedEnemies.get(i);
    hitboxSlash getSlash = HboxSlashes.get(0);

    //slash begin
    if (getEnemy.lastSlash < getSlash.num) {
      getEnemy.lastSlash = getSlash.num;
      if (i+1 > basicRangedEnemies.size()) {
        break;
      }

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
          rollPickup(getEnemy.position, normalRate);
          basicRangedEnemies.remove(i);
          score++;
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }

  for (int i=0; i < tripleRangedEnemies.size(); i++) {
    tripleRangedEnemy getEnemy = tripleRangedEnemies.get(i);
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
          rollPickup(getEnemy.position, normalRate);
          tripleRangedEnemies.remove(i);
          score++;
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }

  for (int i=0; i < spiralRangedEnemies.size(); i++) {
    spiralRangedEnemy getEnemy = spiralRangedEnemies.get(i);
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
          rollPickup(getEnemy.position, highRate);
          spiralRangedEnemies.remove(i);
          score++;
        }
      }
    }
    getSlash.refresh();
    getEnemy.refresh();
    //slash end
  }

  for (int i=0; i < turrets.size(); i++) {
    turret getEnemy = turrets.get(i);
    hitboxSlash getSlash = HboxSlashes.get(0);
    if (i > turrets.size()) {
      break;
    }
    //slash begin
    if (getEnemy.lastSlash < getSlash.num) {
      getEnemy.lastSlash = getSlash.num;

      //check for melee enemy getting slashed
      getSlash.a1.intersect(getEnemy.hbox);

      if (getSlash.a1.isEmpty() == false) {
        ammoParts += 1;

        getEnemy.hp -= 1; 

        if (getEnemy.hp <= 0) {
          ammoParts += 3;
          rollPickup(getEnemy.position, highRate);
          turrets.remove(i);
          score++;
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


    getSlash.a1.intersect(getProjectile.hbox);

    if (getSlash.a1.isEmpty() == false) {
      if (getProjectile.canSlash == true) {
        bullets.add(new projectile(10, false));
        projectile getBullet = bullets.get(bullets.size()-1);

        getBullet.position = getProjectile.position;
        getBullet.projectileVec = (getProjectile.projectileVec.mult(-1));
        getBullet.projectileVec.setMag(getProjectile.speed * 2);
        enemyProjectiles.remove(i);
      } else {
        enemyProjectiles.remove(i);
      }
    }

    getSlash.refresh();
    getProjectile.refresh();
  }
}

void shootMeleeEnemy() {

  for (int a=0; a < meleeEnemies.size(); a++) {
    if (a+1 > meleeEnemies.size()) {
      break;
    }
    for (int b=0; b < bullets.size(); b++) {
      if (b+1 > bullets.size()) {
        break;
      }

      meleeEnemy getEnemy = meleeEnemies.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          rollPickup(getEnemy.position, normalRate);
          meleeEnemies.remove(a);
          score++;
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

      if (a+1>chargerEnemies.size() || b+1>bullets.size()) {
        break;
      }

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          if (getEnemy.size >= 30) {
            rollPickup(getEnemy.position, normalRate);
          } else rollPickup(getEnemy.position, lowRate);
          chargerEnemies.remove(a);
          score++;
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

      if (bullets.isEmpty() == true || basicRangedEnemies.isEmpty() == true) {
        break;
      }
      if (a+1 > basicRangedEnemies.size() || b+1 > bullets.size()) {
        break;
      }

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          rollPickup(getEnemy.position, normalRate);
          basicRangedEnemies.remove(a);
          score++;
        }
        break;
      }
      getEnemy.refresh();
      getBullet.refresh();
    }
  }
}

void shootTripleRangedEnemy() {

  for (int a=0; a < tripleRangedEnemies.size(); a++) {
    if (a > tripleRangedEnemies.size()) {
      break;
    }

    for (int b=0; b < bullets.size(); b++) {
      if (b > bullets.size()) {
        break;
      }

      tripleRangedEnemy getEnemy = tripleRangedEnemies.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          rollPickup(getEnemy.position, normalRate);
          tripleRangedEnemies.remove(a);
          score++;
        }
        break;
      }
      getEnemy.refresh();
      getBullet.refresh();
    }
  }
}

void shootSpiralRangedEnemy() {

  for (int a=0; a < spiralRangedEnemies.size(); a++) {

    for (int b=0; b < bullets.size(); b++) {
      spiralRangedEnemy getEnemy = spiralRangedEnemies.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          rollPickup(getEnemy.position, highRate);
          spiralRangedEnemies.remove(a);
          score++;
        }
        break;
      }
      getEnemy.refresh();
      getBullet.refresh();
    }
  }
}

void shootTurrets() {

  for (int a=0; a < turrets.size(); a++) {

    for (int b=0; b < bullets.size(); b++) {
      turret getEnemy = turrets.get(a);
      projectile getBullet = bullets.get(b);

      getBullet.hbox.intersect(getEnemy.hbox);

      if (getBullet.hbox.isEmpty() == false) {
        getEnemy.hp -= bulletDamage;
        bullets.remove(b);

        if (getEnemy.hp <= 0) {
          rollPickup(getEnemy.position, highRate);
          turrets.remove(a);
          score++;
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
      } else if (p1.invulnerable == true && isDashing == true) {
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
    tint(255, 50); //50

    image(slowFilter, 0, 0);

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

void displayHealth() {
  text("Health: ", 30, 55);
  tint(255);
  for (int i=0; i < p1.maxHp; i++) {
    image(emptyHeart, 200+ i*70, 10);
  }

  for (int i=0; i < p1.hp; i++) {
    image(fullHeart, 200+ i*70, 10);
  }
}

void spawner() {
  text(wave, width/2, height/2);

  if (meleeEnemies.isEmpty() && chargerEnemies.isEmpty() && basicRangedEnemies.isEmpty() && tripleRangedEnemies.isEmpty() && spiralRangedEnemies.isEmpty() && turrets.isEmpty() && maxPickups.isEmpty() && collideTimer < millis()) {
    wave ++;
    collideTimer = millis() + 1000;
    if (wave <= 2) {
      calcChances(33.33, 33.33, 33.33, 0, 0, 0, 0);
      wavePoints = 1;
    } else if ( wave <= 5) {
      calcChances(30, 30, 30, 10, 0, 0, 0);
      wavePoints = 2;
    } else if (wave < 6) {
      wavePoints = 5;
    } else if (wave == 6) { 
      spiralRangedEnemies.add(new spiralRangedEnemy(30, random(width), random(height), 0.3));
      if (damageTaken == 0)maxPickups.add(new maxPickup(30, width/2, height/2));
      damageTaken = 0;
    } else if (wave < 10) {
      calcChances(20, 20, 20, 20, 5, 5, 10);
      wavePoints = 10;
    } else {
      wavePoints = 30;
    }
  }

  if (wavePoints > 0) {
    float rand = random(0, 100);

    if (rand < chanceMelee) {
      if (wavePoints >= meleeCost) {
        PVector pos = securePos(0, width, 0, height, 400);
        meleeEnemies.add( new meleeEnemy(30, pos.x, pos.y, 3));
        wavePoints -= meleeCost;
      }
    } else if (rand < chanceCharger) {
      if (wavePoints >= chargerCost) {
        PVector pos = securePos(0, width, 0, height, 515);
        chargerEnemies.add(new chargerEnemy(20, pos.x, pos.y, 12));
        wavePoints -= chargerCost;
      }
    } else if (rand < chanceRanged) {
      if (wavePoints >= rangedCost) {
        PVector pos = securePos(0, width, 0, height, 800);
        basicRangedEnemies.add( new basicRangedEnemy(50, pos.x, pos.y, 56));
        wavePoints -= rangedCost;
      }
    } else if (rand < chanceTriple) {
      if (wavePoints >= tripleCost) {
        PVector pos = securePos(0, width, 0, height, 800);
        tripleRangedEnemies.add( new tripleRangedEnemy(50, pos.x, pos.y, 56));
        wavePoints -= tripleCost;
      }
    } else if (rand < chanceSpiral) {
      if (wavePoints >= spiralCost) {
        PVector pos = securePos(0, width, 0, height, 400);
        spiralRangedEnemies.add(new spiralRangedEnemy(30, pos.x, pos.y, 0.3));
        wavePoints -= spiralCost;
      }
    } else if (rand < chanceTurret) {
      if (wavePoints >= turretCost) {
        PVector pos = securePos(0, width, 0, height, 400);
        turrets.add(new turret(30, pos.x, pos.y));
        wavePoints -= turretCost;
      }
    } else if (rand < chanceSwarm) {
      if (wavePoints >= swarmCost) {
        float swarmNum = random(3, 8);
        PVector pos = securePos(0, width, 0, height, 1000);
        for (int i=0; i < swarmNum; i++) {
          chargerEnemies.add(new chargerEnemy(10, pos.x + i, pos.y + i, 12));
        }
        wavePoints -= swarmCost;
      }
    } else {
    }
  }
}

void calcChances(float _chanceMelee, float _chanceCharger, float _chanceRanged, float _chanceTriple, float _chanceSpiral, float _chanceTurret, float _chanceSwarm) {
  int currentMax = 0;

  currentMax += _chanceMelee;
  chanceMelee = currentMax;

  currentMax += _chanceCharger;
  chanceCharger = currentMax;

  currentMax += _chanceRanged;
  chanceRanged = currentMax;

  currentMax += _chanceTriple;
  chanceTriple = currentMax;

  currentMax += _chanceSpiral;
  chanceSpiral = currentMax;

  currentMax += _chanceTurret;
  chanceTurret = currentMax;

  currentMax += _chanceSwarm;
  chanceSwarm = currentMax;
}

void rollPickup(PVector position, int chance) {
  float rng = random(0, 100);
  if (rng < chance) {
    pickups.add(new pickup(20, position.x, position.y));
    pickupTimer = millis() + 500;
  }
}

PVector securePos(float minPosX, float maxPosX, float minPosY, float maxPosY, float minDist) {
  float tempRandomX = random(minPosX, maxPosX);
  float tempRandomY = random(minPosY, maxPosY);

  if (dist(tempRandomX, tempRandomY, p1.xpos, p1.ypos) >= minDist) {
    return new PVector(tempRandomX, tempRandomY);
  } else {
    return securePos(minPosX, maxPosX, minPosY, maxPosY, minDist);
  }
}