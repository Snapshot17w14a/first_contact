import processing.sound.*;

enum GameState{Scenes, PipeGame, JarGame, StoryScreen, MainMenu, WinMenu, DeathMenu};

//Framework Variables
GameState gameState = GameState.MainMenu;
SceneManager sceneManager;
Cake cake;
Scene currentScene;
Scene basementScene;
Scene hallwayScene;
Scene kitchenScene;
Scene storageScene;
Scene jarHint;
Scene pipeHint;
Scene kitchenHint;
PImage basementScatteredBackground;
PImage basementCompletedBackground;
PImage hallwayBackground;
PImage kitchenBackground;
PImage storageBackground;
PImage winBackground;
PImage mainMenuBackground;
PImage jarHintBackground;
PImage pipeHintBackground;
PImage kitchenHintBackground;
PImage deathBackground;
PImage jarGameBackground;
PImage magnifier;
PImage keyImage;
PImage bowl;
PImage fullBowlImage;
PImage jarHintPaper;
PImage pipeHintPaper;
PImage kitchenHintPaper;
PImage ovenHeat;
PImage inventoryImage;
PImage lockedDoorImage;
PImage[] cookGameItems = new PImage[5];
Inventory inventory;
Item glass;
Item fullBowl;
Item pipeKey;
Item cookKey;
Item jarKey;
Item[] cookItems = new Item[5];
TextBox hallwayWoodBeam;
TextBox fullInventoryNotification;
TextBox keysMissing;
TextBox missingIngredients;
TextBox missingBowl;
TextBox cleanerTextbox;
TextBox pipeTextBox;
TextBox cookKeyFound;
SoundFile mainMenuMusic;
SoundFile gameMusic;
SoundFile grabObject;
SoundFile mainDoorUnlock;
SoundFile pipeGameVictory;
SoundFile correctChime;
SoundFile pipeSound;
SoundFile keysPickup;
SoundFile lockedDoor;
SoundFile whisper;
SoundFile click;
SoundFile notePickup;
SoundFile ovenFinished;
SoundFile[] jarSlides = new SoundFile[2];
SoundFile[] roomTransitions = new SoundFile[3];
boolean isHowToPlay = false;
boolean isWinMenu = false;
boolean isMainMenuLooped = false;
boolean isgameMusicLooped = false;
boolean isStoryScreen = false;
boolean isGameplayTimerSet = false;
int gameplaySeconds = 300;
int gameEndMilliseconds;

