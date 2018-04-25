class meleeEnemy { 
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
  float angle;
  int displayIncr;
  int displayMax = 10;
  int meleeTimer = 120;
  int meleeIncrement;


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
    }else {
      meleeIncrement++;
      if (meleeIncrement > meleeTimer) {
      if (displayIncr < displayMax) {
             slash();
             if (displayIncr == displayMax) {
              eHboxSlashes.add(new meleeEnemy.eHitboxSlash(50,50)); 
             }
      }else {
       meleeIncrement = 0;
       displayIncr = 0;
      }
      }
    }

    fill(155, 155, 25);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    rect(position.x, position.y, size, size);
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


  void slash() {
    float tAngle;
    if(displayIncr == 0) {
    tAngle = atan2(p1.ypos - position.y, p1.xpos - position.x);

    if (tAngle < 0) {
      tAngle += TWO_PI;
    }
    angle = tAngle;
    }
    displayIncr++;
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    translate(50, 0);
    fill(255);
    rect(0, 0, 50, 50);
    popMatrix();
  }

  class eHitboxSlash {

    Rectangle r1;
    AffineTransform t1 = new AffineTransform();
    Area a1;
    float xpos = p1.xpos;
    float ypos = p1.ypos;
    int num;
    PVector knockbackS;
    int incr;
    int life = 10;

    eHitboxSlash(int _rwidth, int _rheight) {

      int rwidth = _rwidth;
      int rheight = _rheight;
      knockbackS = position;
      r1 = new Rectangle(0, 0, rwidth, rheight);

      t1.translate(position.x, position.y);
      t1.rotate(angle);
      t1.translate(50, 0);
      t1.translate(-rwidth/2, -rheight/2);
      a1 = new Area(t1.createTransformedShape(r1));
    }

    void refresh() {
      a1 = new Area(t1.createTransformedShape(r1));
    }
    
    void count() {
      incr ++;
    }
  }
}




//class slashBox {
//  float bwidth = 50;
//  float bheight = 50;
//  float xpos;
//  float ypos;
//  float angle;

//  float plx;
//  float ply;

//  int life = millis() + 50;
//  color c;

//  slashBox(color bc) {

//    c = bc;

//    mAngle = atan2(mouseY-p1.ypos, mouseX - p1.xpos);

//    if (mAngle < 0) {
//      mAngle += TWO_PI;
//    }
//    angle = mAngle;

//    pushMatrix();
//    translate(p1.xpos, p1.ypos);
//    rotate(mAngle);
//    translate(50, 0);

//    xpos = screenX(0, 0);
//    ypos = screenY(0, 0);

//    plx = p1.xpos;
//    ply = p1.ypos;

//    popMatrix();
//  }

//  void display() {
//    pushMatrix();
//    translate(plx, ply);
//    rotate(angle);
//    translate(50, 0);
//    fill(c);
//    rect(0, 0, bwidth, bheight);
//    popMatrix();
//  }
//}


//class hitboxSlash {

//  Rectangle r1;
//  AffineTransform t1 = new AffineTransform();
//  Area a1;
//  float xpos = p1.xpos;
//  float ypos = p1.ypos;
//  int num;

//  hitboxSlash(int _rwidth, int _rheight) {

//    slashKnockVector= new PVector(p1.xpos - mouseX, p1.ypos - mouseY);
//    slashNum += 1;
//    num = slashNum;
//    int rwidth = _rwidth;
//    int rheight = _rheight;

//    r1 = new Rectangle(0, 0, rwidth, rheight);

//    t1.translate(xpos, ypos);
//    t1.rotate(mAngle);
//    t1.translate(50, 0);
//    t1.translate(-rwidth/2, -rheight/2);
//    a1 = new Area(t1.createTransformedShape(r1));
//  }

//  void refresh() {
//    a1 = new Area(t1.createTransformedShape(r1));
//  }
//}
