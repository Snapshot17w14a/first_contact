enum GameState{Scenes, PipeGame, JarGame, CookGame, MainMenu};

//Framework Variables
GameState gameState = GameState.Scenes;
SceneManager sceneManager;
Scene currentScene;
Scene basementScene;
Scene hallwayScene;
Scene kitchenScene;
Scene storageScene;
Scene winScene;
PImage basementBackground;
PImage hallwayBackground;
PImage kitchenBackground;
PImage storageBackground;
PImage winBackground;
PImage magnifier;
PImage keyImage;
Inventory inventory;
Item glass;
Item pipeKey;
Item cookKey;
Item jarKey;
TextBox hallwayWoodBeam;

//Pipe Game Variables
int gridWidth = 5;
int gridHeight = 3;
int usedLayout;
static int gridBoxSize = 133;
ArrayList<PipeHolder> pipeHolders = new ArrayList<PipeHolder>();
PImage pipeGameBackground;
PImage straightPipeUpDown;
PImage straightPipeLeftRight;
PImage[] straightPipeImages = new PImage[2];
PImage[] cornerPipeImages = new PImage[4];
int[][] pipeLayouts = {{1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0}, {0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1}};
int[][] pipeSolutions = {{5, 1, -1, 0, 1, -1, 4, 0, 2, 4, -1, 3, 2, -1, 3}, {1, 0, 5, 5, 1, 4, 4, -1, 0, 2, 3, 2, -1, 3, 5}};
int[] correctCountAmount = {11, 13};

//Universal Variables
boolean allowMouseClick = true;

//String Variables
String blockedWay = "The pathway to the top floor seems to be blocked by a huge wooden beam!";

void setup()
{
    size(1000, 600);
    //Background images
    basementBackground = loadImage("basementBackground.png");
    hallwayBackground = loadImage("hallwayBackground.png");
    kitchenBackground = loadImage("kitchenBackground.png");
    storageBackground = loadImage("storageBackground.png");
    winBackground = loadImage("Factory1.png");

    //Item images
    magnifier = loadImage("magnifier.png");
    keyImage = loadImage("key.png");

    //PipeGame images
    pipeGameBackground = loadImage("pipeBackground.png");
    straightPipeImages[0] = loadImage("Pipe_Straight_UpDown.png");
    straightPipeImages[1] = loadImage("Pipe_Straight_LeftRight.png");
    cornerPipeImages[0] = loadImage("Pipe_Corner_SouthEast.png");
    cornerPipeImages[1] = loadImage("Pipe_Corner_SouthWest.png");
    cornerPipeImages[2] = loadImage("Pipe_Corner_NorthEast.png");
    cornerPipeImages[3] = loadImage("Pipe_Corner_NorthWest.png");

    //SceneManager initialization
    sceneManager = new SceneManager();

    //Inventory initializatiob
    inventory = new Inventory(3, 100, 10);

    //Item initialization
    glass = new Item(magnifier);
    pipeKey = new Item(keyImage);
    cookKey = new Item(keyImage);
    jarKey = new Item(keyImage);

    //Scene initialization
    basementScene = new Scene(basementBackground);
    hallwayScene = new Scene(hallwayBackground);
    kitchenScene = new Scene(kitchenBackground);
    storageScene = new Scene(storageBackground);
    winScene = new Scene(winBackground);

    //TextBox initialization
    hallwayWoodBeam = hallwayScene.createTextBox(blockedWay);

    //Move button initialization
    basementScene.addMoveButton(new PVector(270, 175), new PVector(64, 64), hallwayScene, magnifier);
    basementScene.addMoveButton(new PVector(570, 215), new PVector(64, 64), magnifier, GameState.PipeGame);
    hallwayScene.addMoveButton(new PVector(490, 530), new PVector(64, 64), basementScene, magnifier);
    hallwayScene.addMoveButton(new PVector(775, 320), new PVector(64, 64), kitchenScene, magnifier);
    hallwayScene.addMoveButton(new PVector(430, 290), new PVector(64, 64), storageScene, magnifier);
    hallwayScene.addExitButton(new PVector(550, 245), new PVector(64, 64), keyImage, winScene);
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
}

void draw() 
{
    background(0);
    if(gameState == GameState.Scenes) {drawScenes();}
    if(gameState == GameState.PipeGame) {pipeGame();}
}


//Mouse click handling
void mousePressed() 
{
    switch(gameState)
    {
        case Scenes:
            if(allowMouseClick) sceneManager.mouseClick();
            break;
        case PipeGame:
            if(allowMouseClick)
            {
                allowMouseClick = false;
                for(PipeHolder pH : pipeHolders)
                {
                    if(pH.isOverHeldPipe())
                    {
                        pH.heldPipe.rotatePipe();
                    }
                }
            }
            break;
    }
    allowMouseClick = false;
    println("x: " + mouseX + " | " + "y: " + mouseY);
}
void mouseReleased()
{
    allowMouseClick = true;
}

//PxC gameloop
void drawScenes()
{
    sceneManager.draw();
    inventory.drawInventory();
}

//PipeGame gameloop
void pipeGame()
{
    int correctCount = 0;
    background(0);
    image(pipeGameBackground, 0, 0, width, height);
    for(PipeHolder pHolder : pipeHolders)
    {
        pHolder.drawHolder();
    }
    for(int i = 0; i < pipeHolders.size(); i++)
    {
        PipeHolder pHolder = pipeHolders.get(i);
        if(pipeSolutions[usedLayout][i] != -1 && pipeSolutions[usedLayout][i] == pHolder.heldPipe.pipeRotationNum)
        {
            correctCount++;
        }
    }
    if(correctCount == correctCountAmount[usedLayout])
    {
        sceneManager.loadScene(basementScene);
        gameState = GameState.Scenes;
        basementScene.sceneButtons.remove(1);
        inventory.heldItems.add(pipeKey);
    }
}
