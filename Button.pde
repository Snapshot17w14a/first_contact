enum ButtonType{Item, Move}

class Button
{
    PVector buttonPosition;
    PVector buttonSize;

    void drawButton()
    {
        strokeWeight(0);
        rectMode(CENTER);
        fill(255, 255, 255, 0);
        rect(buttonPosition.x, buttonPosition.y, buttonSize.x, buttonSize.y);
    }

    void buttonAction()
    {}
}