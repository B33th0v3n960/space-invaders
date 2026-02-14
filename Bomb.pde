class Bomb extends Sprite {
  private boolean isTriggered = false;
  private boolean isExploding = false;
  private boolean isDeleted = false;
  private int counter = 0;
  private float velocity[] = {0.0, 0.0};

  public Bomb(float x, float y) {
    super(x, y, 100, 100, ELLIPSE);
    spriteWidth = 200;
    spriteHeight = 200;
    this.x = x;
    this.y = y;
    String assets[][] = {{
      "./assets/Bomb/bomb1.png",
      "./assets/Bomb/bomb2.png",
      "./assets/Bomb/bomb3.png",
      "./assets/Bomb/bomb4.png",
      "./assets/Bomb/bomb5.png",
      "./assets/Bomb/bomb6.png",
      "./assets/Bomb/bomb7.png",
      "./assets/Bomb/bomb8.png",
      "./assets/Bomb/bomb9.png",
      "./assets/Bomb/bomb10.png",
      "./assets/Bomb/bomb11.png",
    }};

    loadFrames(assets);
  }

  public void setVelocity(float dx, float dy) {
    velocity = new float[]{dx, dy};
  }

  public void move() {
    if (!isTriggered) {
      super.move(velocity[0], velocity[1]);
      animationFrameIndex = 0;
    } else {
      counter++;
      if (counter % 5 == 0 && animationFrameIndex < animationFrames[0].length) {
        animationFrameIndex++;
      }

      if (animationFrameIndex == 5)
        isExploding = true;

      if (animationFrameIndex >= animationFrames[0].length) {
        animationFrameIndex = animationFrames[0].length - 1;
        isDeleted = true;
      }
    }
  }

  public boolean checkIfExploding() {
    return isExploding;
  }

  public void trigger() {
    isTriggered = true;
    changeHitBox(ELLIPSE);
  }

  public boolean checkDeleted() {
    return isDeleted;
  }

  public float getExplosionRadius() {
    return spriteWidth/2;
  }
}
