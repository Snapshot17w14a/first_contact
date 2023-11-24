SceneManager sceneManager;
Scene currentScene;
Scene initialScene;
Scene room1Scene;
PImage img1;
PImage img2;
PImage magnifier;
Inventory inventory;
Item glass;

boolean allowMouseClick = true;

void setup() 
{
    size(800, 800);
    img1 = loadImage("testBackground.jpg");
    img2 = loadImage("Factory1.png");
    magnifier = loadImage("magnifier.png");
    sceneManager = new SceneManager();
    inventory = new Inventory(3, 100, 10);
    glass = new Item(magnifier);

    room1Scene = new Scene(img2);
    initialScene = new Scene(img1);

    room1Scene.addMoveButton(new PVector(200, 400), new PVector(64, 64), initialScene, magnifier, glass);
    initialScene.addMoveButton(new PVector(400, 600), new PVector(100, 120), room1Scene);

    room1Scene.addItemButton(new PVector(400, 200), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(300, 400), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(600, 100), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(700, 500), new PVector(32, 32), glass);

<<<<<<< Updated upstream
    sceneManager.loadScene(initialScene);
=======
    //Move button initialization
    basementScene.addMoveButton(new PVector(270, 175), new PVector(64, 64), hallwayScene, magnifier);
    basementScene.addMoveButton(new PVector(570, 215), new PVector(64, 64), magnifier, GameState.PipeGame);
    hallwayScene.addMoveButton(new PVector(490, 530), new PVector(64, 64), basementScene, magnifier);
    hallwayScene.addMoveButton(new PVector(775, 320), new PVector(64, 64), kitchenScene, magnifier);
    hallwayScene.addMoveButton(new PVector(430, 290), new PVector(64, 64), storageScene, magnifier);
    kitchenScene.addMoveButton(new PVector(100, 400), new PVector(64, 64), hallwayScene, magnifier);
    storageScene.addMoveButton(new PVector(width/2, 550), new PVector(64, 64), hallwayScene, magnifier);

    //Item button initialization

    //Text button initialization
    hallwayScene.addTextButton(new PVector(270, 250), new PVector(64, 64), magnifier, hallwayWoodBeam);

    //Load first scene
    sceneManager.loadScene(basementScene);

    //Pipe Game initialization
    for(int rows = 0; rows < gridHeight; rows++)
    {
        int yPos = 170 + (gridBoxSize * rows);
        for(int column = 0; column < gridWidth; column++)
        {
            int xPos = 217 + (gridBoxSize * column);
            pipeHolders.add(new PipeHolder(new PVector(xPos, yPos)));
        }
    }
    PipeHolder ph = pipeHolders.get(0);
    usedLayout = (int)(random(0, 2));
    for(int i = 0; i < pipeHolders.size(); i++)
    {
        PipeHolder pH = pipeHolders.get(i);
        switch(pipeLayouts[usedLayout][i])
        {
            case 0:
                pH.heldPipe = new CornerPipe(pH.position, (int)(random(0, 4)), i, cornerPipeImages);
                break;
            case 1:
                pH.heldPipe = new StraightPipe(pH.position, (int)(random(4, 6)), i, straightPipeImages);
                break;
        }
    }
>>>>>>> Stashed changes
}

void draw() 
{
    background(0);
    sceneManager.draw();
    inventory.drawInventory();
}

void mousePressed() 
{
    if(allowMouseClick) sceneManager.mouseClick();
    allowMouseClick = false;
}

void mouseReleased()
{
    allowMouseClick = true;
}
