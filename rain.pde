class Rain {
  private int X1;
  private int X2;
  private int Y1;
  private int Y2;
  private int speed;

  public Rain(int a, int b, int c, int d, int s) {
    X1 = a;
    Y1 = b;
    X2 = c;
    Y2 = d;
    speed = s;
  }
  public void display() {
    stroke(#13589C, 1504);
    line(X1, Y1, X2, Y2);

    if (Y1 == 600) {
      Y1 = 0;
      Y2 = Y1 + 20;
    }

    if (X2 <= 0) {
      X1 = (int)random(0, 1700);
      X2 = X1 - 10;
      Y1 = 0;
      Y2 = Y1 + 20;
    }
  }

  public void shift() {
    X1 -= speed;
    Y1 += speed;
    X2 -= speed;
    Y2 += speed;
  }

  public void randomizeAndSet () {
    X1 = (int)random(0, 1700);
    X2 = X1 - 10;
    return;
  }
}