class enemy {
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


  int topspeed = 40;

  enemy(float _size, float _xpos, float _ypos, float _mvspeed) {
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

if (dist(position.x, position.y, player.x, player.y) >= 70 && canMove == true) {
    position.x -= towardPlayer.x;
    position.y -= towardPlayer.y;
}
    
    fill(155, 155, 25);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    rect(position.x, position.y, size, size);
  }

  void collide() {
  
    hbox.intersect(playerHbox); 

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

//velocity = new PVector(0, 0);
//    topspeed = 40;

//    mouse.sub(position);
//    mouse.normalize();
//    mouse.mult(3000);

//    projectileVec.normalize();
//    projectileVec.mult(10);
//  }
//  void update() {

//    PVector acceleration = PVector.sub(mouse, position);
//    acceleration.setMag(0.2);

//    velocity.add(acceleration);

//     velocity.limit(topspeed);
//    velocity.setMag(0.2);
//    position.add(velocity);
//    position.x -= projectileVec.x;
//    position.y -= projectileVec.y;