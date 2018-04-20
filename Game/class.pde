

class projectile {
  PVector  velocity, acceleration;
  float topspeed;
  PVector mouse;
  PVector position;
  PVector projectileVec;
  Area hbox;
  float size;
  color c;
  float reflectedSpeed;

  projectile() {
    mouse = new PVector(mouseX, mouseY);
    position = new PVector(p1.xpos, p1.ypos);
    projectileVec = new PVector(p1.xpos - mouseX, p1.ypos - mouseY);

    size = 10;
    c = color(255, 24, 0);

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
      if (goTime == true) {
    position.x -= projectileVec.x;
    position.y -= projectileVec.y;
      }
  }

  void display() {
    hbox = new Area(new Ellipse2D.Float(position.x - size/2, position.y-size/2, size, size));
    fill(c);
    ellipse(position.x, position.y, size, size);
  }

  void refresh() {
    hbox = new Area(new Ellipse2D.Float(position.x - size/2, position.y-size/2, size, size));
  }
  
}

class enemyProjectile extends projectile {

  float speed;
  boolean canSlash;
  
  enemyProjectile(PVector _enemyPos, float _speed, boolean _canSlash) {

    speed = _speed;
    canSlash = _canSlash;
    
    c = color(142, 12, 157);

    float xenemy = _enemyPos.x;
    float yenemy = _enemyPos.y;
    position = new PVector(xenemy, yenemy);
    projectileVec = new PVector(xenemy - p1.xpos, yenemy - p1.ypos);

    projectileVec.setMag(speed);
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

  int life = millis() + 50;
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
