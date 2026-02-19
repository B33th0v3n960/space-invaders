public class ShieldUnit extends Sprite {
    public ShieldUnit(float x, float y) {
        super(x, y, 50, 50, ELLIPSE);
        spriteWidth = 50;
        spriteHeight = 50;
        this.x = x;
        this.y = y;
        String assets[][] = {{
        "./assets/Shield/Shield.png",
        }};

        loadFrames(assets);
    }
}

public class Shield {
    ShieldUnit[][] shieldUnits = new ShieldUnit[4][8];
    public Shield(float x, float y) {
        for (int row = 0; row < shieldUnits.length; row++) {
            for (int col = 0; col < shieldUnits[row].length; col++) {
                float shieldWidth = 50;
                float shieldHeight = 50;
                shieldUnits[row][col] = new ShieldUnit(x + col * shieldWidth, y + row * shieldHeight);
            }
        }
    }

    public void draw() {
        for (int row = 0; row < shieldUnits.length; row++) {
            for (int col = 0; col < shieldUnits[row].length; col++) {
                if (shieldUnits[row][col] != null)
                    shieldUnits[row][col].draw();
            }
        }
    }

    public boolean collidesWith(Bullet bullet) {
        for (int row = 0; row < shieldUnits.length; row++) {
            for (int col = 0; col < shieldUnits[row].length; col++) {
                if (shieldUnits[row][col] != null)  {
                    if (shieldUnits[row][col].collidesWith(bullet)) {
                        shieldUnits[row][col] = null;
                        return true;
                    }
                }
            }
        }
        return false;
    }

    public boolean collidesWith(Sprite projectile) {
        for (int row = 0; row < shieldUnits.length; row++) {
            for (int col = 0; col < shieldUnits[row].length; col++) {
                if (shieldUnits[row][col] != null)  {
                    if (shieldUnits[row][col].collidesWith(projectile)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}