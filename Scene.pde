class Scene
{
    PImage background;
    ArrayList<Button> sceneButtons = new ArrayList<Button>();

    Scene(PImage pBackground)
    {
        background = pBackground;
    }

    void drawScene()
    {
        image(background, 0, 0, width, height);
        for(Button button : sceneButtons)
        {
            button.drawButton();
        }
    }

    void addMoveButton(PVector pPos, PVector pSize, Scene pScene)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pScene));
    }

    void addMoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pScene, pIcon));
    }

    void addMoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon, Item pItem)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pScene, pIcon, pItem));
    }

    void addMoveButton(PVector pPos, PVector pSize, PImage pIcon, GameState pGameState)
    {
        sceneButtons.add(new MoveButton(pPos, pSize, pIcon, pGameState));
    }

    void addItemButton(PVector pPos, PVector pSize, Item pItem)
    {
        sceneButtons.add(new ItemButton(pPos, pSize, pItem, sceneButtons));
    }

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