//PipeGame Variables
int gridWidth = 5;
int gridHeight = 3;
int usedLayout;
static int gridBoxSize = 145;
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
boolean isJarGameOver = false;
JarButton moveLeft;
JarButton moveRight;
PImage jarArrowLeft;
PImage jarArrowRight;
PImage jarArrowUp;
PImage jarArrowDown;
PImage[] jarImages = new PImage[5];

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
String fullInventory = "The burden of carrying this would be too much for your fragile soul.";
String keysText = "You have not found all the keys requiered to free your soul, go search for them before the clock hits 8am!";
String missingIngredientsText = "You do not have any ingredients to put in the bowl at this moment!";
String missingBowlText = "You do not have anything on you that needs cooking.";
String cookKeyText = "While preparing the cake for you long lost shef friend you notice a key hanging from the heatin element of the oven.";
String cleanerKeyPosition = "Cleaner's soul:\nThank you for organizing those jars my friend, it has been bothering my soul for a century. One of the keys for the main door is in the basket next to the winerack.";
String pipeText = "After connecting the pipes you notice that the waterflow pushed a key out of the drain pipe.";
String[] introText;

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
    pipeSound = new SoundFile(this, "pipeRotating.wav");
    keysPickup = new SoundFile(this, "keys_pickup.wav");
    lockedDoor = new SoundFile(this, "Locked_door.wav");
    whisper = new SoundFile(this, "ghostWhisper.wav");
    click = new SoundFile(this, "click.wav");
    notePickup = new SoundFile(this, "notePickup.wav");
    ovenFinished = new SoundFile(this, "ovenFinished.wav");
    jarSlides[0] = new SoundFile (this, "jarSlide1.wav");
    jarSlides[1] = new SoundFile (this, "jarSlide2.wav");
    roomTransitions[0] = new SoundFile(this, "door_1.wav");
    roomTransitions[1] = new SoundFile(this, "door_2.wav");
    roomTransitions[2] = new SoundFile(this, "door_3.wav");

    //Load fonts
    baseFont = createFont("monbaiti.ttf", 24);
    titleFont = createFont("lucindablack.ttf", 96);

    //Load .txt-s
    introText = loadStrings("introtext.txt");
    
    //Background images
    basementScatteredBackground = loadImage("BasementScattered.png");
    basementCompletedBackground = loadImage("BasementCompleted.png");
    hallwayBackground = loadImage("hallwayBackground.png");
    kitchenBackground = loadImage("kitchenBackground.png");
    storageBackground = loadImage("storageBackground.png");
    mainMenuBackground = loadImage("mainMenu.png");
    jarHintBackground = loadImage("jarHintBackground.png");
    pipeHintBackground = loadImage("pipeHintBackground.png");
    kitchenHintBackground = loadImage("kitchenHintBackground.png");
    deathBackground = loadImage("deathBackground.png");
    jarGameBackground = loadImage("jarGameBackground.png");

    //Item images
    kitchenHintPaper = loadImage("kitchenHint.png");
    jarHintPaper = loadImage("jarHint.png");
    pipeHintPaper = loadImage("pipeHint.png");
    ovenHeat = loadImage("oven.png");
    magnifier = loadImage("magnifyingGlass.png");
    keyImage = loadImage("key.png");
    bowl = loadImage("bowl.png");
    fullBowlImage = loadImage("fullBowlItem.png");
    inventoryImage = loadImage("inventory.png");
    lockedDoorImage = loadImage("lockedDoor.png");
    cookGameItems[0] = loadImage("water.png");
    cookGameItems[1] = loadImage("honey.png");
    cookGameItems[2] = loadImage("flour.png");
    cookGameItems[3] = loadImage("bakingPowder.png");
    cookGameItems[4] = loadImage("sugar.png");


    //PipeGame images
    pipeGameBackground = loadImage("pipeBackground.png");
    straightPipeImages[0] = loadImage("pipeUpDown.png");
    straightPipeImages[1] = loadImage("pipeLeftRight.png");
    cornerPipeImages[0] = loadImage("pipeSouthEast.png");
    cornerPipeImages[1] = loadImage("pipeSouthWest.png");
    cornerPipeImages[2] = loadImage("pipeNorthEast.png");
    cornerPipeImages[3] = loadImage("pipeNorthWest.png");

    //JarGame images
    jarArrowLeft = loadImage("left_arrow.png");
    jarArrowRight = loadImage("right_arrow.png");
    jarArrowUp = loadImage("upArrow.png");
    jarArrowDown = loadImage("downArrow.png");
    jarImages[0] = loadImage("jar5.png");
    jarImages[1] = loadImage("jar4.png");
    jarImages[2] = loadImage("jar3.png");
    jarImages[3] = loadImage("jar2.png");
    jarImages[4] = loadImage("jar1.png");

    //SceneManager initialization
    sceneManager = new SceneManager();

    //Inventory initializatiob
    inventory = new Inventory(3, 100, 10);
    fullInventoryNotification = new TextBox(fullInventory, currentScene);

    //Item initialization
    glass = new Item(magnifier);
    pipeKey = new Item(keyImage);
    cookKey = new Item(keyImage);
    jarKey = new Item(keyImage);
    fullBowl = new Item(fullBowlImage);
    cookItems[0] = new Item(cookGameItems[0]);
    cookItems[1] = new Item(cookGameItems[1]);
    cookItems[2] = new Item(cookGameItems[2]);
    cookItems[3] = new Item(cookGameItems[3]);
    cookItems[4] = new Item(cookGameItems[4]);

    //Scene initialization
    basementScene = new Scene(basementScatteredBackground);
    hallwayScene = new Scene(hallwayBackground);
    kitchenScene = new Scene(kitchenBackground);
    storageScene = new Scene(storageBackground);
    kitchenHint = new Scene(kitchenHintBackground, true, kitchenScene);
    jarHint = new Scene(jarHintBackground, true, GameState.JarGame);
    pipeHint = new Scene(pipeHintBackground, true, GameState.PipeGame);

    //TextBox initialization
    pipeTextBox = basementScene.createTextBox(pipeText);
    hallwayWoodBeam = hallwayScene.createTextBox(blockedWay);
    keysMissing = hallwayScene.createTextBox(keysText);
    missingIngredients = kitchenScene.createTextBox(missingIngredientsText);
    missingBowl = kitchenScene.createTextBox(missingBowlText);
    cleanerTextbox = storageScene.createTextBox(cleanerKeyPosition);
    cookKeyFound = kitchenScene.createTextBox(cookKeyText);

    //Move button initialization
    basementScene.addMoveButton(new PVector(358, 128), new PVector(48, 48), hallwayScene, jarArrowUp);
    basementScene.addMoveButton(new PVector(455, 225), new PVector(64, 64), pipeHint, pipeHintPaper, notePickup);
    hallwayScene.addMoveButton(new PVector(490, 530), new PVector(48, 48), basementScene, jarArrowDown);
    hallwayScene.addMoveButton(new PVector(769, 257), new PVector(48, 48), kitchenScene, jarArrowRight);
    hallwayScene.addMoveButton(new PVector(418, 252), new PVector(48, 48), storageScene, jarArrowLeft);
    hallwayScene.addExitButton(new PVector(524, 251), new PVector(64, 64), lockedDoorImage);
    kitchenScene.addMoveButton(new PVector(155, 281), new PVector(48, 48), hallwayScene, jarArrowLeft);
    kitchenScene.addMoveButton(new PVector(270, 373), new PVector(64, 64), kitchenHint, kitchenHintPaper, notePickup);
    storageScene.addMoveButton(new PVector(width/2, 550), new PVector(48, 48), hallwayScene, jarArrowDown);
    storageScene.addMoveButton(new PVector(285, 354), new PVector(64, 64), jarHint, jarHintPaper, notePickup);
    cake = new Cake(new PVector(359, 250), new PVector(64, 64), bowl, kitchenScene.sceneButtons);
    kitchenScene.sceneButtons.add(cake);

    //Cook game initialization
    cake.itemsNeeded = cookItems;
    kitchenScene.sceneButtons.add(new Oven(new PVector(576, 317), new PVector(80, 64), ovenHeat));
    hideIngredients();

    //Text button initialization
    hallwayScene.addTextButton(new PVector(168, 192), new PVector(64, 64), magnifier, hallwayWoodBeam);

    //Load first scene
    sceneManager.currentScene = basementScene;
    fullInventoryNotification.parentScene = basementScene;
    basementScene.sceneTexts.add(fullInventoryNotification);

    //Pipe Game initialization
    for(int rows = 0; rows < gridHeight; rows++)
    {
        int yPos = 170 + (gridBoxSize * rows);
        for(int column = 0; column < gridWidth; column++)
        {
            int xPos = 220 + (gridBoxSize * column);
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
    correctJarOrder = new Jar[jarCount];
    randomJarOrder = new Jar[jarCount];
    for(int i = 0; i < jarCount; i++) correctJarOrder[i] = new Jar(new PVector(200, 200), i, jarImages[i]);
    for(int i = 0; i < jarCount; i++) scrambleJars(i);
    moveRight = new JarButton(jarArrowRight, new PVector(700, 500));
    moveLeft = new JarButton(jarArrowLeft, new PVector(300, 500));
    selectedJar = null;
}

void draw() 
{
    background(0);
    if(isGameplayTimerSet && millis() >= gameEndMilliseconds) 
    {
        gameState = GameState.DeathMenu;
        isGameplayTimerSet = false;
        resetGame();
        return;
    }
    switch(gameState)
    {
        case Scenes:
            drawScenes();
            fill(#2FAD87);
            textAlign(RIGHT, CENTER);
            textFont(baseFont, 24);
            if(!(millis() >= gameEndMilliseconds)) text("Seconds left until daytime: " + (int)((gameEndMilliseconds - millis()) / 1000), 980, 20);
            return;
        case PipeGame:
            pipeGame();
            return;
        case JarGame:
            jarGame();
            return;
        case MainMenu:
            mainMenu();
            return;
        case WinMenu:
            winMenu();
            return;
        case StoryScreen:
            storyScreen();
            return;
        case DeathMenu:
            deathMenu();
            return;
    }
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
                if(mouseX < 975 && mouseX > 925 && mouseY < 575 && mouseY > 525) {sceneManager.loadScene(basementScene); gameState = GameState.Scenes;}
                for(PipeHolder pH : pipeHolders)
                {
                    if(pH.isOverHeldPipe() && !isPipeGameOver)
                    {
                        pH.heldPipe.rotatePipe();
                    }
                }
                break;
            case JarGame:
                if(mouseX < 975 && mouseX > 925 && mouseY < 575 && mouseY > 525) {sceneManager.loadScene(storageScene); gameState = GameState.Scenes;}
                else if(!isJarGameOver)
                {
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
                }
                break;
            case MainMenu:
            case WinMenu:
            case StoryScreen:
            case DeathMenu:
                checkMenuClick();
                break;
        }
    }
    allowMouseClick = false;
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
    background(pipeGameBackground);
    rectMode(CENTER);
    fill(255, 0, 0, 128);
    strokeWeight(4);
    rect(950, 550, 50, 50);
    imageMode(CENTER);
    image(jarArrowDown, 950, 550, 40, 40);
    imageMode(CORNER);
    for(PipeHolder pHolder : pipeHolders) pHolder.drawHolder();
    for(int i = 0; i < pipeHolders.size(); i++)
    {
        PipeHolder pHolder = pipeHolders.get(i);
        if(pipeSolutions[usedLayout][i] != -1 && pipeSolutions[usedLayout][i] == pHolder.heldPipe.pipeRotationNum) correctCount++;
    }
    if(correctCount == correctCountAmount[usedLayout])
    {
        isPipeGameOver = true;
        if(!isDelaySet) {setupDelay((int)(pipeGameVictory.duration())); pipeGameVictory.play(); correctChime.play();}
        else if(isDelayOver())
        {
            sceneManager.loadScene(basementScene);
            gameState = GameState.Scenes;
            basementScene.sceneButtons.remove(1);
            isDelaySet = false;
            basementScene.addItemButton(new PVector(753, 319), new PVector(64, 64), pipeKey, true);
            pipeTextBox.toggleRender();
            basementScene.background = basementCompletedBackground;
        }
    }
}

