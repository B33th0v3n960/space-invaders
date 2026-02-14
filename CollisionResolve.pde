interface CollisionResolve {
    public void resolve(float normalAxis[]);
}

class Bounce implements CollisionResolve {
    @Override
    public void resolve(float normalAxis[]) {
        System.out.println(normalAxis[0]+ ", " + normalAxis[1]);
    }
}