class Oven extends Button
{
    PImage ovenIcon;

    Oven(PVector pPos, PVector pSize, PImage pIcon)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        ovenIcon = pIcon;
    }

    void drawButton()
    {
        fill(255, 255, 255, 255);
        image(ovenIcon, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, 32, 32);
    }

    void buttonAction()
    {
        if(inventory.isInInventory(fullBowl, true))
        {
            cookKeyFound.toggleRender();
            inventory.heldItems.add(cookKey);
        }
        else missingIngredients.toggleRender();
    }
}