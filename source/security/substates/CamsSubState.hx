package security.substates;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxSubState;

class CamsSubState extends FlxSubState
{

    var map:FlxSprite;

    var camImage:FlxSprite;

    public function new()
    {
        super(FlxColor.BLACK);

        persistentUpdate = true; // Normally FlxSubState stops the FlxState it opened from from updating. Obviously we dont want that with the cameras lol
    }

    override public function create()
    {
        map = new FlxSprite(850, 300);
        map.loadGraphic("assets/images/cams/map.png");

        camImage = new FlxSprite(0, 0);
        camImage.loadGraphic('assets/images/cams/rooms/ShowStage.png');
        add(camImage);
        add(map);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        
    }
}