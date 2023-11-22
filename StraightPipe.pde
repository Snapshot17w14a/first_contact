class StraightPipe extends Pipe
{
    PImage[] sprites = new PImage[2];

    StraightPipe(PVector pHolderPos, int pRotation, int pArrayIndex, PImage[] pImageArray)
    {
        pipeRotationNum = pRotation;
        holderPosition = pHolderPos;
        arrayIndex = pArrayIndex;
        sprites = pImageArray;
        switch(pRotation)
        {
            case 4:
                pipeRotation = PipeState.UpDown;
                break;
            case 5:
                pipeRotation = PipeState.LeftRight;
                break;
        }
    }

    void drawPipe()
    {
        fill(255, 255, 255, 0);
        switch(pipeRotation)
        {
            case UpDown:
                spriteToDraw = sprites[0];
                break;
            case LeftRight:
                spriteToDraw = sprites[1];
                break;
        }
        image(spriteToDraw, holderPosition.x - gridBoxSize / 2, holderPosition.y - gridBoxSize / 2, gridBoxSize, gridBoxSize);
    }

    void rotatePipe()
    {
        switch(pipeRotationNum)
        {
            case 4:
                pipeRotationNum = 5;
                pipeRotation = PipeState.LeftRight;
                break;
            case 5:
                pipeRotationNum = 4;
                pipeRotation = PipeState.UpDown;
                break;
        }
    }
}