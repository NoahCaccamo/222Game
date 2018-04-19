class Player {
  boolean[] keys =new boolean [4];
  float size;
  float xpos;
  float ypos;
  float mvspeed;
  int frame;
  
  float prevXpos;
  float prevYpos;
  
  Player(float isize, float ixpos, float iypos, float imvspeed) {
    frame = 0;
    size = isize;
    xpos = ixpos;
    ypos = iypos;
    mvspeed = imvspeed;
  }

  void display() {
    //Animate
    if (p1Animate == true) {
    if (frameCount %5 ==0) frame++;
    if (frame>= playerFrames.length) frame = 0;
    }
  }

  void keysCheckP() {

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
      lastU = true;lastD = false; lastR = false; lastL = false;
    }

    if (key == 's' || key == 'S') {
      keys[1] = false;
      lastU = false;lastD = true; lastR = false; lastL = false;
    }

    if (key == 'a' || key == 'A') {
      keys[2] = false;
      lastU = false;lastD = false; lastR = false; lastL = true;
    }

    if (key == 'd' || key == 'D') {
      keys[3] = false;
      lastU = false;lastD = false; lastR = true; lastL = false;
    }
  }



  void move() {

    prevXpos = xpos;
    prevYpos = ypos;
    
    if (keys[0] == true && isSlashing == false) {
      ypos -= mvspeed;
  
    }

    if (keys[1] == true && isSlashing == false) {
      ypos += mvspeed;
 
    }


    if (keys[2] == true && isSlashing == false) {
      xpos -= mvspeed;

    }

    if (keys[3] == true && isSlashing == false) {
      xpos += mvspeed;
   
    }
    
    // check for walls
    loadPixels();
    if ( get((int)xpos, (int)ypos) == color(96.5, 85.9, 53.7) ) {
      xpos = prevXpos;
      ypos = prevYpos;
    }
  }
  
  void animate() {
    noTint();
    if (keys[0] == true && isSlashing == false) {
      p1Animate = true;
      image(playerFramesUp[frame], xpos, ypos);
    }

    else if (keys[1] == true && isSlashing == false) {
      p1Animate = true;
      image(playerFrames[frame], xpos, ypos);
    }


    else if (keys[2] == true && isSlashing == false) {
      p1Animate = true;
      image(playerFramesLeft[frame], xpos, ypos);
    }

    else if (keys[3] == true && isSlashing == false) {
      p1Animate = true;
      image(playerFramesRight[frame], xpos, ypos);
    }
    else {
     p1Animate = false;
      if (lastU == true) {
        image(playerFramesUp[frame], xpos, ypos);
      }else if (lastD == true) {
        image(playerFrames[frame], xpos, ypos);
      }else if (lastR == true) {
        image(playerFramesRight[frame], xpos, ypos);
      }else if (lastL == true) {
        image(playerFramesLeft[frame], xpos, ypos);
      }
      
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
  int frame = 0;

  fadePlayer(float isize, float ixpos, float iypos, int itimer) {
    size = isize;
    xpos = ixpos;
    ypos = iypos;
    timer = itimer;
    frame = 0;
  }
  void fade() {
    trans -= 40;
  }

  void display() {
    fill(255, 0, 0);
    pushMatrix();
    tint(255, trans);
    image(playerFrames[frame], xpos, ypos);

    popMatrix();
    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= playerFrames.length) frame = 0;
  }
}

class projectile {
  PVector  velocity, acceleration;
  float topspeed;
  PVector mouse = new PVector(mouseX, mouseY);
  PVector position = new PVector(p1.xpos, p1.ypos);
  PVector projectileVec = new PVector(p1.xpos - mouseX, p1.ypos - mouseY);
  int frame;

  projectile() {

    velocity = new PVector(0, 0);
    topspeed = 40;

    mouse.sub(position);
    mouse.normalize();
    mouse.mult(3000);

    projectileVec.normalize();
    projectileVec.mult(10);
  }
  void update() {

    //PVector acceleration = PVector.sub(mouse, position);
    //acceleration.setMag(0.2);

    //velocity.add(acceleration);

    // velocity.limit(topspeed);
    //velocity.setMag(0.2);
    //position.add(velocity);
    position.x -= projectileVec.x;
    position.y -= projectileVec.y;
  }

  void display() {
    fill(255, 0, 0);
    pushMatrix();
    image(magicFrames[frame], position.x, position.y);
    popMatrix();

    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= magicFrames.length) frame = 0;
  }
}
//new comType(6)

class comType {
  boolean done;
  comType() {
    done = false;
  }
}

class combo1 extends comType {

  void run() {
  };
}

class combo2 extends comType {
  void run() {
  };
}

class combo3 extends comType {
  void run() {


    done = true;
  };
}


class commands {

  ArrayList<comType> commands = new ArrayList <comType>();

  void add(int id) {
    if (id == 1) {
      commands.add(new combo1());
    } else if (id == 2) {
      commands.add(new combo2());
    } else {
      commands.add(new combo3());
    }
  }
  void removeHead() {
    commands.remove(0);
  }
}

class slashBox {
  float bwidth = 50;
  float bheight = 100;
  float xpos;
  float ypos;
  float angle;

  float plx;
  float ply;

  int frame;

  int life = millis() + 100;
  color c;

  slashBox(color bc) {

    c = bc;

    mAngle = atan2(mouseY-p1.ypos, mouseX - p1.xpos);

    if (mAngle < 0) {
      mAngle += TWO_PI;
    }
    angle = mAngle;

    pushMatrix();
    translate(p1.xpos, p1.ypos);
    rotate(mAngle);
    translate(50, 0);

    xpos = screenX(0, 0);
    ypos = screenY(0, 0);

    plx = p1.xpos;
    ply = p1.ypos;

    popMatrix();
  }

  void display() {
    pushMatrix();
    fill(c);
    translate(plx, ply);
    rotate(angle);
    translate(50, 0);
    image(meleeFrames[frame], 0, 0);
    popMatrix();

    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= meleeFrames.length) frame = 0;
  }
}


///////////
void startDodge() {
  timer =millis() + dLength; 
  dTimer = timer + 300;
  isSlashing = false; 
  combo1 = false; 
  combo2 = false; 
  combo3 = false;
  click1 = false;
  click2 = false;
  click3 = false;
}