//JarGame gameloop
void jarGame()
{
    background(jarGameBackground);
    rectMode(CENTER);
    fill(255, 0, 0, 128);
    strokeWeight(4);
    rect(950, 550, 50, 50);
    imageMode(CENTER);
    image(jarArrowDown, 950, 550, 40, 40);
    imageMode(CORNER);
    for(Jar jar : correctJarOrder) jar.drawJar();
    if(selectedJar != null)
    {
        isJarAvailable = true;
        moveRight.drawArrow();
        moveLeft.drawArrow();
    }
    else isJarAvailable = false;
    int correctCount = 0;
    for(Jar jar : correctJarOrder) if(jar.isInCorrectSpot == true) correctCount++;
    if(correctCount == 5)
    {
        isJarGameOver = true;
        selectedJar = null;
        if(!isDelaySet) {setupDelay(1); correctChime.play();}
        if(isDelayOver())
        {
            sceneManager.loadScene(storageScene);
            gameState = GameState.Scenes;
            storageScene.sceneButtons.remove(1);
            isDelaySet = false;
            storageScene.addItemButton(new PVector(553, 465), new PVector(64, 64), jarKey, true);
            cleanerTextbox.toggleRender();
            whisper.play();
        }
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


void checkMenuClick()
{
    switch(gameState)
    {
        case StoryScreen:
            gameState = GameState.Scenes;
            startGameplayTimer();
            mainMenuMusic.stop();
            isMainMenuLooped = false;
            gameMusic.loop();
            break;
        case MainMenu:
            if(isHowToPlay && mouseX < backButtonPosition.x + 100/2 && mouseX > backButtonPosition.x - 100/2 && mouseY < backButtonPosition.y + 50/2 && mouseY > backButtonPosition.y - 50/2) isHowToPlay = false;
            else if(!isHowToPlay && mouseX < playButtonPosition.x + 250/2 && mouseX > playButtonPosition.x - 250/2 && mouseY < playButtonPosition.y + 70/2 && mouseY > playButtonPosition.y - 70/2) 
            {
                gameState = GameState.StoryScreen;
                isStoryScreen = true;
            }
            else if(!isHowToPlay && mouseX < howToButtonPosition.x + 150/2 && mouseX > howToButtonPosition.x - 150/2 && mouseY < howToButtonPosition.y + 50/2 && mouseY > howToButtonPosition.y - 50/2) isHowToPlay = true;
            break;
        case WinMenu:
            if(mouseX < mainmenuButtonPosition.x + 180/2 && mouseX > mainmenuButtonPosition.x - 180/2 && mouseY < mainmenuButtonPosition.y + 50/2 && mouseY > mainmenuButtonPosition.y - 50/2)
            {
                resetGame();
                gameState = GameState.MainMenu;
                isWinMenu = false;
            }
            else if(mouseX < quitButtonPosition.x + 180/2 && mouseX > quitButtonPosition.x - 180/2 && mouseY < quitButtonPosition.y + 50/2 && mouseY > quitButtonPosition.y - 50/2) exit();
            break;
        case DeathMenu:
            resetGame();
            gameState = GameState.MainMenu;
            break;
    }
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

void winMenu()
{
    gameMusic.stop();
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
    textAlign(CENTER, CENTER);
    text("You escaped!\nYour soul is now free!", width/2, 150);
    fill(#ff0000);
    text("You escaped!\nYour soul is now free!", width/2-4, 146);
    textFont(baseFont, 24);
    fill(0);
    text("Main Menu", mainmenuButtonPosition.x, mainmenuButtonPosition.y);
    text("Quit", quitButtonPosition.x, quitButtonPosition.y);
}

void storyScreen()
{
    background(mainMenuBackground);
    rectMode(CENTER);
    strokeWeight(2);
    fill(128, 128, 128, 225);
    rect(width/2, height/2, 760, 400);
    textAlign(CENTER, CENTER);
    textFont(baseFont, 24);
    fill(0);
    text(introText[0], width/2, height/2, 740, 400);
}

void deathMenu()
{
    background(deathBackground);
    textAlign(CENTER, CENTER);
    textFont(baseFont, 24);
    fill(255);
    text("Click to return to main menu", width/2, 580);
}

void resetGame()
{
    sceneManager.loadScene(basementScene);
    basementScene.background = basementScatteredBackground;
    basementScene.addMoveButton(new PVector(455, 225), new PVector(64, 64), pipeHint, pipeHintPaper, notePickup);
    storageScene.addMoveButton(new PVector(285, 354), new PVector(64, 64), jarHint, jarHintPaper, notePickup);
    correctJarOrder = new Jar[jarCount];
    randomJarOrder = new Jar[jarCount];
    for(int i = 0; i < jarCount; i++) correctJarOrder[i] = new Jar(new PVector(200, 200), i, jarImages[i]);
    for(int i = 0; i < jarCount; i++) scrambleJars(i);
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
    isJarGameOver = false;
    cake = new Cake(new PVector(359, 250), new PVector(64, 64), bowl, kitchenScene.sceneButtons);
    kitchenScene.sceneButtons.add(cake);
    cake.itemsNeeded = cookItems;
    hideIngredients();
}

boolean isDelayOver()
{
    return millis() >= targetMilliseconds;
}

void setupDelay(int secondsToDelay)
{
    targetMilliseconds = millis() + secondsToDelay * 1000;
    isDelaySet = true;
}

void startGameplayTimer()
{
    gameEndMilliseconds = millis() + gameplaySeconds * 1000;
    isGameplayTimerSet = true;
}

void hideIngredients()
{
    IntList randomIndexes = new IntList();
    for(int i = 0; i < 5; i++) randomIndexes.append(i);
    randomIndexes.shuffle();
    basementScene.addItemButton(new PVector(957, 374), new PVector(64, 64),cookItems[randomIndexes.get(0)], false);
    kitchenScene.addItemButton(new PVector(373, 67), new PVector(64, 64),cookItems[randomIndexes.get(1)], false);
    storageScene.addItemButton(new PVector(676, 371), new PVector(64, 64),cookItems[randomIndexes.get(2)], false);
    storageScene.addItemButton(new PVector(365, 96), new PVector(64, 64),cookItems[randomIndexes.get(3)], false);
    hallwayScene.addItemButton(new PVector(50, 440), new PVector(64, 64),cookItems[randomIndexes.get(4)], false);
}
