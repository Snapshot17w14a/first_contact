class TextButton extends Button
{
    PImage buttonIcon;
    TextBox textBoxToRender; 

    TextButton(PVector pPos, PVector pSize, PImage pIcon, TextBox pTextBox)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        buttonIcon = pIcon;
        textBoxToRender = pTextBox;
    }

    void buttonAction()
    {
        textBoxToRender.toggleRender();
    }

    void drawButton()
    {
        strokeWeight(12);
        fill(255, 255, 255, 255);
        image(buttonIcon, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, buttonSize.x, buttonSize.y);
    }
}