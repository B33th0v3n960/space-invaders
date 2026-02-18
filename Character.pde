class Player extends Sprite {
  private int health = 10;
  private int score = 0;
  private int iframe = 0;

  private final int FULL_AMMO = 10;
  private int ammunition = FULL_AMMO;
  private int attackCounter = 0;
  private int damage = 1;

  private ArrayList<Heart> hearts;
  private ArrayList<Laser> lasers;

  private int boostCounter = 0;
  private int boostMode = 0;
  private int ammoBoost = 1;
  private int speedBoost = 1;
  private int damageBoost = 1;

  public Player(float x, float y, ArrayList<Heart> hearts, ArrayList<Laser> lasers) {
    super(x, y, 100, 100, RECT);
    try {
      if (hearts == null || lasers == null) 
        throw new NullPointerException();
      this.lasers = lasers;
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
    if (boostCounter > 0) {
      boostCounter--;
      animationState = boostMode;
    } else {
      animationState = boostMode = 0;
      speedBoost = 1;
      ammoBoost = 1;
      ammunition = (ammunition > FULL_AMMO)? FULL_AMMO: ammunition;
    }
    if (frameCount % 50 == 0 && ammunition < ammoBoost * FULL_AMMO)
      ammunition++;
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

  @Override
  public void move(float dx, float dy) {
    super.move(speedBoost * dx, speedBoost * dy);
  }

  public void startAttack() {
    attackCounter = 0;
  }

  public void attack() {
    if (ammunition > 0 && attackCounter++ % 10 == 0) {
      Laser laser = new Laser(x, y - 100);
      laser.setVelocity(0, -20);
      laser.setDamage(damage * damageBoost);
      lasers.add(laser);
      ammunition--;
    }
  }

  public void takeDamge() {
    if (iframe <= 0) {
      health -= 1;
      iframe = 50;
      hearts.get(hearts.size() - 1).takeDamge();
    }
  }

  public void takeDoubleDamage() {
    if (iframe <= 0) {
      health -= 2;
      iframe = 50;
      if (hearts.get(hearts.size() -1).checkHalfHeart() && hearts.size() > 2) {
          hearts.get(hearts.size() -1).takeDamge();
          hearts.get(hearts.size() -2).takeDamge();
      } else {
        hearts.get(hearts.size() - 1).takeDoubleDamage();
      }
    }
  }

  public int getHealth() {
    return health;
  }

  public void increaseScore(int increment) {
    if (increment > 0)
      score += increment;
  }

  public void decreaseScore(int decrement) {
    if (decrement > 0 && score > decrement)
      score -= decrement;
    else if (score < decrement)
      score = 0;
  }

  public int getScore() {
    return score;
  }

  public int getAmmunition() {
    return ammunition;
  }

  public void boost(int boostType) {
    boostCounter = 600;
    boostMode = boostType % 3;
    switch (boostType) {
      case 0:
        ammoBoost = 2;
        ammunition += 10;
        speedBoost = 1;
        damageBoost = 1;
        break;
      case 1:
        speedBoost = 4;
        damageBoost = 1;
        ammoBoost = 1;
        break;
      case 2:
        damageBoost = 3;
        speedBoost = 1;
        ammoBoost = 1;
      default:
    }
  }
}
