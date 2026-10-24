package security.systems;

import flixel.FlxBasic;
import security.states.PlayState;
import security.substates.JumpscareSubState;
import security.systems.Animatronic;
import security.systems.Cam;
import security.animatronics.BlueMan;

class NightManager extends FlxBasic
{
	// This class basically handles everything behind the scenes
    
    public var animatronics:Array<Animatronic>;

    public var rooms:Array<Room>;

	public var cams:Array<Cam>;

	public var officeRoomID:Int; // The room ID of the office, basically the animatronic will kill you if it reaches this room ID

	public var night:Int;

	var playState:PlayState;

	var jumpscareSubState:JumpscareSubState;

	public var blueMan:BlueMan;

	public function new(_playState:PlayState)
    {
		super();

		playState = _playState;

		jumpscareSubState = new JumpscareSubState();

		blueMan = new BlueMan();

        animatronics = [];

		animatronics.push(blueMan);

		officeRoomID = 6;

		cams = [
    		new Cam(0, 1, "Show Stage", "ShowStage"),
    		new Cam(1, 2, "Dining Area", "DiningArea"),
    		new Cam(2, 3, "West Hall", "WestHall"),
			new Cam(3, 4, "East Hall", "EastHall")
		];
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		for (animatronic in animatronics)
		{
			if (animatronic.currentRoom == officeRoomID)
			{
				playState.openSubState(jumpscareSubState);
			}
		}
    }
}