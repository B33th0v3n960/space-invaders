class Player extends Sprite {
  private int health = 5;
  private int iframe = 0;
  private ArrayList<Heart> hearts;

  public Player(float x, float y, ArrayList<Heart> hearts) {
    super(x, y, 100, 100, RECT);
    try {
      if (hearts== null) 
        throw new NullPointerException();
      this.hearts = hearts;
    } catch (NullPointerException exception) {
      exception.printStackTrace();
    }

    String assets[][] = {
      {
        "./assets/Player/Spaceship1.png",
        "./assets/Player/Spaceship2.png",
      },
      {
        "./assets/Player/Spaceship3.png",
        "./assets/Player/Spaceship4.png",
      },
      {
        "./assets/Player/Spaceship5.png",
        "./assets/Player/Spaceship6.png",
      },
    };

    animationFrames = new PImage[assets.length][assets[0].length];

    for (int state = 0; state < animationFrames.length; state++) {
      for (int frame = 0; frame < animationFrames[state].length; frame++)
        animationFrames[state][frame] = loadImage(assets[state][frame]);
    }
  }

  public void chageState() {
    animationState = (++animationState) % 3;
  }

  @Override
  public void draw() {
    if (animationFrames != null && animationState < animationFrames.length && animationFrameIndex < animationFrames[0].length) {
      if (iframe > 0) {
        if (frameCount % 10 == 0)
          animationFrameIndex = (++animationFrameIndex) % 2;
        iframe--;
      } else {
        animationFrameIndex = 0;
      }

      pushMatrix();
      translate(x,y);
      animationFrames[animationState][animationFrameIndex].resize((int) spriteWidth, (int) spriteWidth);
      image(animationFrames[animationState][animationFrameIndex], 0, 0);
      popMatrix();
    }
  }

  public void takeDamge() {
    if (iframe <= 0) {
      health -= 1;
      iframe = 50;
      hearts.remove(hearts.size() - 1);
    }
  }

  public int getHealth() {
    return health;
  }
}
