class Obstacle {
  private int startXPos;
  private int groundYPos;
  private int xHeight;
  private int yWidth;

  public Obstacle(int x, int y, int w, int h) {
    startXPos = x;
    groundYPos = y;
    xHeight = h;
    yWidth = w;
  }

  public void display() {
    fill(255);
    rect(startXPos, groundYPos, xHeight, yWidth);
    startXPos -= speed;
  }

  public float getObstacleTop() {
    return groundYPos- 25;
  }
  public float getObstacleLeft() {
    return startXPos - 25;
  }
  public float getObstacleRight() {
    return startXPos + 25;
  }
}