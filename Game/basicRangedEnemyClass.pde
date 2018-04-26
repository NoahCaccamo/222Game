class basicRangedEnemy {
  float size;
  float xpos;
  float ypos;
  int hp;
  PVector position;
  float mvspeed;
  Area hbox;
  PVector towardPlayer;
  PVector player;
  int lastSlash;
  boolean canMove = true;
  int canMoveTimer;
  int flashTimer;
  int shootTimer;
  int shootDelay = 1000;
  int atkAnimTimer = 0; // Use this timer to make the animation happen right before the shoot timer goes off so they align
int frame = 0;
float scaleRatio = 3;
boolean tint;

  basicRangedEnemy(){}
  basicRangedEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 12;
    shootTimer = 0;
  }

  void animate() {
    if (goTime == true) {
    int frame = 0;
    // animate the player 
    // we want to increase the frame counter every 4 frames
    if (frameCount % 4 == 0) frame++;   
    if (frame >= dragon.length) frame = 0;
    }
  }

  void display() {

    if (canMoveTimer < millis()) {
      canMove = true;
    }
    if (flashTimer < millis()) {
     tint = false; 
    }
    if (shootTimer >= 60) {
      shoot(); 
      shootTimer = 0;
    }

    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(0.5);

if (goTime == true) {
    position.x -= towardPlayer.x;
    position.y -= towardPlayer.y;
shootTimer ++;
}

    fill(0, 255, 255);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    if (debug == true) {
    rect(position.x, position.y, size, size);
    }
    
    //anim stuff
    if(tint == true)tint(255,0,0);
    if (towardPlayer.x >= 0) {
      image(dragonflip[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }
    
    else {
      image(dragon[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }

    if(goTime == true) {
    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= dragon.length) frame = 0;
    }
    noTint();
  }

  void collide() {

    hbox.intersect(p1.hbox); 

    if (hbox.isEmpty() == false) {
    } else {
    }
    refresh();
  }

  void refresh() {
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
  }

  void stun(int stunTime) {
    canMove = false;
    canMoveTimer = millis() + stunTime;
  }
  
  void flash(int flashTime) {
   tint = true;
   flashTimer = millis() + flashTime;
  }
  void shoot() {
    enemyProjectiles.add(new enemyProjectile(10, position, 5, true, 0, false));
  }
}
