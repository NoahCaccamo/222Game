class basicRangedEnemy {
  float size;
  float xpos;
  float ypos;
  float speedX;
  float speedY;
  float scaleRatio = 1.0000;
  int hp;
  PVector position;
  float mvspeed;
  Area hbox;
  PVector towardPlayer;
  PVector player;
  int lastSlash;
  boolean canMove = true;
  int canMoveTimer;
  int shootTimer;
  int shootDelay = 1000;
  int atkAnimTimer = 0; // Use this timer to make the animation happen right before the shoot timer goes off so they align
  int frame = 0;  // our current frame 
  int flip = 1;
  float x;
  float y;

  basicRangedEnemy() {
  }
  basicRangedEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 12;
    shootTimer = 0;
    x = random(width);
    y = random(height);
  }

  void animate() {
    int frame = 0;
    // animate the player 
    // we want to increase the frame counter every 4 frames
    if (frameCount % 4 == 0) frame++;   
    if (frame >= dragon.length) frame = 0;
  }

  void display() {  
    if (canMoveTimer < millis()) {
      canMove = true;
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
    // rect(position.x, position.y, size, size);


    pushMatrix(); // save the origin 
    if (towardPlayer.x >= 0) {
      image(dragonflip[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }
    
    else {
      image(dragon[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }

    popMatrix();  // restore the origin   
    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= dragon.length) frame = 0;
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

  void shoot() {
    enemyProjectiles.add(new enemyProjectile(position, 5, true, 0, false));
  }
}