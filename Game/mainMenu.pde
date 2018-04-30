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
    fill(255);
    textSize(20);
    text("Made by: Noah Caccamo, Jasper Tu, and Sam Gibson-Gamache", 530, height - 20);
    textSize(30);
    text("Highscore: " + highScore, width/2, 40);
  }
}
