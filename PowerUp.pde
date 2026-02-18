public class PowerUp extends Sprite {
  private float velocity[] = {0.0, 0.0};
  private int type = 0;

  public PowerUp(float x, float y) {
    super(x, y, 100, 100, ELLIPSE);
    spriteWidth = 100;
    spriteHeight = 100;
    this.x = x;
    this.y = y;
    this.type = int(random(0,3));
    this.animationFrameIndex = type;
    String assets[][] = {{
      "./assets/PowerUp/PowerUp1.png",
      "./assets/PowerUp/PowerUp2.png",
      "./assets/PowerUp/PowerUp3.png",
    }};

    loadFrames(assets);
  }

  public void setVelocity(float dx, float dy) {
    velocity = new float[]{dx, dy};
  }

  public void move() {
      super.move(velocity[0], velocity[1]);
  }

  public int getType() {
    return type;
  }
}