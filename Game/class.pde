class Player {
  boolean[] keys =new boolean [4];
  float size;
  float xpos;
  float ypos;
  float mvspeed;

  Player(float isize, float ixpos, float iypos, float imvspeed) {
    size = isize;
    xpos = ixpos;
    ypos = iypos;
    mvspeed = imvspeed;
  }

  void display() {
    fill(255, 0, 0);
    rect(xpos, ypos, 40, 40);
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

    if (keys[0] == true) {
      ypos -= mvspeed;
    }


    if (keys[1] == true) {
      ypos += mvspeed;
    }


    if (keys[2] == true) {
      xpos -= mvspeed;
    }

    if (keys[3] == true) {
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
    
    fill(255, 0,0, trans);
   rect(xpos, ypos, size, size);
  }
  
}

class projectile {
  PVector  velocity, acceleration;
  float topspeed;
  PVector mouse = new PVector(mouseX, mouseY);
  PVector position = new PVector(p1.xpos, p1.ypos);
  PVector projectileVec = new PVector(p1.xpos - mouseX, p1.ypos - mouseY);
  
  projectile() {
   
   velocity = new PVector(0,0);
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

class comType{
  boolean done;
  comType(){
    done = false;
  }
  
}

class combo1 extends comType{
   
  void run(){
    
  };
  
}

class combo2 extends comType{
   void run(){
    
  };
  
}

class combo3 extends comType{
   void run(){
    
     
     done = true;
  };
  
}


class commands {
  
  ArrayList<comType> commands = new ArrayList <comType>();
  
  void add(int id){
    if(id == 1){
      commands.add(new combo1());
    }else if (id == 2){
      commands.add(new combo2());
    }else{
      commands.add(new combo3());
    }
  }
  void removeHead(){
    commands.remove(0);
    
  }

}



///////////
void startDodge() {
 timer =millis() + dLength; 
 dTimer = timer + 300;

}