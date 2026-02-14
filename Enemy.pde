abstract class Alien extends Sprite {
    protected boolean delete = false;
    protected boolean isDying = false;

    public Alien(float x, float y) {
        super(x, y, 100, 100, RECT);
    }

    abstract void attack();

    public void die() {
        isDying = true;
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
        this.bombs = bombs;

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
    public AlienTwo(float x, float y) {
        super(x, y);

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
        if (frameCount == 0)
            System.out.println(this + " is attacking");
    }
}