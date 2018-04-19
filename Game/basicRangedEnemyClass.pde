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
  int shootDelay = 2000;


  basicRangedEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 6;
    shootTimer = millis() + 300;
  }

  void display() {



    if (canMoveTimer < millis()) {
      canMove = true;
    }
    if (shootTimer < millis()) {
      shoot(); 
      shootTimer = millis() + shootDelay;
    }

    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(0.5);


    position.x -= towardPlayer.x;
    position.y -= towardPlayer.y;


    fill(0, 255, 255);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    rect(position.x, position.y, size, size);
  }

  void collide() {

    hbox.intersect(playerHbox); 

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
    enemyProjectiles.add(new enemyProjectile(position));
  }
}
