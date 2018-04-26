class pickup { 
  float size;
  float xpos;
  float ypos;
int life;
int lifespan;
float scaleRatio = 1.5;

  Area hbox;

pickup(){}
  pickup(float _size, float _xpos, float _ypos) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
life = 0;
lifespan = 600;
  }

  void display() {
    fill(255, 155, 25);
    hbox = new Area(new Rectangle2D.Float(xpos - size/2, ypos -size/2, size, size));
    if(debug == true) {
    rect(xpos, ypos, size, size);
    }
    image(fullHeart, xpos, ypos, size*scaleRatio,size*scaleRatio);
    if (goTime == true) {
    life++;
    }
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
      score += pickupWorth;
      pickups.remove(i);
      break;
    } else {
    }
    getPickup.refresh();
    p1.refresh();
  }
}

class maxPickup extends pickup {
  
  float scaleRatio = 2.3;
  
  maxPickup(float _size, float _xpos, float _ypos) {
    size = _size;
    xpos = _xpos;
    ypos = _ypos;
  }
  
  void display() {
    fill(255, 155, 25);
    hbox = new Area(new Rectangle2D.Float(xpos - size/2, ypos -size/2, size, size));
    if(debug == true) {
    rect(xpos, ypos, size, size);
    }
    image(maxPotion, xpos, ypos, size*scaleRatio, size*scaleRatio);
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
      score += maxPickupWorth;
      maxPickups.remove(i);
      break;
    } else {
    }
    getPickup.refresh();
    p1.refresh();
  }
}
