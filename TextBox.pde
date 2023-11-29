class TextBox
{
    String bodyText;
    boolean renderText;
    boolean bigText = false;
    Scene parentScene;
    Scene nextScene;

    TextBox(String pText, Scene pScene)
    {
        bodyText = pText;
        parentScene = pScene;
    }

    TextBox(String pText, Scene pScene, boolean pBigText, Scene pNextScene)
    {
        bodyText = pText;
        parentScene = pScene;
        bigText = pBigText;
        nextScene = pNextScene;
    }

    void toggleRender()
    {
        renderText = !renderText;
        parentScene.isTextBeingRendered = renderText;
        if(bigText && !renderText)
        {
            sceneManager.loadScene(nextScene);
        }
    }

    void drawTextBox()
    {
        rectMode(CENTER);
        strokeWeight(2);
        fill(128, 128, 128, 225);
        if(!bigText)
        {
            rect(width/2, 550, width - 40, 80);
            textAlign(LEFT, TOP);
            textFont(baseFont, 20);
            fill(0);
            text(bodyText, width/2, 550, width - 60, 70);
        }
        else
        {
            rect(width/2, height/2, 760, 400);
            textAlign(CENTER, CENTER);
            textFont(baseFont, 24);
            fill(0);
            text(bodyText, width/2, height/2, 740, 400);
        }
    }
}