class Player {
  boolean[] keys =new boolean [4];
  float size;
  float xpos;
  float ypos;
  float mvspeed;
  Area hbox;
  int hp = 6;
  int maxHp = 6;
  boolean isStaggered;
  boolean invulnerable;

  Player(float isize, float ixpos, float iypos, float imvspeed) {
    size = isize;
    xpos = ixpos;
    ypos = iypos;
    mvspeed = imvspeed;
  }

  void display() {
    fill(255, 0, 0);
    if (invulnerable == true) fill(0,0,255);
    rect(xpos, ypos, size, size);
    hbox = new Area(new Rectangle2D.Float(p1.xpos - size/2, p1.ypos - size/2, size, size));
  }

  void refresh() {
    hbox = new Area(new Rectangle2D.Float(p1.xpos - size/2, p1.ypos - size/2, size, size));
  }

  void keysCheckP() { //Movement system from "eraser peel" - Youtube
    if (key == 'w' || key == 'W') {
      keys[0] = true;
    }




    if (key == 's' || key == 'S') {
      keys[1] = true;
    }


    if (key == 'a' || key == 'A') {
      keys[2] = true;
    }



    if (key == 'd' || key == 'D') {
      keys[3] = true;
    }
  }

  void keysCheckR() {
    if (key == 'w' || key == 'W') {
      keys[0] = false;
    }

    if (key == 's' || key == 'S') {
      keys[1] = false;
    }

    if (key == 'a' || key == 'A') {
      keys[2] = false;
    }

    if (key == 'd' || key == 'D') {
      keys[3] = false;
    }
  }



  void move() {

    if (keys[0] == true && cantMove == false && p1.isStaggered == false) {
      ypos -= mvspeed;
    }


    if (keys[1] == true && cantMove == false && p1.isStaggered == false) {
      ypos += mvspeed;
    }


    if (keys[2] == true && cantMove == false && p1.isStaggered == false) {
      xpos -= mvspeed;
    }

    if (keys[3] == true && cantMove == false && p1.isStaggered == false) {
      xpos += mvspeed;
    }
  }

  void dash() {
    //if (keys[0] == true && keys[1] == false && keys[2] == false && keys[3] == false) {
    if (keys[0] == true) {
      startDodge();
      dUp = true;
      dVert = -1;
    }

    // if (keys[0] == false && keys[1] == true && keys[2] == false && keys[3] == false) {
    if (keys[1] == true) {
      startDodge();
      dDown = true;
      dVert = 1;
    }

    //if (keys[0] == false && keys[1] == false && keys[2] == true && keys[3] == false) {
    if (keys[2] == true) {
      startDodge();
      dLeft = true;
      dHoriz = -1;
    }
    //if (keys[0] == false && keys[1] == false && keys[2] == false && keys[3] == true) {
    if (keys[3] == true) {
      startDodge();
      dRight = true;
      dHoriz = 1;
    }
  }
}


class fadePlayer {
  float size;
  float xpos;
  float ypos;
  int timer;
  int trans = 255;

  fadePlayer(float isize, float ixpos, float iypos, int itimer) {
    size = isize;
    xpos = ixpos;
    ypos = iypos;
    timer = itimer;
  }
  void fade() {
    trans -= 40;
  }

  void display() {

    fill(255, 0, 0, trans);
    rect(xpos, ypos, size, size);
  }
}

void damage(PVector source, float force, int damage) {
  if (p1.invulnerable == false) {
    damageTaken++;
    p1.invulnerable = true;
    p1.hp -= damage;
    lastSource = new PVector(source.x - p1.xpos, source.y - p1.ypos);
    lastForce = force;
    lastSource.setMag(lastForce);

    sTimer = millis() + 200;
    smTimer = millis() + 75;
    iTimer = millis() + 600;
    p1.isStaggered = true;

    if (p1.hp <= 0) {
      //game over
      println("game over");
      gameState = gameO;
    }
  }
}

void stagger() {

  if (sTimer > millis()) {
    dTimer = 0;
    canSlash = false;
    fill(255, 0, 255);
    rect(p1.xpos, p1.ypos, p1.size, p1.size);
    if (smTimer > millis()) {
      p1.xpos -= lastSource.x;
      p1.ypos -= lastSource.y;
    }
  } else {
    p1.isStaggered = false;
    canSlash = true;
  }
}

void invulCheck() {
  if (iTimer < millis() && p1.invulnerable == true) {
    p1.invulnerable = false;
  }
}

void startDodge() {
  timer =millis() + dLength; 
  dTimer = timer + 115;
  iTimer = millis() + 50;
  p1.invulnerable = true;
  isSlashing = false; 
  combo1 = false; 
  combo2 = false; 
  combo3 = false;
  click1 = false;
  click2 = false;
  click3 = false;
  cantMove = false;
}