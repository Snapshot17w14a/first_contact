class MoveButton extends Button
{
    GameState nextGameState;
    ButtonType buttonType;
    Scene sceneToMove;
    PImage buttonIcon;
    Item requieredItem;
    SoundFile transitionSound;

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

    MoveButton(PVector pPos, PVector pSize, Scene pScene, PImage pIcon, SoundFile pTransition)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        sceneToMove = pScene;
        buttonIcon = pIcon;
        transitionSound = pTransition;
    }

    MoveButton(PVector pPos, PVector pSize, PImage pIcon, GameState pGameState)
    {
        buttonPosition = pPos;
        buttonSize = pSize;
        buttonIcon = pIcon;
        nextGameState = pGameState;
    }

    void drawButton()
    {
        fill(255, 255, 255, 255);
        imageMode(CORNER);
        if(buttonIcon != null) image(buttonIcon, buttonPosition.x - buttonSize.x/2, buttonPosition.y - buttonSize.y/2, 64, 64);
    }

    void buttonAction()
    {
        if(requieredItem != null)
        {
            if(inventory.isInInventory(requieredItem, true))
            {
                playTransitionSound();
                sceneManager.loadScene(sceneToMove);
            }
            else
            {
                println("missing item");
            }
        }
        else if(nextGameState != null)
        {
            gameState = nextGameState;
        }
        else
        {
            if(transitionSound != null)
            {
                transitionSound.play();
                sceneManager.loadScene(sceneToMove);
            }
            else
            {
                playTransitionSound();
                sceneManager.loadScene(sceneToMove);
            }
        }
    }

    void playTransitionSound()
    {
        roomTransitions[(int)(random(0,3))].play();
    }
}