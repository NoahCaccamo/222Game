PImage controlMenu; // obj variable for graphic

class controlMenu {

  // constructor
  controlMenu() {
    controlMenu = loadImage("2_controls_900.jpg"); // load graphic into obj variable
  }

  // display graphic
  void display() {
    image(controlMenu, 0, 0);
  }
}