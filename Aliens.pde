import java.util.HashMap;
import java.util.ArrayList;
import processing.sound.*;

HashMap<String, Boolean> keyInputs = new HashMap<>();
public int prevSceneNumber = 0;
public int sceneNumber = 0;
public Scene currentScene;
public Aliens parent = this;

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

  currentScene.update();
  currentScene.draw();

  if (keyInputs.get("currTabState") && !keyInputs.get("prevTabState") ) {
    sceneNumber = (++sceneNumber) % 4;
    switch (sceneNumber) {
      case 0:
        currentScene = new SceneOne();
        break;
      case 1:
        currentScene = new SceneTwo();
        break;
      case 2:
        currentScene = new SceneThree();
        break;
      case 3:
        currentScene = new SceneFour();
        break;
      default: 
        System.err.println("Could not find scene");
        break;
    }
  } else if (sceneNumber != prevSceneNumber) {
    switch (sceneNumber) {
      case 0:
        currentScene = new SceneOne();
        break;
      case 1:
        currentScene = new SceneTwo();
        break;
      case 2:
        currentScene = new SceneThree();
        break;
      case 3:
        currentScene = new SceneFour();
        break;
      default: 
        System.err.println("Could not find scene");
        break;
    }
  }

  prevSceneNumber = sceneNumber;
  keyInputs.put("prevTabState", keyInputs.get("currTabState"));
  keyInputs.put("prevLeftClick", keyInputs.get("currLeftClick"));
}
