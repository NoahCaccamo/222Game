void intro() {
  background(0); 
  fill(255); 
  textSize(48); 
  textAlign(CENTER, BOTTOM); 
  text("START\nGAME", width/2, height/2); 
}
  
void runGame () {
  p1.move();
  p1.display();
  p1.animate();
  e1.move();
  e1.display();
  e1.animate();
}