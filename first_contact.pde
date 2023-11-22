enum GameState{Scenes, PipeGame, JarGame, CookGame, MainMenu};

//Framework Variables
GameState gameState = GameState.Scenes;
SceneManager sceneManager;
Scene currentScene;
Scene initialScene;
Scene room1Scene;
PImage img1;
PImage img2;
PImage magnifier;
Inventory inventory;
Item glass;

//Pipe Game Variables
int gridWidth = 5;
int gridHeight = 3;
static int gridBoxSize = 133;
ArrayList<PipeHolder> pipeHolders = new ArrayList<PipeHolder>();
PImage background;
PImage straightPipeUpDown;
PImage straightPipeLeftRight;
PImage[] straightPipeImages = new PImage[2];
PImage[] cornerPipeImages = new PImage[4];

//Universal Variables
boolean allowMouseClick = true;

void setup()
{
    size(1000, 600);
    img1 = loadImage("Images/basement.png");
    img2 = loadImage("Factory1.png");
    magnifier = loadImage("magnifier.png");
    sceneManager = new SceneManager();
    inventory = new Inventory(3, 100, 10);
    glass = new Item(magnifier);

    room1Scene = new Scene(img2);
    initialScene = new Scene(img1);

    room1Scene.addMoveButton(new PVector(200, 400), new PVector(64, 64), initialScene, magnifier, glass);
    room1Scene.addMoveButton(new PVector(500, 400), new PVector(64, 64), magnifier, GameState.PipeGame);
    initialScene.addMoveButton(new PVector(400, 600), new PVector(100, 120), room1Scene);

    room1Scene.addItemButton(new PVector(400, 200), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(300, 400), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(600, 100), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(700, 500), new PVector(32, 32), glass);
    room1Scene.addItemButton(new PVector(771, 661), new PVector(32, 32), glass);

    sceneManager.loadScene(initialScene);

    //Pipe Game Images
    background = loadImage("pipeBackground.png");
    straightPipeImages[0] = loadImage("Pipe_Straight_UpDown.png");
    straightPipeImages[1] = loadImage("Pipe_Straight_LeftRight.png");
    cornerPipeImages[0] = loadImage("Pipe_Corner_SouthEast.png");
    cornerPipeImages[1] = loadImage("Pipe_Corner_SouthWest.png");
    cornerPipeImages[2] = loadImage("Pipe_Corner_NorthEast.png");
    cornerPipeImages[3] = loadImage("Pipe_Corner_NorthWest.png");

    //Pipe Game Init
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
}

void mouseReleased()
{
    allowMouseClick = true;
}

void drawScenes()
{
    sceneManager.draw();
    inventory.drawInventory();
}

void pipeGame()
{
    background(0);
    image(background, 0, 0, width, height);
    for(PipeHolder pHolder : pipeHolders)
    {
        pHolder.drawHolder();
    }
}
