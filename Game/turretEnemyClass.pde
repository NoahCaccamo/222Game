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
    if(flashTimer < millis()) {
     tint = false; 
    }
    if (shootTimer >= 20) {
      shoot(); 
      shootTimer = 0;
    }
    if (goTime == true) {
      shootTimer ++;
    }

    fill(0);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    if(debug == true) {
    rect(position.x, position.y, size, size);
    }
    if (tint == true) tint(255,0,0);
    image(turret[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    
    if (goTime == true) {
      if (frameCount %5 ==0) frame++;
    if (frame>= turret.length) frame = 0;
    }
    noTint();
  }
  
  void shoot() {
    enemyProjectiles.add(new enemyProjectile(10, position, 2, false, 0, false));
  }
  
}
