class hitboxSlash {

  Rectangle r1;
  AffineTransform t1 = new AffineTransform();
  Area a1;
  float xpos = p1.xpos;
  float ypos = p1.ypos;

  hitboxSlash(int _rwidth, int _rheight) {
    slashNum += 1;
    int num = slashNum;
    int rwidth = _rwidth;
    int rheight = _rheight;

    r1 = new Rectangle(0, 0, rwidth, rheight);

    //r1.setFrameFromCenter(xpos, ypos, xpos + 50, ypos + 25);
    t1.translate(xpos, ypos);
    t1.rotate(mAngle);
    t1.translate(50, 0);
    t1.translate(-rwidth/2, -rheight/2);
    a1 = new Area(t1.createTransformedShape(r1));
  }
}