class PipeHolder
{
    PVector position;
    Pipe heldPipe;

    PipeHolder(PVector pPos)
    {
        position = pPos;
    }

    void drawHolder()
    {
        rectMode(CENTER);
        fill(255, 255, 255, 0);
        rect(position.x, position.y, gridBoxSize, gridBoxSize);
        heldPipe.drawPipe();
    }

    boolean isOverHeldPipe()
    {
        return mouseX < position.x + gridBoxSize/2 && mouseX > position.x - gridBoxSize/2 && mouseY < position.y + gridBoxSize/2 && mouseY > position.y - gridBoxSize/2;
    }
}