PImage buttonPlay;
boolean hover = false;

class buttonPlay {

  buttonPlay() {
    buttonPlay = loadImage("play_button.png");
  }

  void display() {
    image(buttonPlay, 250, 250);

    //if (bP.hoverOver()) {
    //  hover = true;
    //  tint(0, 153, 204, 126);
    //}
    //hover = false;
  }

  boolean hoverOver() {
    if ((mouseX >= 400 && mouseX <= 510) && (mouseY >= 450 && mouseY <= 510)) {
      return true;
    } else {
      return false;
    }

    //if ((mouseX >= 400 && mouseX <= 510) && (mouseY >= 750 && mouseY <= 810)) {
    //  return true;
    //}
  }
}