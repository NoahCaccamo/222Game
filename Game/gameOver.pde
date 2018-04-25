PImage gameOver; // obj variable for graphic

class gameOver {

  // constructor
  gameOver() {
    //gameOver = loadImage("4_game_over_900.jpg"); // load graphic into obj variable
    gameOver = loadImage("game_over.jpg"); // load graphic into obj variable
  }

  // display graphic
  void display() {
    gameOver.resize(width, height);
    image(gameOver, 0, 0);
  }
}