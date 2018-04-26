class Player {
  boolean[] keys =new boolean [4];
  float size;
  float xpos;
  float ypos;
  float mvspeed;
  Area hbox;
  int hp = 999;
  int maxHp = 999;
  boolean isStaggered;
  boolean invulnerable;
  int frame;
  float scaleRatio = 1.3;
  boolean animate;
  boolean lastU, lastR, lastL;
  boolean lastD = true;

  Player(float isize, float ixpos, float iypos, float imvspeed) {
    size = isize;
    xpos = ixpos;
    ypos = iypos;
    mvspeed = imvspeed;
  }

  void display() {
    fill(255, 0, 0);
    if (invulnerable == true) fill(0,0,255);
    if(debug == true) {
    rect(xpos, ypos, size, size);
    }
    animate();
    if (animate == true) {
      if (frameCount %5 ==0) frame++;
      if (frame>= playerFrames.length) frame = 0;
    }else {
     frame = 1; 
    }
    
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
      lastU = true;
      lastD = false; 
      lastR = false; 
      lastL = false;
    }

    if (key == 's' || key == 'S') {
      keys[1] = false;
      lastU = false;
      lastD = true; 
      lastR = false; 
      lastL = false;
    }

    if (key == 'a' || key == 'A') {
      keys[2] = false;
      lastU = false;
      lastD = false; 
      lastR = false; 
      lastL = true;
    }

    if (key == 'd' || key == 'D') {
      keys[3] = false;
      lastU = false;
      lastD = false; 
      lastR = true; 
      lastL = false;
    }
  }

void animate() {
    noTint();
    if (keys[0] == true && isSlashing == false) {
      animate = true;
      image(playerFramesUp[frame], xpos, ypos, size*scaleRatio, size*scaleRatio);
    } else if (keys[1] == true && isSlashing == false) {
      animate = true;
      image(playerFrames[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
    } else if (keys[2] == true && isSlashing == false) {
      animate = true;
      image(playerFramesLeft[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
    } else if (keys[3] == true && isSlashing == false) {
      animate = true;
      image(playerFramesRight[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
    } else {
      animate = false;
      if (lastU == true) {
        image(playerFramesUp[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
      } else if (lastD == true) {
        image(playerFrames[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
      } else if (lastR == true) {
        image(playerFramesRight[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
      } else if (lastL == true) {
        image(playerFramesLeft[frame], xpos, ypos,size*scaleRatio,size*scaleRatio);
      }
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

    //fill(255, 0, 0, trans);
    //rect(xpos, ypos, size, size);
    tint(255, trans);
    if (p1.keys[0] == true && isSlashing == false) {
      image(playerFramesUp[p1.frame], xpos, ypos, size*p1.scaleRatio, size*p1.scaleRatio);
    } else if (p1.keys[1] == true && isSlashing == false) {
      image(playerFrames[p1.frame], xpos, ypos,size*p1.scaleRatio,size*p1.scaleRatio);
    } else if (p1.keys[2] == true && isSlashing == false) {
      image(playerFramesLeft[p1.frame], xpos, ypos,size*p1.scaleRatio,size*p1.scaleRatio);
    } else if (p1.keys[3] == true && isSlashing == false) {
      image(playerFramesRight[p1.frame], xpos, ypos,size*p1.scaleRatio,size*p1.scaleRatio);
    }
    tint(255);
  }
}

void damage(PVector source, float force, int damage) {
  if (p1.invulnerable == false) {
    damageTaken++;
    score -= dmgPenalty;
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
      playMusic.stop();
      menuMusic.play();
    }
  }
}

void stagger() {

  if (sTimer > millis()) {
    dTimer = 0;
    canSlash = false;
    fill(255, 0, 255);
    if (debug == true) {
    rect(p1.xpos, p1.ypos, p1.size, p1.size);
    }
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
