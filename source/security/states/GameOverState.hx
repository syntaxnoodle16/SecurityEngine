package security.states;

import flixel.FlxSprite;
import flixel.FlxState;

class GameOverState extends FlxState
{
    var gameOverImage:FlxSprite;

    override public function create()
    {
        gameOverImage = new FlxSprite(0, 0);
        gameOverImage.loadGraphic('assets/images/ui/gameOver.png');
        add(gameOverImage);
    }
}