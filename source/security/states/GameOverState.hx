package security.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import security.states.TitleScreenState;

class GameOverState extends FlxState
{
    var gameOverImage:FlxSprite;

    override public function create()
    {
        gameOverImage = new FlxSprite(0, 0);
        gameOverImage.loadGraphic('assets/images/ui/gameOver.png');
        add(gameOverImage);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(TitleScreenState.new);
        }
    }
}