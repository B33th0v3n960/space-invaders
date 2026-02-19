class Laser extends Sprite {
  private float velocity[] = {0.0, 0.0};
  private int damage = 1;
  private int variant = 0;

  public Laser(float x, float y) {
    super(x, y, 20, 100, ELLIPSE);
    spriteWidth = 100;
    spriteHeight = 100;
    this.x = x;
    this.y = y;
    String assets[][] = {{
      "./assets/Laser/Laser1.png",
      "./assets/Laser/Laser2.png",
    }};

    loadFrames(assets);
  }
  
  public Laser(float x, float y, int variant) {
    this(x, y);
    this.variant = variant % 2;
    animationFrameIndex = variant % 2;
  }

  public void setVelocity(float dx, float dy) {
    velocity = new float[]{dx, dy};
  }

  public void move() {
      super.move(velocity[0], velocity[1]);
  }

  public void setDamage(int damage) {
    this.damage = damage;
  }
  
  public int getDamage() {
    return damage;
  }

  public int getVariant() {
    return variant;
  }
}