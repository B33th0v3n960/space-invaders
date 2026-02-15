class SceneOne implements Scene {
    private Player player;
    private Alien[][] enemy;
    private ArrayList<Bomb> bombs;
    private ArrayList<Bullet> bullets;
    private ArrayList<Heart> hearts;
    private ArrayList<Laser> lasers;
    private ArrayList<Explosion> explosions;
    private int alienDirection = 1;
    private float alienSpeed = 10;
    private float alienLeftBound;
    private float alienRightBound;
    private int scoreDisplay = 0;
    private int alienCount = 0;

    public SceneOne() {
        resetGame();
    }

    public void update() {
        if (player.getHealth() <= 0 || alienCount == 0) 
            return;

        if (keyPressed) {
            if (keyInputs.get("left"))
                player.move(-5, 0);
            if (keyInputs.get("right"))
                player.move(5,0);
        }

        if (mousePressed) {
            if (keyInputs.get("currLeftClick")) {
                if (!keyInputs.get("prevLeftClick"))
                    player.startAttack();
                player.attack();
            }
        }

        alienLeftBound = alienRightBound = width / 2;
        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                Alien alien = enemy[row][col];
                if (alien == null)  {
                    continue;
                } 
                if (alien.checkDelete()) {
                    explosions.add(new Explosion(alien.getX(), alien.getY()));
                    alienCount--;
                    enemy[row][col] = null;
                    continue;
                }

                for (int laserIndex = 0; laserIndex < lasers.size(); laserIndex++) {
                    Laser laser = lasers.get(laserIndex);
                    if (alien.collidesWith(laser)) {
                        alien.takeDamge();
                        player.increaseScore(5);
                        lasers.remove(laserIndex);
                    }
                }

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
                player.takeDoubleDamage();

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

        for (int laserIndex = 0; laserIndex < lasers.size(); laserIndex++) {
            Laser laser = lasers.get(laserIndex);
            laser.move();

            if (laser.getY() < -100) {
                player.decreaseScore(1);
                lasers.remove(laserIndex);
            }
        }

        for (int explosionIndex = 0; explosionIndex < explosions.size(); explosionIndex++) {
            Explosion explosion = explosions.get(explosionIndex);
            if (explosion.checkDeleted())
                explosions.remove(explosionIndex);
        }

        if (hearts.get(hearts.size() - 1).checkDelete())
            hearts.remove(hearts.size() - 1);
    }
    
    public void draw() {
        player.draw();

        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                if (enemy[row][col] != null)
                    enemy[row][col].draw();
            }
        }

        for (Bomb bomb: bombs)
            bomb.draw();
        for (Bullet bullet: bullets)
            bullet.draw();
        for (Heart heart: hearts)
            heart.draw();
        for (Laser laser: lasers) 
            laser.draw();
        for (Explosion explosion: explosions)
            explosion.draw();
        
        if (player.getHealth() <= 0) {
            gameOverMenu();
            return;
        } else if (alienCount <= 0) {
            roundOverMenu();
            return;
        }

        fill(#d8dee9);
        textAlign(RIGHT, TOP);
        text("Player Score: " + player.getScore(), width - 20, 20);
        text("Player Score: " + player.getAmmunition(), width - 20, 40);
    }

    private void gameOverMenu() {
        fill(#e5e9f0);
        rect(width/2 , height/2, 720, 480, 20);
        textAlign(CENTER);
        textSize(48);
        fill(#2e3440);
        text("Game Over", width/2, height/2 - 100);
        text("Presss <SPACE> to play again.", width/2, height/2 + 100);

        if (keyPressed) {
            if (keyInputs.get("space"))
                resetGame();
        }
    }

    private void roundOverMenu() {
        fill(#e5e9f0);
        rect(width/2 , height/2, 720, 480, 20);
        textAlign(CENTER);
        textSize(48);
        fill(#2e3440);
        text("You've won!!!", width/2, height/2 - 100);
        text("Score: " + scoreDisplay, width/2, height/2);
        text("Presss <SPACE> to play again.", width/2, height/2 + 100);
        if (scoreDisplay < player.getScore())
            scoreDisplay++;

        if (keyPressed) {
            if (keyInputs.get("space"))
                resetGame();
        }
    }

    private void resetGame() {
        hearts = new ArrayList<>();
        bombs = new ArrayList<>();
        bullets = new ArrayList<>();
        lasers = new ArrayList<>();
        explosions = new ArrayList<>();
        alienCount = 0;
        player = new Player(width/2, height - 100, hearts, lasers);
        for (int heartIndex = 0; heartIndex < player.getHealth()/2; heartIndex++) {
            hearts.add(new Heart(75 * heartIndex + 50, 50));
        }

        enemy = new Alien[2][4];
        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                alienCount++;
                float xCoordinate = width/2 - 500 + col * 200;
                float yCoordinate = 100 + row * 200;
                if (random(1,100) > 50)
                    enemy[row][col] = new AlienOne(xCoordinate, yCoordinate, bombs);
                else 
                    enemy[row][col] = new AlienTwo(xCoordinate, yCoordinate, bullets);
            } 
        }
    }
}