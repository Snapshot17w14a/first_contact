class ExitButton extends Button
{
    PImage buttonIcon;

    ExitButton(PVector pPos, PVector pSize, PImage pIcon)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        buttonIcon = pIcon;
    }

    void drawButton()
    {
        fill(255, 255, 255, 255);
        image(buttonIcon, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, 64, 64);
    }

    void buttonAction()
    {
        boolean exit = allowExit(false);
        if(exit) 
        {
            mainDoorUnlock.play();
            allowExit(true);
            gameState = GameState.WinMenu;
            isWinMenu = true;
        }
        else
        {
            keysMissing.toggleRender();
            lockedDoor.play();
        } 
    }

    boolean allowExit(boolean removeKeys)
    {
        boolean isPipeKey = false;
        boolean isCookKey = false;
        boolean isJarKey = false;
        if(inventory.isInInventory(pipeKey, removeKeys)) {isPipeKey = true;}
        if(inventory.isInInventory(cookKey, removeKeys)) {isCookKey = true;}
        if(inventory.isInInventory(jarKey, removeKeys)) {isJarKey = true;}
        return isPipeKey && isCookKey && isJarKey;
    }
}