PImage mainMenu; // obj variable for main menu graphic

class mainMenu {

  // constructor
  mainMenu() {
    mainMenu = loadImage("1_main_menu_2.jpg"); // load main menu graphic into obj variable
    //surface.setSize(mainMenu.width, mainMenu.height);
  }

  // displays main menu graphic
  void display() {
    image(mainMenu, 0, 0);
  }
}