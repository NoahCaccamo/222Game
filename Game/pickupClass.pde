class pickup { 
  float size;
  float xpos;
  float ypos;
int life;

  Area hbox;

pickup(){}
  pickup(float _size, float _xpos, float _ypos) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
life = millis() + 10000;
  }

  void display() {
    fill(255, 155, 25);
    hbox = new Area(new Rectangle2D.Float(xpos - size/2, ypos -size/2, size, size));
    rect(xpos, ypos, size, size);
  }


  void refresh() {
    hbox = new Area(new Rectangle2D.Float(xpos - size/2, ypos -size/2, size, size));
  }

}

void collidePickup() {
   for (int i=0; i < pickups.size(); i++) {
    pickup getPickup = pickups.get(i);


    getPickup.hbox.intersect(p1.hbox); 

    if (getPickup.hbox.isEmpty() == false) {
      //HEAL PLAYER
      if (p1.hp < p1.maxHp) {
      p1.hp ++;
      }
      pickups.remove(i);
      break;
    } else {
    }
    getPickup.refresh();
    p1.refresh();
  }
}

class maxPickup extends pickup {
  
  maxPickup(float _size, float _xpos, float _ypos) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
  }
  
}

void collideMaxPickup() {
   for (int i=0; i < maxPickups.size(); i++) {
    maxPickup getPickup = maxPickups.get(i);


    getPickup.hbox.intersect(p1.hbox); 

    if (getPickup.hbox.isEmpty() == false) {
      //HEAL PLAYER
      p1.maxHp ++;
      p1.hp ++;
      maxPickups.remove(i);
      break;
    } else {
    }
    getPickup.refresh();
    p1.refresh();
  }
}
