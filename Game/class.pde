

class projectile {
  PVector  velocity, acceleration;
  float topspeed;
  PVector mouse = new PVector(mouseX, mouseY);
  PVector position = new PVector(p1.xpos, p1.ypos);
  PVector projectileVec = new PVector(p1.xpos - mouseX, p1.ypos - mouseY);

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
    ellipse(position.x, position.y, 10, 10);
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
    translate(plx, ply);
    rotate(angle);
    translate(50, 0);
    fill(c);
    rect(0, 0, bwidth, bheight);
    popMatrix();
  }
}


///////////
void startDodge() {
  timer =millis() + dLength; 
  dTimer = timer + 115;
  isSlashing = false; 
  combo1 = false; 
  combo2 = false; 
  combo3 = false;
  click1 = false;
  click2 = false;
  click3 = false;
  cantMove = false;
}
