import processing.sound.*;

enum GameState{Scenes, PipeGame, JarGame, CookGame, MainMenu, WinMenu};

//Framework Variables
GameState gameState = GameState.MainMenu;
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
PImage mainMenuBackground;
PImage magnifier;
PImage keyImage;
Inventory inventory;
Item glass;
Item pipeKey;
Item cookKey;
Item jarKey;
TextBox hallwayWoodBeam;
SoundFile mainMenuMusic;
SoundFile gameMusic;
SoundFile grabObject;
SoundFile mainDoorUnlock;
SoundFile pipeGameVictory;
SoundFile correctChime;
SoundFile[] roomTransitions = new SoundFile[3];
boolean isHowToPlay = false;
boolean isWinMenu = false;
boolean isMainMenuLooped = false;
boolean isgameMusicLooped = false;

//PipeGame Variables
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
boolean isPipeGameOver = false;

//JarGame Variables
int jarCount = 5;
Jar[] correctJarOrder;
Jar[] randomJarOrder;
Jar selectedJar;
boolean allowClick = true;
boolean isJarAvailable = false;
JarButton moveLeft;
JarButton moveRight;
PImage jarArrowLeft;
PImage jarArrowRight;
PImage jarImage;

//Universal Variables
int targetMilliseconds;
boolean allowMouseClick = true;
boolean isDelaySet = false;
PFont baseFont;
PFont titleFont;

//Menu Variables
PVector playButtonPosition = new PVector(715, 400);
PVector howToButtonPosition = new PVector(750, 490);
PVector backButtonPosition = new PVector(900, 540);
PVector mainmenuButtonPosition = new PVector(400, 550);
PVector quitButtonPosition = new PVector(600, 550);

//String Variables
String blockedWay = "The pathway to the top floor seems to be blocked by a huge wooden beam!";

void setup()
{
    size(1000, 600);
    //Load Music
    mainMenuMusic = new SoundFile(this, "Title_screen_soundtrack.wav");
    gameMusic = new SoundFile(this, "Soundtrack_v.3.wav");
    grabObject = new SoundFile(this, "grabbing_object.wav");
    mainDoorUnlock = new SoundFile(this, "door_unlock.wav");
    pipeGameVictory = new SoundFile(this, "water_puzzle_complete.wav");
    correctChime = new SoundFile(this, "correct_chime.wav");
    roomTransitions[0] = new SoundFile(this, "door_1.wav");
    roomTransitions[1] = new SoundFile(this, "door_2.wav");
    roomTransitions[2] = new SoundFile(this, "door_3.wav");

    //Load fonts
    baseFont = createFont("monbaiti.ttf", 24);
    titleFont = createFont("lucindablack.ttf", 96);
    
    //Background images
    basementBackground = loadImage("basementBackground.png");
    hallwayBackground = loadImage("hallwayBackground.png");
    kitchenBackground = loadImage("kitchenBackground.png");
    storageBackground = loadImage("storageBackground.png");
    mainMenuBackground = loadImage("mainMenu.png");
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
    storageScene.addMoveButton(new PVector(265, 300), new PVector(64, 64), magnifier, GameState.JarGame);

    //Item button initialization
    kitchenScene.addItemButton(new PVector(510, 200), new PVector(64, 64), cookKey);

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

    //JarGame Initialization
    jarArrowLeft = loadImage("left_arrow.png");
    jarArrowRight = loadImage("right_arrow.png");
    jarImage = loadImage("jar.png");
    correctJarOrder = new Jar[jarCount];
    randomJarOrder = new Jar[jarCount];
    for(int i = 0; i < jarCount; i++)
    {
        correctJarOrder[i] = new Jar(new PVector(100, 200 + (i * 10)), i, jarImage);
    }
    for(int i = 0; i < jarCount; i++)
    {
        scrambleJars(i);
    }
    moveRight = new JarButton(jarArrowRight, new PVector(700, 500));
    moveLeft = new JarButton(jarArrowLeft, new PVector(300, 500));
    selectedJar = null;
}

