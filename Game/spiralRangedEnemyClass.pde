class spiralRangedEnemy extends basicRangedEnemy {

  float angle;
  float angleNum;
  int activeTimer;
  boolean active;
  
  spiralRangedEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {

    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 12;
    shootTimer = 0;
    angleNum = 20;
    angle = radians(angleNum);
    activeTimer = 540; 
  }

  void display() {
    if (canMoveTimer < millis()) {
      canMove = true;
    }
    
    if (activeTimer >= 540/3 && active == false) {
     active = true;
     activeTimer = 0;
    }else if (activeTimer >= 540 && active == true) {
     active = false;
     activeTimer = 0;
    }
    
    if (shootTimer >= 20) {
      shoot(); 
      shootTimer = 0;
    }

    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(0.3);

    if (goTime == true) {
      position.x -= towardPlayer.x;
      position.y -= towardPlayer.y;
      activeTimer ++;
      if(active == true) {
      shootTimer ++;
      }
    }

    fill(0, 255, 255);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    rect(position.x, position.y, size, size);
  }
  
   void shoot() {
     angleNum += 10;
     angle = radians(angleNum);
    enemyProjectiles.add(new enemyProjectile(10, position, 1, false, angle, true));
    enemyProjectiles.add(new enemyProjectile(10, position, 1, false, -angle, true));
    enemyProjectiles.add(new enemyProjectile(10, position, 1, false, angle + PI/2, true));
    enemyProjectiles.add(new enemyProjectile(10, position, 1, false, -angle + PI/2, true));
  }
}
