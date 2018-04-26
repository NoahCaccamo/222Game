PImage mainMenu; // obj variable for main menu graphic

class mainMenu {

  // constructor
  mainMenu() {
    mainMenu = loadImage("main_menu.jpg"); // load main menu graphic into obj variable
  }

  // displays main menu graphic
  void display() {
    mainMenu.resize(width, height);
    image(mainMenu, width/2, height/2);
  }
}