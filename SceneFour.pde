class SceneFour implements Scene {
    private Player player;
    private Alien[] enemy;
    private Shield[] shields;
    private ArrayList<Bomb> bombs;
    private ArrayList<Bullet> bullets;
    private ArrayList<Heart> hearts;
    private ArrayList<Laser> lasers;
    private ArrayList<Explosion> explosions;
    private ArrayList<PowerUp> powerUps;

    private int alienDirection = 1;
    private float alienLeftBound;
    private float alienRightBound;

    private int alienCount = 0;
    private float alienSpeed = PI/120;
    private float alienGroupSpeed = 10;
    private float angularOffset = 0;
    private float alienGroupCenterX = 0;
    private float alienGroupCenterY = 0;

    private int scoreDisplay = 0;

    public SceneFour() {
        resetGame();
    }

    public void update() {
        if ((player.getHealth() <= 0 || alienCount == 0) && explosions.size() == 0 && powerUps.size() == 0 && bombs.size() == 0)
            return;

        if (keyPressed && player.getHealth() > 0 && alienCount > 0) {
            if (keyInputs.get("left") && player.getX() > player.getWidth() / 2)
                player.move(-5, 0);
            if (keyInputs.get("right") && player.getX() < width - player.getWidth()/2)
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
        for (int alienIndex = 0; alienIndex < enemy.length; alienIndex++) {
            Alien alien = enemy[alienIndex];
            if (alien == null)  {
                continue;
            } 
            if (alien.checkDelete()) {
                PowerUp boost = new PowerUp(alien.getX(), alien.getY());
                boost.setVelocity(0,5);
                powerUps.add(boost);

                explosions.add(new Explosion(alien.getX(), alien.getY()));
                alienCount--;
                enemy[alienIndex] = null;
                continue;
            }

            for (int laserIndex = 0; laserIndex < lasers.size(); laserIndex++) {
                Laser laser = lasers.get(laserIndex);
                if (alien.collidesWith(laser) && laser.getVariant() == 0) {
                    alien.takeDamge(laser.getDamage());
                    player.increaseScore(laser.getDamage() * 5);
                    lasers.remove(laserIndex);
                }
            }

            alienLeftBound = (alien.getX() < alienLeftBound)? alien.getX(): alienLeftBound;
            alienRightBound = (alien.getX() + alien.getWidth() > alienRightBound)? alien.getX() + alien.getWidth(): alienRightBound;
            
            float setX = alienGroupCenterX + 600 * cos(alienIndex * TWO_PI/enemy.length + angularOffset);
            float setY = alienGroupCenterY + 300 * sin(alienIndex * TWO_PI/enemy.length + angularOffset);
            float dx = setX - alien.getX();
            float dy = setY - alien.getY();

            alien.move(dx, dy);

            if (random(1, 100) > 95)
                alien.attack();
        }

        angularOffset += alienSpeed;
        alienGroupCenterX += alienDirection * alienGroupSpeed;
        if (alienLeftBound < 100)
            alienDirection = 1;
        if (alienRightBound > width - 100) 
            alienDirection = -1;

        for (int bombIndex = 0; bombIndex < bombs.size(); bombIndex++) {
            Bomb bomb = bombs.get(bombIndex);
            bomb.move();

            if (bomb.collidesWith(player)) 
                bomb.trigger();

            for (int shieldIndex = 0; shieldIndex < shields.length; shieldIndex++) {
                Shield shield = shields[shieldIndex];
                if (shield.collidesWith(bomb))
                    bomb.trigger();
            }
            
            if (bomb.isExploding && player.collidesWith(bomb) && player.health > 0)
                player.takeDoubleDamage();

            if (bomb.getY() > height + 200 || bomb.checkDeleted())
                bombs.remove(bombIndex);
        }

        for (int bulletIndex = 0; bulletIndex < bullets.size(); bulletIndex++) {
            Bullet bullet = bullets.get(bulletIndex);
            bullet.move();

            if (player.collidesWith(bullet) && player.health > 0)
                player.takeDamge();

            if (bullet.getY() > height + 200) 
                bullets.remove(bulletIndex);

            for (int shieldIndex = 0; shieldIndex < shields.length; shieldIndex++) {
                Shield shield = shields[shieldIndex];
                if (shield.collidesWith(bullet)) {
                    explosions.add( new Explosion(bullet.getX(), bullet.getY()));
                    bullets.remove(bulletIndex);
                    continue;
                } 
            }
        }

        for (int laserIndex = 0; laserIndex < lasers.size(); laserIndex++) {
            Laser laser = lasers.get(laserIndex);
            laser.move();

            if (player.collidesWith(laser) && laser.getVariant() == 1) {
                player.takeDamge();
            }

            if (laser.getY() < -100) {
                player.decreaseScore(1);
                lasers.remove(laserIndex);
            }
            if (laser.getY() > height + 100 && laser.getVariant() == 1) 
                lasers.remove(laserIndex);

            for (int shieldIndex = 0; shieldIndex < shields.length; shieldIndex++) {
                Shield shield = shields[shieldIndex];
                if (shield.collidesWith(laser)) {
                    explosions.add( new Explosion(laser.getX(), laser.getY()));
                    lasers.remove(laserIndex);
                    continue;
                } 
            }
        }

        for (int powerUpIndex = 0; powerUpIndex < powerUps.size(); powerUpIndex++) {
            PowerUp powerUp = powerUps.get(powerUpIndex);
            powerUp.move();

            if (player.collidesWith(powerUp)) {
                player.increaseScore(5);
                player.boost(powerUp.getType());
                powerUps.remove(powerUpIndex);
            } else if (powerUp.getY() > height + 100) {
                powerUps.remove(powerUpIndex);
            }
        }

        for (int explosionIndex = 0; explosionIndex < explosions.size(); explosionIndex++) {
            Explosion explosion = explosions.get(explosionIndex);
            if (explosion.checkDeleted())
                explosions.remove(explosionIndex);
        }
        if (hearts.size() > 0) {
            if (hearts.get(hearts.size() - 1).checkDelete())
                hearts.remove(hearts.size() - 1);
        }
    }
    
    public void draw() {
        for (Shield shield: shields)
            shield.draw();

        player.draw();
        for (int alienIndex = 0; alienIndex < enemy.length; alienIndex++) {
                if (enemy[alienIndex] != null)
                    enemy[alienIndex].draw();
        }

        for (PowerUp powerUp: powerUps)
            powerUp.draw();
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
        text("Player Ammo: " + player.getAmmunition(), width - 20, 40);
    }

    private void gameOverMenu() {
        if (hearts.size() > 0)
            hearts.remove(hearts.size() -1);
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
        text("Round Two Over!!!", width/2, height/2 - 100);
        text("Score: " + scoreDisplay, width/2, height/2);
        text("Presss <SPACE> to get to \n the next level.", width/2, height/2 + 100);
        if (scoreDisplay + 5 < player.getScore())
            scoreDisplay+= 5;
        else if (scoreDisplay < player.getScore())
            scoreDisplay+= 1;

        if (keyPressed) {
            if (keyInputs.get("space"))
                sceneNumber = 2;
                // resetGame();
        }
    }

    private void resetGame() {
        hearts = new ArrayList<>();
        bombs = new ArrayList<>();
        bullets = new ArrayList<>();
        lasers = new ArrayList<>();
        explosions = new ArrayList<>();
        powerUps = new ArrayList<>();
        shields = new Shield[3];
        for (int shieldIndex = 0; shieldIndex < shields.length; shieldIndex++) {
            shields[shieldIndex] = new Shield(200 + 900 * shieldIndex, height - 400);
        }

        player = new Player(width/2, height - 100, hearts, lasers);
        for (int heartIndex = 0; heartIndex < player.getHealth()/2; heartIndex++) {
            hearts.add(new Heart(75 * heartIndex + 50, 50));
        }

        alienCount = 0;
        enemy = new Alien[16];
        alienGroupCenterX = width/2;
        alienGroupCenterY = height/2 - 200;
        for (int alienIndex = 0; alienIndex < enemy.length; alienIndex++) {
            alienCount++;
            float setX = alienGroupCenterX + 600 * cos(alienIndex * TWO_PI/enemy.length);
            float setY = alienGroupCenterY + 300 * sin(alienIndex * TWO_PI/enemy.length);
            float spawnChoice = random(1, 100);
            if (spawnChoice < 30)
                enemy[alienIndex] = new AlienOne(setX, setY, bombs);
            else if (spawnChoice < 60)
                enemy[alienIndex] = new AlienTwo(setX, setY, bullets);
            else 
                enemy[alienIndex] = new AlienThree(setX, setY, lasers);
        }
    }
}