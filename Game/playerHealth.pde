// array of images for health bar
PImage[] img = new PImage[11]; 

class playerHealth { 

  int hp; // player health value
  int frame = 10; // for image output

  // health bar constructor that accepts an integer for player health
  playerHealth(int withinMax) {
    hp = withinMax;
    // load player health images into game
    for (int i=0; i < img.length; i++) {
      img[i] = loadImage("hp" + i + ".png");
      println("Loading " + "hp" + i + ".png");
    }
  }

  // decrease HP integer and index of PImage array
  void loseHealth() {
    if (hp > 0) {
      hp = hp - 10;
      if (frameCount % 10 == 0) {
        if (frame > 0 && frame != 0) frame--;
      }
    }
  }

  // reset image frame for PImage array if player dies
  void resetFrame() {
    frame = 10;
  }

  // display health bar images 
  void display() {
    image(img[frame], 0, 0);
  }
}