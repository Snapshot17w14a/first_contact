class SceneManager
{
    Scene currentScene;

    void draw()
    {
        currentScene.drawScene();
    }

    void loadScene(Scene newScene)
    {
        currentScene = newScene;
    }

    void mouseClick()
    {
        currentScene.checkButtonCollision();
    }
}