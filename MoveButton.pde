class MoveButton extends Button
{
    ButtonType buttonType;
    Scene sceneToMove;
    PImage buttonIcon;
    Item requieredItem;

    MoveButton(PVector pPos, PVector pSize, Scene pScene)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        sceneToMove = pScene;
    }

    MoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        sceneToMove = pScene;
        buttonIcon = pIcon;
    }

    MoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon, Item pItem)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        sceneToMove = pScene;
        buttonIcon = pIcon;
        requieredItem = pItem;
    }

    void drawButton()
    {
        strokeWeight(0);
        rectMode(CENTER);
        fill(255, 255, 255, 0);
        rect(buttonPosition.x, buttonPosition.y, buttonSize.x, buttonSize.y);
        fill(255, 255, 255, 255);
        if(buttonIcon != null) image(buttonIcon, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, 64, 64);
    }

    void buttonAction()
    {
        if(requieredItem != null)
        {
            if(inventory.isInInventory(requieredItem, true))
            {
                sceneManager.loadScene(sceneToMove);
            }
            else
            {
                println("missing item");
            }
        }
        else
        {
            sceneManager.loadScene(sceneToMove);
        }
    }
}