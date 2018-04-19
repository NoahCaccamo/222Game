class Enemy { 

  // fields 
  int frame = 0;  // our current frame 
  int flip = 1;   // our direction we're facing 

  float x;
  float y; 

  float speedX;
  float speedY;

  float radius = 25; 

  // constructor 
  Enemy () {
    x = random(width);
    y = random(height);
    speedX = random(-2, 2); 
    speedY = random(-2, 2);
  }

  // methods
  void move() {
    x += speedX;
    y += speedY; 
    if (x < 0 || x > width) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1; 
    if (speedX > 0) flip = 1;  // facing right 
    if (speedX < 0) flip = -1; // facing left
    }

 void animate() {
   int frame = 0;
    // animate the player 
    // we want to increase the frame counter every 4 frames
    if (frameCount % 4 == 0) frame++;   
    if (frame >= enemyFrames.length) frame = 0;
  }

  void display() {
    // draw the player 
    pushMatrix(); // save the origin 
    translate(x, y); 
    scale(flip, 1);
    scale (1.2,1);
    image(enemyFrames[frame], 0, 0);
    popMatrix();  // restore the origin
     if (frameCount %5 ==0) frame++;
    if (frame>= enemyFrames.length) frame = 0;
  }
}