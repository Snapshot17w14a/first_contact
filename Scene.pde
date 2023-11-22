class Scene
{
    PImage background;
    ArrayList<Button> sceneButtons = new ArrayList<Button>();

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

    //Checks for collision on all buttons in the Scene
    void checkButtonCollision()
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