void draw() 
{
    background(0);
    println(frameRate);
    if(gameState == GameState.Scenes) {drawScenes(); return;}
    if(gameState == GameState.PipeGame) {pipeGame(); return;}
    if(gameState == GameState.JarGame) {jarGame(); return;}
    if(gameState == GameState.MainMenu) {mainMenu(); return;}
    if(gameState == GameState.WinMenu) {winMenu(); return;}
}

//Mouse click handling
void mousePressed() 
{
    if(allowMouseClick)
    {
        switch(gameState)
        {
            case Scenes:
                sceneManager.mouseClick();
                break;
            case PipeGame:
                allowMouseClick = false;
                for(PipeHolder pH : pipeHolders)
                {
                    if(pH.isOverHeldPipe() && !isPipeGameOver)
                    {
                        pH.heldPipe.rotatePipe();
                    }
                }
                break;
            case JarGame:
                if(isJarAvailable && moveRight.isOverJarButton()) {moveRight.moveRight(selectedJar.jarPosition);}
                else if(isJarAvailable && moveLeft.isOverJarButton()) {moveLeft.moveLeft(selectedJar.jarPosition);}
                else if(isJarAvailable) {selectedJar.isJarSelected = false; selectedJar = null;}
                else 
                {
                    for(Jar jar : correctJarOrder)
                    {
                        if(jar.isOverJar())
                        {
                            selectedJar = jar;
                            jar.isJarSelected = true;
                        }
                    }
                }
                break;
            case MainMenu:
            case WinMenu:
                checkMenuClick();
                break;
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
        isPipeGameOver = true;
        if(!isDelaySet) {setupDelay((int)(pipeGameVictory.duration())); pipeGameVictory.play(); correctChime.play();}
        if(isDelayOver())
        {
            sceneManager.loadScene(basementScene);
            gameState = GameState.Scenes;
            basementScene.sceneButtons.remove(1);
            inventory.heldItems.add(pipeKey);
            grabObject.play();
        }
    }
}

//JarGame gameloop
void jarGame()
{
    background(128);
    for(Jar jar : correctJarOrder)
    {
        jar.drawJar();
    }
    if(selectedJar != null)
    {
        isJarAvailable = true;
        moveRight.drawArrow();
        moveLeft.drawArrow();
    }
    else
    {
        isJarAvailable = false;
    }
    int correctCount = 0;
    for(Jar jar : correctJarOrder)
    {
        if(jar.isInCorrectSpot == true) correctCount++;
    }
    textAlign(CENTER, CENTER);
    if(correctCount == 5)
    {
        sceneManager.loadScene(storageScene);
        gameState = GameState.Scenes;
        storageScene.sceneButtons.remove(1);
        inventory.heldItems.add(jarKey);
        isDelaySet = false;
    }
}

void scrambleJars(int index)
{
    int correctArrayIndex = index;
    int randomArrayIndex;
    do{randomArrayIndex = (int)(random(0, jarCount));}
    while(randomJarOrder[randomArrayIndex] != null);
    randomJarOrder[randomArrayIndex] = correctJarOrder[correctArrayIndex];
    randomJarOrder[randomArrayIndex].jarPosition = randomArrayIndex;
}

//Main Menu logic
void mainMenu()
{
    if(!isMainMenuLooped) {isMainMenuLooped = true; mainMenuMusic.loop();}
    imageMode(CENTER);
    background(mainMenuBackground);
    strokeWeight(2);
    fill(#ff0000);
    rectMode(CENTER);
    if(!isHowToPlay)
    {
        rect(playButtonPosition.x, playButtonPosition.y, 250, 70, 10);
        fill(#00ff00);
        rect(howToButtonPosition.x, howToButtonPosition.y, 150, 50, 5);
        textAlign(CENTER, CENTER);
        textFont(baseFont, 36);
        fill(#000000);
        text("Play", playButtonPosition.x, playButtonPosition.y);
        textFont(baseFont, 24);
        text("How to play", howToButtonPosition.x, howToButtonPosition.y);
        textAlign(LEFT, CENTER);
        textFont(titleFont, 94);
        text("Phantom Liberation", 20, 160);
        fill(#ff0000);
        text("Phantom Liberation", 16, 156);
    }
    else
    {
        rect(backButtonPosition.x, backButtonPosition.y, 100, 50, 5);
        fill(#000000);
        textAlign(CENTER, CENTER);
        textFont(baseFont, 24);
        text("Back", backButtonPosition.x, backButtonPosition.y);
        textAlign(LEFT, CENTER);
        textFont(titleFont, 36);
        text("Phantom Liberation", 20, 40);
        fill(#ff0000);
        text("Phantom Liberation", 18, 38);
        fill(128, 128, 128, 196);
        rect(width/2, height/2, 900, 400);
        textAlign(LEFT, TOP);
        fill(0);
        textFont(baseFont, 24);
        text("do puzzles, get keys and escape", width/2, height/2, 890, 390);
    }
}

void checkMenuClick()
{
    if(isHowToPlay && mouseX < backButtonPosition.x + 100/2 && mouseX > backButtonPosition.x - 100/2 && mouseY < backButtonPosition.y + 50/2 && mouseY > backButtonPosition.y - 50/2)
    {
        isHowToPlay = false;
    }
    if(!isHowToPlay && mouseX < playButtonPosition.x + 250/2 && mouseX > playButtonPosition.x - 250/2 && mouseY < playButtonPosition.y + 70/2 && mouseY > playButtonPosition.y - 70/2)
    {
        gameState = GameState.Scenes;
        mainMenuMusic.stop();
        gameMusic.loop();
    }
    else if(!isHowToPlay && mouseX < howToButtonPosition.x + 150/2 && mouseX > howToButtonPosition.x - 150/2 && mouseY < howToButtonPosition.y + 50/2 && mouseY > howToButtonPosition.y - 50/2)
    {
        isHowToPlay = true;
    }
    if(isWinMenu && mouseX < mainmenuButtonPosition.x + 180/2 && mouseX > mainmenuButtonPosition.x - 180/2 && mouseY < mainmenuButtonPosition.y + 50/2 && mouseY > mainmenuButtonPosition.y - 50/2)
    {
        resetGame();
        gameState = GameState.MainMenu;
        isWinMenu = false;
    }
    if(isWinMenu && mouseX < quitButtonPosition.x + 180/2 && mouseX > quitButtonPosition.x - 180/2 && mouseY < quitButtonPosition.y + 50/2 && mouseY > quitButtonPosition.y - 50/2)
    {
        exit();
    }
}

void winMenu()
{
    strokeWeight(2);
    imageMode(CENTER);
    background(mainMenuBackground);
    fill(#00ff00);
    rectMode(CENTER);
    rect(mainmenuButtonPosition.x, mainmenuButtonPosition.y, 180, 50, 5);
    fill(#ff0000);
    rect(quitButtonPosition.x, quitButtonPosition.y, 180, 50, 5);
    textFont(titleFont, 96);
    fill(0);
    text("You escaped!\nYour soul is now free!", width/2, 150);
    fill(#ff0000);
    text("You escaped!\nYour soul is now free!", width/2-4, 146);
    textFont(baseFont, 24);
    fill(0);
    text("Main Menu", mainmenuButtonPosition.x, mainmenuButtonPosition.y);
    text("Quit", quitButtonPosition.x, quitButtonPosition.y);
}

void resetGame()
{
    sceneManager.loadScene(basementScene);
    basementScene.addMoveButton(new PVector(570, 215), new PVector(64, 64), magnifier, GameState.PipeGame);
    storageScene.addMoveButton(new PVector(265, 300), new PVector(64, 64), magnifier, GameState.JarGame);
    kitchenScene.addItemButton(new PVector(510, 200), new PVector(64, 64), cookKey);
    correctJarOrder = new Jar[jarCount];
    randomJarOrder = new Jar[jarCount];
    for(int i = 0; i < jarCount; i++)
    {
        correctJarOrder[i] = new Jar(new PVector(100, 200 + (i * 10)), i, jarImage);
    }
    for(int i = 0; i < jarCount; i++)
    {
        scrambleJars(i);
    }
    selectedJar = null;
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
    isPipeGameOver = false;
}

boolean isDelayOver()
{
    return millis() >= targetMilliseconds;
}

void setupDelay(int secondsToDelay)
{
    targetMilliseconds = millis() + secondsToDelay*1000;
    isDelaySet = true;
}