class ItemButton extends Button
{
    Item buttonItem;
    ArrayList removeButtonFrom;

    ItemButton(PVector pPos, PVector pSize, Item pItem, ArrayList pArray)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        buttonItem = pItem;
        removeButtonFrom = pArray;
    }

    void buttonAction()
    {
        if(inventory.allowItemPickup)
        {
            inventory.heldItems.add(buttonItem);
            removeButtonFrom.remove(this);
        }
        else
        {
            println("inv full");
        }
    }

    void drawButton()
    {
        strokeWeight(12);
        fill(255, 255, 255, 255);
        image(buttonItem.itemImage, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, buttonSize.x, buttonSize.y);
    }
}