class meleeEnemy { // NOTE: I havent made the attack yet for these guys. Just make a function in this class that executes the melee animation and we good.
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
  int flip;
  int frame;
  int x;
  int y;

  int topspeed = 40;

  meleeEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 6;
  }

  void display() {
    if (canMoveTimer < millis()) {
      canMove = true;
    }

    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(2);

    if (dist(position.x, position.y, player.x, player.y) >= 70 && canMove == true && goTime == true) {
      position.x -= towardPlayer.x;
      position.y -= towardPlayer.y;
    }

    rect(position.x, position.y, size, size);
    pushMatrix(); // save the origin 
    image(ogre[frame], position.x, position.y);
    popMatrix();  // restore the origin

    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= ogre.length) frame = 0;
    
    fill(155, 155, 25);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
  }

  void collide() {

    hbox.intersect(p1.hbox); 

    if (hbox.isEmpty() == false) {
      //println("hit" + millis());
      //println("slash hit" + millis() + "   " +HboxSlashes.size()+"    " + slashNum);
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
}