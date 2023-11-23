class TextBox
{
    String bodyText;
    boolean renderText;
    Scene parentScene;

    TextBox(String pText, Scene pScene)
    {
        bodyText = pText;
        parentScene = pScene;
    }

    void toggleRender()
    {
        renderText = !renderText;
        parentScene.isTextBeingRendered = renderText;
    }

    void drawTextBox()
    {
        rectMode(CENTER);
        strokeWeight(2);
        fill(255, 255, 255, 255);
        rect(width/2, 550, width - 40, 80);
        textAlign(LEFT, TOP);
        textSize(20);
        fill(0, 0, 0, 255);
        rectMode(CENTER);
        text(bodyText, width/2, 550, width - 60, 70);
    }
}