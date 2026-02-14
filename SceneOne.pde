class SceneOne implements Scene {
    private Player player;
    private Alien[][] enemy;
    private ArrayList<Bomb> bombs = new ArrayList<>();
    private ArrayList<Bullet> bullets = new ArrayList<>();
    private int alienDirection = 1;
    private float alienSpeed = 5;
    private float alienLeftBound;
    private float alienRightBound;

    public SceneOne() {
        player = new Player(width/2, height - 100);
        enemy = new Alien[4][5];
        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                float xCoordinate = width/2 - 500 + col * 200;
                float yCoordinate = 100 + row * 200;
                if (random(1,100) > 50)
                    enemy[row][col] = new AlienOne(xCoordinate, yCoordinate, bombs);
                else 
                    enemy[row][col] = new AlienTwo(xCoordinate, yCoordinate, bullets);
            } 
        }
    }

    public void update() {
        if (keyPressed) {
            if (keyInputs.get("left"))
                player.move(-5, 0);
            if (keyInputs.get("right"))
                player.move(5,0);
        }

        alienLeftBound = alienRightBound = width / 2;
        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                Alien alien = enemy[row][col];
                alienLeftBound = (alien.getX() < alienLeftBound)? alien.getX(): alienLeftBound;
                alienRightBound = (alien.getX() + alien.getWidth() > alienRightBound)? alien.getX() + alien.getWidth(): alienRightBound;
                if (alienLeftBound < 100)
                    alienDirection = 1;
                if (alienRightBound > width - 100) 
                    alienDirection = -1;
                alien.move(alienDirection * alienSpeed, 0);
                if (random(1, 100) > 95)
                    alien.attack();
            }
        }

        for (int bombIndex = 0; bombIndex < bombs.size(); bombIndex++) {
            Bomb bomb = bombs.get(bombIndex);
            bomb.move();

            if (bomb.collidesWith(player)) 
                bomb.trigger();
            
            if (bomb.isExploding && player.collidesWith(bomb))
                player.takeDamge();

            if (bomb.getY() > height + 200 || bomb.checkDeleted())
                bombs.remove(bombIndex);
        }

        for (int bulletIndex = 0; bulletIndex < bullets.size(); bulletIndex++) {
            Bullet bullet = bullets.get(bulletIndex);
            bullet.move();

            if (player.collidesWith(bullet)) 
                player.takeDamge();

            if (bullet.getY() > height + 200) 
                bullets.remove(bulletIndex);
        }
    }
    
    public void draw() {
        player.draw();
        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) 
                enemy[row][col].draw();
        }

        for (Bomb bomb: bombs) {
            bomb.draw();
        }

        for (Bullet bullet: bullets) {
            bullet.draw();
        }
    }
}