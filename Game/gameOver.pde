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
    image(gameOver, width/2, height/2);
    fill(255);
    textSize(48);
    text(score + " points", (width/4)*3.10, (height/4)*3.10);    
    if(newScore == true){
      textSize(28);
      fill(222, 255,1);
      text("NEW BEST", width/4*3.13, height/4*2.42);
    }
    text("Highscore: " + highScore, width/4*2.66, height/4*3.90);
  }
}
