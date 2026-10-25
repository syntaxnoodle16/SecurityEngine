package security.states;

import security.systems.SaveData;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.Lib;

class TitleScreenState extends FlxState
{
    var title:FlxSprite;

    var newGameButton:FlxText;
    var loadGameButton:FlxText;
    var loadNightButton:FlxText;

    var engineVersion:FlxText;

    var currentNight:Int = 1;

    var loadedNight:Int;

    override public function create()
    {
        title = new FlxSprite(0, 0);
        title.loadGraphic("assets/images/ui/title.png");
        add(title);

        newGameButton = new FlxText(80, 330, 0, "New Game", 32, true);
        add(newGameButton);

        loadGameButton = new FlxText(80, 380, 0, "Continue", 32, true);
        add(loadGameButton);

        loadNightButton = new FlxText(80, 430, 0, "Load Night: ", 32, true);
        #if debug
        add(loadNightButton);
        #end

        engineVersion = new FlxText(1024, 685, 0, "Security Engine v", 16);
        add(engineVersion);

        loadedNight = SaveData.save.data.night;

        engineVersion.text = "Security Engine " + Lib.application.meta.get("version");
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(loadNightButton))
        {
            FlxG.switchState(()->new PlayState(currentNight));
        }
        if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(loadGameButton))
        {
            FlxG.switchState(()->new PlayState(loadedNight));
        }
        if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(newGameButton))
        {
            SaveData.save.data.night = 1;
            SaveData.save.flush();
            FlxG.switchState(()->new PlayState(1));
        }

        loadNightButton.text = "Load Night: " + currentNight;

        loadGameButton.text = "Continue - Night " + loadedNight;

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