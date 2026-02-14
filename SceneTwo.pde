public class SceneTwo implements Scene {
    Player player = new Player(width/2, height - 100, null);

    public SceneTwo() {
        player.chageState();
    }

    public void update() {
        if (keyPressed) {
            if (keyInputs.get("left"))
                player.move(-5, 0);
            if (keyInputs.get("right"))
                player.move(5,0);
        }
    }
    
    public void draw() {
        player.draw();
    }
}