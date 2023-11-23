enum GameState{Scenes, PipeGame, JarGame, CookGame, MainMenu};

//Framework Variables
GameState gameState = GameState.Scenes;
SceneManager sceneManager;
Scene currentScene;
Scene basementScene;
Scene hallwayScene;
Scene kitchenScene;
PImage basementBackground;
PImage hallwayBackground;
PImage kitchenBackground;
PImage magnifier;
Inventory inventory;
Item glass;
TextBox hallwayWoodBeam;

//Pipe Game Variables
int gridWidth = 5;
int gridHeight = 3;
static int gridBoxSize = 133;
ArrayList<PipeHolder> pipeHolders = new ArrayList<PipeHolder>();
PImage pipeGameBackground;
PImage straightPipeUpDown;
PImage straightPipeLeftRight;
PImage[] straightPipeImages = new PImage[2];
PImage[] cornerPipeImages = new PImage[4];

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

    //Item images
    magnifier = loadImage("magnifier.png");

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

    //Scene initialization
    basementScene = new Scene(basementBackground);
    hallwayScene = new Scene(hallwayBackground);
    kitchenScene = new Scene(kitchenBackground);

    //TextBox initialization
    hallwayWoodBeam = hallwayScene.createTextBox(blockedWay);

    //Move button initialization
    basementScene.addMoveButton(new PVector(270, 175), new PVector(64, 64), hallwayScene, magnifier);
    hallwayScene.addMoveButton(new PVector(490, 530), new PVector(64, 64), basementScene, magnifier);
    hallwayScene.addMoveButton(new PVector(775, 320), new PVector(64, 64), kitchenScene, magnifier);
    kitchenScene.addMoveButton(new PVector(100, 400), new PVector(64, 64), hallwayScene, magnifier);
    

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
    for(int i = 0; i < pipeHolders.size(); i++)
    {
        PipeHolder pH = pipeHolders.get(i);
        int pipeType = (int)(random(0, 2));
        switch(pipeType)
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
    if(allowMouseClick) sceneManager.mouseClick();
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
    background(0);
    image(pipeGameBackground, 0, 0, width, height);
    for(PipeHolder pHolder : pipeHolders)
    {
        pHolder.drawHolder();
    }
}
