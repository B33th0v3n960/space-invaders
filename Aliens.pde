import java.util.HashMap;
import java.util.ArrayList;

HashMap<String, Boolean> keyInputs = new HashMap<>();
public int sceneNumber = 0;
public Scene currentScene;

void setup() {
  size(2560, 1440, P2D);
  surface.setTitle("Space Invaders");
  surface.setResizable(false);
  frameRate(60);

  noStroke();
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);

  keyInputs.put("up", false);
  keyInputs.put("down", false);
  keyInputs.put("left", false);
  keyInputs.put("right", false);
  keyInputs.put("currTabState", false);
  keyInputs.put("prevTabState", false);
  keyInputs.put("space", false);
  keyInputs.put("currLeftClick", false);
  keyInputs.put("prevLeftClick", false);

  currentScene = new SceneOne();
}

void draw() {
  background(#2e3440);
  textSize(24);

  if (keyInputs.get("currTabState") && !keyInputs.get("prevTabState")) {
    sceneNumber = (++sceneNumber) % 2;

    switch (sceneNumber) {
      case 0:
        currentScene = new SceneOne();
        break;
      case 1:
        currentScene = new SceneTwo();
        break;
      default: 
        System.err.println("Could not find scene");
        break;
    }
  }

  currentScene.update();
  currentScene.draw();

  keyInputs.put("prevTabState", keyInputs.get("currTabState"));
  keyInputs.put("prevLeftClick", keyInputs.get("currLeftClick"));
}
