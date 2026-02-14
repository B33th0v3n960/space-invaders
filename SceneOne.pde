class SceneOne implements Scene {
    private Player player;
    private Alien[][] enemy;
    private ArrayList<Bomb> bombs = new ArrayList<>();

    public SceneOne() {
        player = new Player(width/2, height - 100);
        enemy = new Alien[4][5];
        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                enemy[row][col] = new AlienOne((width/2 - 500) + col * 200, 100 + row * 200, bombs);
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

        for (int row = 0; row < enemy.length; row++) {
            for (int col = 0; col < enemy[row].length; col++) {
                if (random(1, 100) > 99)
                    enemy[row][col].attack();
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
    }
}