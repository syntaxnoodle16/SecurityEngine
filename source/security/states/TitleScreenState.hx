package security.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class TitleScreenState extends FlxState
{
    var title:FlxSprite;

    var currentNight:Int = 1;
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
            FlxG.switchState(()->new PlayState(currentNight));
        }

        #if debug
        if (FlxG.keys.justPressed.LEFT)
        {
            currentNight += -1;
            FlxG.log.add(currentNight);
        }
        if (FlxG.keys.justPressed.RIGHT)
        {
            currentNight += 1;
            FlxG.log.add(currentNight);
        }
        #end
    }
}