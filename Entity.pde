class Sprite {
  private CollisionBody collisionBody;
  // Collision resolution strategy class working in progress
  // private CollisionResolve resolution;
  
  protected float x;
  protected float y;
  protected float spriteWidth;
  protected float spriteHeight;

  protected PImage animationFrames[][];
  protected int animationState = 0;
  protected int animationFrameIndex = 0;

  public Sprite(float x, float y, float width, float height, int collisionBodyType) {
    this.x = x;
    this.y = y;
    this.spriteWidth = width;
    this.spriteHeight = height;

    collisionBody = new CollisionBody();
    switch(collisionBodyType) {
    case RECT:
      this.collisionBody.collisionShape = new Rectangle(x, y, width, height, #cdd3dd);
      this.collisionBody.collider = new RectCollider((Rectangle) collisionBody.collisionShape);
      break;
    case ELLIPSE:
      this.collisionBody.collisionShape = new Ellipse(x, y, width, height, #cdd3dd);
      this.collisionBody.collider = new EllipseCollider((Ellipse) collisionBody.collisionShape);
      break;
    }
  }

  protected void changeHitBox(int collisionBodyType) {
    switch(collisionBodyType) {
    case RECT:
      this.collisionBody.collisionShape = new Rectangle(x, y, spriteWidth, spriteHeight, #cdd3dd);
      this.collisionBody.collider = new RectCollider((Rectangle) collisionBody.collisionShape);
      break;
    case ELLIPSE:
      this.collisionBody.collisionShape = new Ellipse(x, y, spriteWidth, spriteHeight, #cdd3dd);
      this.collisionBody.collider = new EllipseCollider((Ellipse) collisionBody.collisionShape);
      break;
    }
  }

  protected void loadFrames(String[][] assets) {
    if (assets != null) {
        animationFrames = new PImage[assets.length][assets[0].length];

        for (int state = 0; state < animationFrames.length; state++) {
            for (int frame = 0; frame < animationFrames[state].length; frame++)
                animationFrames[state][frame] = loadImage(assets[state][frame]);
        }
    }
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public void drawHitBox() {
    collisionBody.showCollisionBody();
  }

  public void draw() {
    if (animationFrames != null && animationState < animationFrames.length && animationFrameIndex < animationFrames[0].length) {
      pushMatrix();
      translate(x,y);
      animationFrames[animationState][animationFrameIndex].resize((int) spriteWidth, (int) spriteWidth);
      // scale(1, 1);
      image(animationFrames[animationState][animationFrameIndex], 0, 0);
      popMatrix();
    }
  }

  public void turn(float dTheta) {
    collisionBody.updateCollisionBody(0, 0, dTheta);
  }

  public void move(float dx, float dy) {
    this.x += dx;
    this.y += dy;
    collisionBody.updateCollisionBody(dx, dy, 0);
  }

  public void move(float dx, float dy, float dTheta) {
    this.x += dx;
    this.y += dy;
    collisionBody.updateCollisionBody(dx, dy, dTheta);
  }

  public boolean collidesWith(Sprite other) {
    if (other == null)
      return false;
    boolean isColliding = collisionBody.collidesWith(other.collisionBody);
    return isColliding;
  }
}
