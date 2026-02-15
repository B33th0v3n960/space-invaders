class Explosion {
    private PImage animationFrames[] = new PImage[6];
    private boolean isDeleted = false;
    private int counter = 0;
    private int frame = 0;
    private float x;
    private float y;

    public Explosion(float x, float y) {
        this.x = x;
        this.y = y;

        String assets[] = {
            "./assets/Explosion/Explosion-1.png",
            "./assets/Explosion/Explosion-2.png",
            "./assets/Explosion/Explosion-3.png",
            "./assets/Explosion/Explosion-4.png",
            "./assets/Explosion/Explosion-5.png",
            "./assets/Explosion/Explosion-6.png"
        };

        for (int frame = 0; frame < animationFrames.length; frame++) 
            animationFrames[frame] = loadImage(assets[frame]);
    }

    public void draw() {
        counter++;
        if (counter % 5 == 0 && frame < 5) {
            frame++;
            animationFrames[frame].resize(100, 100);
        } 
        if (frame >= 5)
            isDeleted = true;
        image(animationFrames[frame], x, y);
    }

    public boolean checkDeleted() {
        return isDeleted;
    }
}