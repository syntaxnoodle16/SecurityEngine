package security.systems;

import flixel.FlxBasic;
import security.states.PlayState;
import security.substates.JumpscareSubState;
import security.systems.Animatronic;
import security.systems.Cam;

class NightManager extends FlxBasic
{
	// This class basically handles everything behind the scenes
    
    public var animatronics:Array<Animatronic>;

    public var rooms:Array<Room>;

	public var cams:Array<Cam>;

	public var animatronic1:Animatronic;

	public var officeRoomID:Int; // The room ID of the office, basically the animatronic will kill you if it reaches this room ID

	public var night:Int;

	var playState:PlayState;

	var jumpscareSubState:JumpscareSubState;

	public function new(_playState:PlayState)
    {
		super();

		playState = _playState;

		jumpscareSubState = new JumpscareSubState();

		animatronic1 = new Animatronic(5);

		animatronic1.aiLevel = 20;

        animatronics = [];

		animatronics.push(animatronic1);
		officeRoomID = 5;

		cams = [
    		new Cam(0, 1, "Show Stage"),
    		new Cam(1, 2, "Dining Area"),
    		new Cam(2, 3, "West Hall")
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