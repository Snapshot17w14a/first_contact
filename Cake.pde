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
            inventory.heldItems.add(cookKey);
            keysPickup.play();
            removeButtonFrom.remove(this);
        }
    }

    void drawButton()
    {
        fill(255, 255, 255, 255);
        PImage imageToDraw = (itemsAdded == 5) ? keyImage : cakeIcon;
        image(imageToDraw, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, 64, 64);
    }
}