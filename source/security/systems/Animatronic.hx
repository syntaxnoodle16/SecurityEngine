package security.systems;

import flixel.FlxG;
import flixel.util.FlxTimer;

class Animatronic
{
    public var currentRoom:Int; // The room id the animatronic is currently in

    public var aiLevel:Int; // the ai level of the animatronic (0-20)

    public var moveOpportunityTime:Float; // The time it takes for the animatronic to have a movement opportunity

    public var path:Array<Int>; // The path the animatronic takes to the office, in roomIDs
    public var pathIndex:Int = 0;

    var moveTimer:FlxTimer;

    public function new(moveOpp:Float)
    {
        moveOpportunityTime = moveOpp;

        path = [];
        currentRoom = path[0];

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
            if (pathIndex < path.length - 1)
            {
                pathIndex++;
                currentRoom = path[pathIndex];

                trace("Animatronic moved to " + currentRoom);
            }
            else
            {
                trace("Animatronic is already at the end of its path");
            }
        }
        else if (num > aiLevel)
        {
            trace("Animatronic did not move :(");
        }
    }
}