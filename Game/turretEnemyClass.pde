class turret extends basicRangedEnemy {

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

    fill(0);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    rect(position.x, position.y, size, size);
  }
  
  void shoot() {
    enemyProjectiles.add(new enemyProjectile(position, 2, true, 0, false));
  }
  
}
