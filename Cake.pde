class Cake extends Button
{
    int itemsAdded = 0;
    Item[] itemsNeeded = new Item[5];
    PImage cakeIcon;
    ArrayList removeButtonFrom;

    Cake(PVector pPos, PVector pSize, PImage pIcon, ArrayList pArray)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        cakeIcon = pIcon;
        removeButtonFrom = pArray;
    }

    void buttonAction()
    {
        int foundAnyItem = 0;
        if(itemsAdded <= 4)
        {
            for(int i = 0; i < 5; i++)
            {
                boolean found = inventory.isInInventory(itemsNeeded[i], true);
                if(found) 
                {
                    itemsAdded++; 
                    foundAnyItem++;
                    break; 
                }
            }
            if(foundAnyItem == 0) {missingIngredients.toggleRender();}
        }
        else
        {
            if(inventory.allowItemPickup) inventory.heldItems.add(fullBowl);
            else kitchenScene.addItemButton(new PVector(480, 265), new PVector(64, 64), fullBowl, false);
            removeButtonFrom.remove(this);
        }
    }

    void drawButton()
    {
        fill(255, 255, 255, 255);
        PImage imageToDraw = (itemsAdded == 5) ? fullBowlImage : cakeIcon;
        if(mouseX < buttonPosition.x + buttonSize.x/2 && mouseX > buttonPosition.x - buttonSize.x/2 && mouseY < buttonPosition.y + buttonSize.y/2 && mouseY > buttonPosition.y - buttonSize.y/2) noTint();
        else tint(16, 16, 16, 255);
        image(imageToDraw, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, 64, 64);
        noTint();
    }
}