class CornerPipe extends Pipe
{
    PImage[] sprites = new PImage[4];

    CornerPipe(PVector pHolderPos, int pRotation, int pArrayIndex, PImage[] pImageArray)
    {
        pipeRotationNum = pRotation;
        holderPosition = pHolderPos;
        arrayIndex = pArrayIndex;
        sprites = pImageArray;
        switch(pRotation)
        {
            case 0:
                pipeRotation = PipeState.SouthEast;
                break;
            case 1:
                pipeRotation = PipeState.SouthWest;
                break;
            case 2:
                pipeRotation = PipeState.NorthWest;
                break;
            case 3:
                pipeRotation = PipeState.NorthEast;
                break;
        }
    }

    void drawPipe()
    {
        fill(0);
        switch (pipeRotation) 
        {
            case SouthEast:
                spriteToDraw = sprites[0];
                break;
            case SouthWest:
                spriteToDraw = sprites[1];
                break;
            case NorthEast:
                spriteToDraw = sprites[2];
                break;
            case NorthWest:
                spriteToDraw = sprites[3];
                break;
        }
        image(spriteToDraw, holderPosition.x - gridBoxSize / 2, holderPosition.y - gridBoxSize / 2, gridBoxSize, gridBoxSize);
    }

    void rotatePipe()
    {
        pipeSound.play();
        if(pipeRotationNum < 3) pipeRotationNum++;
        else pipeRotationNum = 0;
        switch(pipeRotationNum)
        {
            case 0:
                pipeRotation = PipeState.SouthEast;
                break;
            case 1:
                pipeRotation = PipeState.SouthWest;
                break;
            case 2:
                pipeRotation = PipeState.NorthWest;
                break;
            case 3:
                pipeRotation = PipeState.NorthEast;
                break;
        }
    }
}