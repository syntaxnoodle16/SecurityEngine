package security.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class TitleScreenState extends FlxState
{
    var title:FlxSprite;
    override public function create()
    {
        title = new FlxSprite(0, 0);
        title.loadGraphic("assets/images/ui/title.png");
        add(title);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(PlayState.new);
        }
    }
}