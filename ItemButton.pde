class ItemButton extends Button
{
    Item buttonItem;
    ArrayList removeButtonFrom;
    boolean isKey;

    ItemButton(PVector pPos, PVector pSize, Item pItem, ArrayList pArray, boolean pIsKey)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        buttonItem = pItem;
        removeButtonFrom = pArray;
        isKey = pIsKey;
    }

    void buttonAction()
    {
        if(inventory.allowItemPickup)
        {
            inventory.heldItems.add(buttonItem);
            removeButtonFrom.remove(this);
            SoundFile sf = (isKey) ? keysPickup : grabObject;
            sf.play();
        }
        else
        {
            fullInventoryNotification.toggleRender();
        }
    }

    void drawButton()
    {
        strokeWeight(12);
        fill(255, 255, 255, 255);
        image(buttonItem.itemImage, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, buttonSize.x, buttonSize.y);
    }
}