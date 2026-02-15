abstract class Alien extends Sprite {
    protected boolean delete = false;
    protected boolean isDying = false;
    protected int damageFlicker;

    public Alien(float x, float y) {
        super(x, y, 100, 100, RECT);
    }

    @Override
    public void draw() {
        if (damageFlicker > 0 && frameCount % 10 == 0) {
            animationFrameIndex = (++animationFrameIndex) % animationFrames[0].length;
            delete = (--damageFlicker == 0);
        }

        if (animationFrames != null && animationState < animationFrames.length && animationFrameIndex < animationFrames[0].length) {
        pushMatrix();
        translate(x,y);
        animationFrames[animationState][animationFrameIndex].resize((int) spriteWidth, (int) spriteWidth);
        image(animationFrames[animationState][animationFrameIndex], 0, 0);
        popMatrix();
        }
    }

    abstract void attack();

    public void takeDamge() {
        damageFlicker = 5;
    }

    public boolean checkIsDying() {
        return isDying;
    }

    public boolean checkDelete() {
        return delete;
    }
}

public class AlienOne extends Alien {
    private ArrayList<Bomb> bombs;
    public AlienOne(float x, float y, ArrayList<Bomb> bombs) {
        super(x, y);
        try {
            if (bombs == null) 
                throw new NullPointerException();
            this.bombs = bombs;
        } catch (NullPointerException exception) {
            exception.printStackTrace();
        }

        String assets[][] = {
            {
                "./assets/Aliens/Alien1.png",
                "./assets/Aliens/Alien2.png",
            }
        };
        loadFrames(assets);
    }

    @Override 
    public void attack() {
        if (frameCount % 30 == 0) {
            Bomb bomb = new Bomb(x, y);
            bomb.setVelocity(0, 5);
            bombs.add(bomb);
        }
    }
}

public class AlienTwo extends Alien {
    private ArrayList<Bullet> bullets;
    public AlienTwo(float x, float y, ArrayList<Bullet> bullets) {
        super(x, y);
        try {
            if (bullets == null) 
                throw new NullPointerException();
            this.bullets = bullets;
        } catch (NullPointerException exception) {
            exception.printStackTrace();
        }


        String assets[][] = {
            {
                "./assets/Aliens/Alien3.png",
                "./assets/Aliens/Alien4.png",
            }
        };
        loadFrames(assets);
    }

    @Override 
    public void attack() {
        if (frameCount % 30 == 0) {
            Bullet bullet = new Bullet(x, y);
            bullet.setVelocity(0, 10);
            bullets.add(bullet);
        }
    }
}