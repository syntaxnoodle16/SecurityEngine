package security.objects;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class OfficeObject extends FlxGroup
{
    public var panSpeed:Float;

    public var x(default, set):Float = 0;
    public var y(default, set):Float = 0;

    public var background:FlxSprite;

    public var leftDoorButton:FlxSprite;
    public var rightDoorButton:FlxSprite;

    public var leftLightButton:FlxSprite;
    public var rightLightButton:FlxSprite;

    public var leftDoor:FlxSprite;

    public var rightDoor:FlxSprite;


    public var blueManLeftDoor:FlxSprite;
    public var blueManRightDoor:FlxSprite;

    public var leftDoorClosed:Bool;
    public var rightDoorClosed:Bool;

    public var leftLightOn:Bool;
    public var rightLightOn:Bool;

    public function new(x:Float, y:Float)
    {
        super();

        this.x = x;
        this.y = y;

        background = new FlxSprite(x, y);
        background.loadGraphic("assets/images/office.png");
        add(background);

        leftDoorButton = new FlxSprite(x + 25, y + 350);
        leftDoorButton.loadGraphic("assets/images/doorButton.png");
        add(leftDoorButton);

        rightDoorButton = new FlxSprite(x + 1200, y + 350);
        rightDoorButton.loadGraphic("assets/images/doorButton.png");
        add(rightDoorButton);

        leftLightButton = new FlxSprite(x + 25, y + 450);
        leftLightButton.loadGraphic("assets/images/lightButton.png");
        add(leftLightButton);

        rightLightButton = new FlxSprite(x + 1200, y + 450);
        rightLightButton.loadGraphic("assets/images/lightButton.png");
        add(rightLightButton);

        blueManLeftDoor = new FlxSprite(0, 0);
        blueManLeftDoor.visible = false;
        blueManLeftDoor.loadGraphic('assets/images/animatronics/blueMan/LeftDoor.png');
        blueManRightDoor = new FlxSprite(0, 0);
        blueManRightDoor.loadGraphic('assets/images/animatronics/blueMan/RightDoor.png');
        blueManRightDoor.visible = false;
        add(blueManLeftDoor);
        add(blueManRightDoor);

        leftDoor = new FlxSprite(0, 0);
        leftDoor.loadGraphic("assets/images/leftDoor.png");
        leftDoor.visible = false;
        add(leftDoor);

        rightDoor = new FlxSprite(0, 0);
        rightDoor.loadGraphic("assets/images/rightDoor.png");
        rightDoor.visible = false;
        add(rightDoor);

        panSpeed = 10;
    }

    function set_x(value:Float):Float
    {
        var delta:Float = value - x;

        for (member in members)
        {
            if (member != null)
            {
                var sprite:FlxSprite = cast member;
                sprite.x += delta;
            }
        }

        return x = value;
    }

    function set_y(value:Float):Float
    {
        var delta:Float = value - y;

        for (member in members)
        {
            if (member != null)
            {
                var sprite:FlxSprite = cast member;
                sprite.y += delta;
            }
        }

        return y = value;
    }
}