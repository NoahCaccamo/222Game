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
  int shootTimer;
  int shootDelay = 1000;
  int atkAnimTimer = 0; // Use this timer to make the animation happen right before the shoot timer goes off so they align

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
    rect(position.x, position.y, size, size);
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
    enemyProjectiles.add(new enemyProjectile(10, position, 5, true, 0, false));
  }
}
