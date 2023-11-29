class SceneManager
{
    Scene currentScene;

    void draw()
    {
        currentScene.drawScene();
    }

    void loadScene(Scene newScene)
    {
        if(currentScene.sceneTexts.size() > 0)
        {
            currentScene.sceneTexts.remove(currentScene.sceneTexts.size()-1);
        }
        fullInventoryNotification.parentScene = newScene;
        newScene.sceneTexts.add(fullInventoryNotification);
        currentScene = newScene;
    }

    void mouseClick()
    {
        currentScene.checkButtonCollision();
    }
}