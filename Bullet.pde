class Bullet extends Sprite {
  private float velocity[] = {0.0, 0.0};

  public Bullet(float x, float y) {
    super(x, y, 100, 100, ELLIPSE);
    spriteWidth = 100;
    spriteHeight = 100;
    this.x = x;
    this.y = y;
    String assets[][] = {{
      "./assets/Disk/Spinning-Disk1.png",
      "./assets/Disk/Spinning-Disk2.png",
      "./assets/Disk/Spinning-Disk3.png",
      "./assets/Disk/Spinning-Disk4.png",
    }};

    loadFrames(assets);
  }

  public void setVelocity(float dx, float dy) {
    velocity = new float[]{dx, dy};
  }

  public void move() {
      super.move(velocity[0], velocity[1]);
      if (frameCount % 20 == 0)
        animationFrameIndex = (++animationFrameIndex) % 4;
  }
}
