class chargerEnemy {
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

  chargerEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 1;
  }

  void display() {
if (canMoveTimer < millis()) {
      canMove = true;
    }

    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(4);

if (canMove == true) {
    position.x -= towardPlayer.x;
    position.y -= towardPlayer.y;
}

    fill(0, 255, 0);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    rect(position.x, position.y, size, size);
  }



  void refresh() {
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
  }
  
    void stun(int stunTime) {
    canMove = false;
    canMoveTimer = millis() + stunTime;
  }
  
}

void collideCharger() {
  for (int i=0; i < chargerEnemies.size(); i++) {
    chargerEnemy getCharger = chargerEnemies.get(i);

    getCharger.hbox.intersect(playerHbox); 

    if (getCharger.hbox.isEmpty() == false) {
      //DAMAGE PLAYER////////////////////////////////////////////////////////////////////////////////////////////////////////
      println("boon");
      chargerEnemies.remove(i);
    } else {
    }
    getCharger.refresh();
  }
}