class tripleRangedEnemy extends basicRangedEnemy{ //just make this one a recolour of the basic ranged enemy sprite

float scaleRatio = 1.3; 

  tripleRangedEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {

    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 12;
    shootTimer = 0;
  }

void display() {

    if (canMoveTimer < millis()) {
      canMove = true;
    }
    if(flashTimer < millis()) {
     tint = false; 
    }
    if (shootTimer >= 120) {
      shoot(); 
      shootTimer = 0;
    }

    player = new PVector(p1.xpos, p1.ypos);
    towardPlayer = new PVector(position.x - player.x, position.y - player.y);
    towardPlayer.setMag(0.5);

if (goTime == true) {
    position.x -= towardPlayer.x;
    position.y -= towardPlayer.y;
shootTimer ++;
}

    fill(0, 255, 255);
    hbox = new Area(new Rectangle2D.Float(position.x - size/2, position.y -size/2, size, size));
    if(debug == true){
    rect(position.x, position.y, size, size);
    }
    //anim
    if(tint == true) tint(255,0,0);
    if (towardPlayer.x >= 0) {
      image(tripleranged[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }
    else {
      image(triplerangedflip[frame], position.x, position.y, size*scaleRatio, size*scaleRatio);
    }
    if (goTime == true) {
    //Animate
    if (frameCount %5 ==0) frame++;
    if (frame>= dragon.length) frame = 0;
    }
    noTint();
  }


  void shoot() {
    enemyProjectiles.add(new enemyProjectile(10, position, 5, true, 0, false));
    enemyProjectiles.add(new enemyProjectile(10, position, 5, true, PI/7, true));
    enemyProjectiles.add(new enemyProjectile(10, position, 5, true, -PI/7, true));
  }
}
