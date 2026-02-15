void keyPressed() {
  if (key == 'w' || key == 'W')  keyInputs.put("up", true);
  if (key == 'a' || key == 'A')  keyInputs.put("left", true);
  if (key == 's' || key == 'S')  keyInputs.put("down", true);
  if (key == 'd' || key == 'D')  keyInputs.put("right", true);
  if (keyCode == TAB) keyInputs.put("currTabState", true);
  if (key == ' ') keyInputs.put("space", true);

  if (key == 'q' || key == 'Q') exit();
}

void keyReleased() {
  if (key == 'w' || key == 'W')  keyInputs.put("up", false);
  if (key == 'a' || key == 'A')  keyInputs.put("left", false);
  if (key == 's' || key == 'S')  keyInputs.put("down", false);
  if (key == 'd' || key == 'D')  keyInputs.put("right", false);
  if (keyCode == TAB) keyInputs.put("currTabState", false);
  if (key == ' ') keyInputs.put("space", false);
}

void mousePressed() {
  keyInputs.put("currLeftClick", true);
}

void mouseReleased() {
  keyInputs.put("currLeftClick", false);
}
