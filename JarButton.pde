class JarButton
{
    PImage arrow;
    PVector position;
    JarButton(PImage pImage, PVector pPos)
    {
        arrow = pImage;
        position = pPos;
    }

    void moveRight(int toMoveIndex)
    {
        if(toMoveIndex == 4)
        {
            println("cannot move");
        }
        else
        {
            jarSlides[(int)(random(0, 2))].play();
            Jar jar1 = randomJarOrder[toMoveIndex];
            Jar jar2 = randomJarOrder[toMoveIndex + 1];
            randomJarOrder[toMoveIndex] = jar2;
            randomJarOrder[toMoveIndex + 1] = jar1;
            jar1.jarPosition = toMoveIndex + 1;
            jar2.jarPosition = toMoveIndex;
        }
    }

    void moveLeft(int toMoveIndex)
    {
        if(toMoveIndex == 0)
        {
            println("cannot move");
        }
        else
        {
            jarSlides[(int)(random(0, 2))].play();
            Jar jar1 = randomJarOrder[toMoveIndex];
            Jar jar2 = randomJarOrder[toMoveIndex - 1];
            randomJarOrder[toMoveIndex] = jar2;
            randomJarOrder[toMoveIndex - 1] = jar1;
            jar1.jarPosition = toMoveIndex - 1;
            jar2.jarPosition = toMoveIndex;
        }
    }

    void drawArrow()
    {
        imageMode(CORNER);
        image(arrow, position.x - 32, position.y - 32, 64, 64);
    }

    boolean isOverJarButton()
    {
        return mouseX < position.x + 32 && mouseX > position.x - 32 && mouseY < position.y + 32 && mouseY > position.y - 32;
    }
}