class Background {
  private int xPosOne;
  private int xPosTwo;
  private int selector;


  public Background(int x, int y, int i) {
    xPosOne = x;
    xPosTwo = y;
    selector = i;
  }

  public void display() {
    if (selector == 1) {
      image(shadowOne, xPosOne, -50);
      image(shadowTwo, xPosTwo, -50);

      image(mainOne, xPosOne, 0);
      image(mainTwo, xPosTwo, 0);

      image(streetOne, xPosOne, 300);
      image(streetTwo, xPosTwo, 300);

      xPosOne -= speed;
      xPosTwo -= speed;

      println(xPosOne, xPosTwo);
      if (xPosOne < -1200) {
        xPosOne = min(1185, 1185);
      }
      if (xPosTwo < -1200) {
        xPosTwo = min(1185, 1185);
      }
    }
  }
}