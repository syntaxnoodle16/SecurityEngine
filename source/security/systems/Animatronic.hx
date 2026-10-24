package security.systems;

import security.objects.OfficeObject;
import flixel.FlxG;
import flixel.util.FlxTimer;
import security.systems.NightManager;

class Animatronic
{
    public var currentRoom:Int; // The room id the animatronic is currently in

    public var aiLevel:Int; // the ai level of the animatronic (0-20)

    public var moveOpportunityTime:Float; // The time it takes for the animatronic to have a movement opportunity

    public var path:Array<Int>; // The path the animatronic takes to the office, in roomIDs
    public var pathIndex:Int = 0;

    var moveTimer:FlxTimer;

    var office:OfficeObject;

    var nightManager:NightManager;

    public function new(moveOpp:Float, _office:OfficeObject, _nightManager:NightManager)
    {
        moveOpportunityTime = moveOpp;
        office = _office;
        nightManager = _nightManager;

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
                var nextRoom:Int = path[pathIndex + 1];
                var blockedByDoor:Bool =
                    ((nextRoom == nightManager.officeRoomID && currentRoom == nightManager.leftDoorRoomID) && office.leftDoorClosed)
                    || ((nextRoom == nightManager.officeRoomID && currentRoom == nightManager.rightDoorRoomID) && office.rightDoorClosed);

                if (blockedByDoor)
                {
                    pathIndex = 0;
                    currentRoom = path[0];
                    FlxG.log.add("Animatronic was blocked by a closed door and returned to the start");
                }
                else
                {
                    pathIndex++;
                    currentRoom = path[pathIndex];
                    FlxG.log.add("Animatronic moved to " + currentRoom);
                }
            }
            else
            {
                FlxG.log.add("Animatronic is already at the end of its path");
            }
        }
        else if (num > aiLevel)
        {
            FlxG.log.add("Animatronic did not move :(");
        }
    }
}