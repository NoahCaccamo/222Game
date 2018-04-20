class tripleRangedEnemy extends basicRangedEnemy{ //just make this one a recolour of the basic ranged enemy sprite



  tripleRangedEnemy(float _size, float _xpos, float _ypos, float _mvspeed) {

    size = _size;
    xpos = _xpos;
    ypos = _ypos;
    mvspeed = _mvspeed;
    position = new PVector(xpos, ypos);
    hp = 12;
    shootTimer = 0;
  }


  void shoot() {
    enemyProjectiles.add(new enemyProjectile(position, 5, true, 0, false));
    enemyProjectiles.add(new enemyProjectile(position, 5, true, PI/7, true));
    enemyProjectiles.add(new enemyProjectile(position, 5, true, -PI/7, true));
  }
}
