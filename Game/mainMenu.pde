PImage mainMenu;

class mainMenu {
  mainMenu() {
    mainMenu = loadImage("1_main_menu_2.jpg");
   //surface.setSize(mainMenu.width, mainMenu.height); 
  }
  
  void display() {
    image(mainMenu, 0, 0);
  }
}