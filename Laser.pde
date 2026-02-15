class Laser extends Sprite {
  private float velocity[] = {0.0, 0.0};

  public Laser(float x, float y) {
    super(x, y, 100, 100, ELLIPSE);
    spriteWidth = 100;
    spriteHeight = 100;
    this.x = x;
    this.y = y;
    String assets[][] = {{
      "./assets/Laser/Laser.png",
    }};

    loadFrames(assets);
  }

  public void setVelocity(float dx, float dy) {
    velocity = new float[]{dx, dy};
  }

  public void move() {
      super.move(velocity[0], velocity[1]);
  }
}