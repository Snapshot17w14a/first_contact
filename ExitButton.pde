class ExitButton extends Button
{
    PImage buttonIcon;
    Scene exitScene;

    ExitButton(PVector pPos, PVector pSize, PImage pIcon, Scene pScene)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        buttonIcon = pIcon;
        exitScene = pScene;
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
            allowExit(true);
            sceneManager.loadScene(exitScene);
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