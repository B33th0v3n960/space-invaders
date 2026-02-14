public class Heart {
    private final int HEART_WIDTH = 50;
    private final int HEART_HEIGHT = 50;

    private PImage[] skins;
    private int skinState;
    private float x;
    private float y;

    public Heart(float x, float y) {
        this.x = x;
        this.y = y;
        this.skinState = 0;

        String assets[] = {
            "./assets/Heart/Heart1.png",
            "./assets/Heart/Heart2.png",
        };

        skins = new PImage[2];

        for (int skinIndex = 0; skinIndex < skins.length; skinIndex++) 
            skins[skinIndex] = loadImage(assets[skinIndex]);
    }

    public void draw() {
      skins[skinState].resize(HEART_WIDTH, HEART_HEIGHT);
      image(skins[skinState], x, y);
    }
}