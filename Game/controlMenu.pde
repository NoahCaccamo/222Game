PImage controlMenu;

class controlMenu {
  controlMenu() {
    controlMenu = loadImage("2_controls_900.jpg");
  }
  
  void display() {
    image(controlMenu, 0, 0);
  }
}