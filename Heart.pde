public class Heart {
    private final int HEART_WIDTH = 50;
    private final int HEART_HEIGHT = 50;

    private PImage[] skins;
    private boolean halfHeart = false;
    private boolean empty = false;
    private int skinState;
    private int flickerCounter;
    private float x;
    private float y;

    public Heart(float x, float y) {
        this.x = x;
        this.y = y;
        this.skinState = 0;

        String assets[] = {
            "./assets/Heart/Heart1.png",
            "./assets/Heart/Heart2.png",
            "./assets/Heart/Heart3.png",
        };

        skins = new PImage[assets.length];

        for (int skinIndex = 0; skinIndex < skins.length; skinIndex++) 
            skins[skinIndex] = loadImage(assets[skinIndex]);
    }

    public void takeDamge() {
        flickerCounter = 5;
    }

    public void takeDoubleDamage() {
        flickerCounter = 5;
        halfHeart = true;
    }

    public void draw() {
        if (!halfHeart && flickerCounter > 0 && frameCount % 10 == 0) {
            skinState = (++skinState) % 2;
            halfHeart = --flickerCounter == 0;
        }

        if (halfHeart && flickerCounter > 0 && frameCount % 10 == 0)  {
            skinState = ((skinState) % 2) + 1;
            empty = --flickerCounter == 0;
        }

        skins[skinState].resize(HEART_WIDTH, HEART_HEIGHT);
        image(skins[skinState], x, y);
    }

    public boolean checkDelete() {
        return empty;
    }

    public boolean checkHalfHeart() {
        return halfHeart;
    }
}