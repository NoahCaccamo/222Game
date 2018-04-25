
class turret extends basicRangedEnemy {
  
   float scaleRatio = 1.5000;
    
  turret (float _size, float _xpos, float _ypos) {

    size = _size;
    xpos = _xpos;
    ypos = _ypos;

    position = new PVector(xpos, ypos);
    hp = 12;
    shootTimer = 0;
  }

  void display() {

    if (canMoveTimer < millis()) {
      canMove = true;
    }
    if (shootTimer >= 20) {
      shoot(); 
      shootTimer = 0;
    }
    if (goTime == true) {
      shootTimer ++;
    }
    
    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(4);
    
     if (towardPlayer.y >= 0) {
      
      image(turret[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }
    
    else {
      image(turretflip[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }
    
    if (frameCount %5 ==0) frame++;
    if (frame>= turret.length) frame = 0;
    
    fill(0);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
   // rect(position.x, position.y, size, size);
  }
  
  void shoot() {
    enemyProjectiles.add(new enemyProjectile(position, 2, true, 0, false));
  }
  
}