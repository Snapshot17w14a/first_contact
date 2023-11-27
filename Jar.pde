class Jar
{
    int indexInArray;
    int jarPosition;
    PVector jarSize;
    PVector position;
    PImage jarIcon;
    boolean isJarSelected;
    boolean isInCorrectSpot;
    Jar(PVector pSize, int pIndex, PImage pIcon)
    {
        jarSize = pSize;
        indexInArray = pIndex;
        jarIcon = pIcon;
        position = new PVector(0, 0);
    }

    void drawJar()
    {
        position.x = jarPosition * 100 + (jarPosition * 50) + 200;
        position.y = height/2 - (indexInArray * 10)/2;
        fill(255, 255, 255, 255);
        imageMode(CENTER);
        image(jarIcon, position.x, position.y, jarSize.x, jarSize.y);
        fill(0);
        if(jarPosition == indexInArray) isInCorrectSpot = true;
        else isInCorrectSpot = false;
    }

    boolean isOverJar()
    {
        return mouseX < position.x + jarSize.x/2 && mouseX > position.x - jarSize.x/2 && mouseY < position.y + jarSize.y/2 && mouseY > position.y - jarSize.y/2;
    }
}