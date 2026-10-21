package security.systems;

import flixel.FlxG;
import flixel.util.FlxTimer;

class Animatronic
{
    public var currentRoom:Int; // The room id the animatronic is currently in

    public var aiLevel:Int; // the ai level of the animatronic (0-20)

    public var moveOpportunityTime:Float; // The time it takes for the animatronic to have a movement opportunity

    var moveTimer:FlxTimer;

    public function new(moveOpp:Float)
    {
        moveOpportunityTime = moveOpp;

        moveTimer = new FlxTimer();
        moveTimer.start(moveOpportunityTime, onMoveOpportunity, 0);
    }

    function onMoveOpportunity(timer:FlxTimer):Void
    {
        move();
    }

    function move()
    {
        var num:Int = FlxG.random.int(1, 20);
        trace("Generated number is " + num);

        if (num <= aiLevel)
        {
            currentRoom += 1;
            trace("Animatronic moved to " + currentRoom);
        } else if (num > aiLevel)
        {
            trace("Animatronic did not move :(");
        }
    }
}