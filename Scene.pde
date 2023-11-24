class Scene
{
    PImage background;
    ArrayList<Button> sceneButtons = new ArrayList<Button>();
    ArrayList<TextBox> sceneTexts = new ArrayList<TextBox>();
    boolean isTextBeingRendered = false;

    Scene(PImage pBackground)
    {
        background = pBackground;
    }

    //Draws the scene and the buttons in the scene
    void drawScene()
    {
        image(background, 0, 0, width, height);
        for(Button button : sceneButtons)
        {
            button.drawButton();
        }
        for(TextBox textBox : sceneTexts)
        {
            if(textBox.renderText) {textBox.drawTextBox();}
        }
    }

    //Basic move button
    void addMoveButton(PVector pPos, PVector pSize, Scene pScene)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pScene));
    }

    //Move button with icon
    void addMoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pScene, pIcon));
    }

    //Move button with Item condition
    void addMoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon, Item pItem)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pScene, pIcon, pItem));
    }

    //Move button with GameState change - use when changing to minigames
    void addMoveButton(PVector pPos, PVector pSize, PImage pIcon, GameState pGameState)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pIcon, pGameState));
    }

    //Basic item button
    void addItemButton(PVector pPos, PVector pSize, Item pItem)
    {
        sceneButtons.add(new ItemButton(pPos, pSize, pItem, sceneButtons));
    }

    //Basic text button
    void addTextButton(PVector pPos, PVector pSize, PImage pIcon, TextBox pText)
    {
        sceneButtons.add(new TextButton(pPos, pSize, pIcon, pText));
    }

    //Basic text box
    TextBox createTextBox(String pText)
    {
        TextBox tempTextBox = new TextBox(pText, this);
        sceneTexts.add(tempTextBox);
        return tempTextBox;
    }

    //Checks for collision on all buttons in the Scene
    void checkButtonCollision()
    {
        if(isTextBeingRendered) 
        {
            isTextBeingRendered = false;
            for(TextBox textBox : sceneTexts)
            {
                if(textBox.renderText)
                {
                    textBox.toggleRender();
                    break;
                }
            }
        }
        else 
        {
            for(Button button : sceneButtons)
            {
                if(mouseX < button.buttonPosition.x + button.buttonSize.x/2 && mouseX > button.buttonPosition.x - button.buttonSize.x/2 && mouseY < button.buttonPosition.y + button.buttonSize.y/2 && mouseY > button.buttonPosition.y - button.buttonSize.y/2)
                {
                    button.buttonAction();
                    break;
                }
            }
        }
    }
}