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

    sceneManager.loadScene(initialScene);
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
