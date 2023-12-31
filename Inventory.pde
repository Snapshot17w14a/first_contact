class Inventory
{
    ArrayList<Item> heldItems = new ArrayList<Item>();
    int slotCount;
    int boxSize;
    int yOffset;
    int xPos = 10;
    boolean allowItemPickup;

    Inventory(int pSlotCount, int pBoxSize, int pYOffset)
    {
        slotCount = pSlotCount;
        boxSize = pBoxSize;
        yOffset = pYOffset;
    }

    void drawInventory()
    {
        allowItemPickup = (heldItems.size() < slotCount) ? true : false;
        strokeWeight(0);
        fill(128, 128, 128, 225);
        for(int i = 0; i < slotCount; i++)
        {
            int yPos = (i * boxSize) + yOffset * (i + 1);
            imageMode(CORNER);
            image(inventoryImage, xPos, yPos, boxSize, boxSize);
        }
        int loopCount = min(heldItems.size(), slotCount);
        for(int i = 0; i < loopCount; i++)
        {
            Item item = heldItems.get(i);
            int yPos = (i * boxSize) + yOffset * (i + 1);
            image(item.itemImage, xPos+8, yPos+8, boxSize-16, boxSize-16);
        }
    }

    boolean isInInventory(Item item, boolean removeFound)
    {
        boolean foundItem = false;
        for(int i = 0; i < heldItems.size(); i++)
        {
            if(heldItems.get(i) == item)
            {
                if(removeFound) heldItems.remove(i);
                foundItem = true;
                break;
            }
        }
        return foundItem;
    }
}