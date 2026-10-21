package security.objects;

import flixel.FlxSprite;

class Office extends FlxSprite
{
    public var panSpeed:Float;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        this.loadGraphic("assets/images/office.png");

        panSpeed = 10;
    }
}