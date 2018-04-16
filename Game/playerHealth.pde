PImage[] img = new PImage[11]; 

class playerHealth { 

  int hp;
  int frame = 10; // for image output

  playerHealth(int withinMax) {
    hp = withinMax;
    // load player health images
    for (int i=0; i < img.length; i++) {
      img[i] = loadImage("hp" + i + ".png");
      println("Loading " + "hp" + i + ".png");
    }
  }

  void loseHealth() {
    if (hp > 0) {
      hp = hp - 10;
      if (frameCount % 10 == 0) {
        if (frame > 0 && frame != 0) frame--;
      }
    }
  }

  void display() {
    image(img[frame], 0, 0);
  }
}