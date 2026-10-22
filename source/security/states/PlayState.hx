package security.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import security.objects.Office;
import security.systems.NightManager;

class PlayState extends FlxState
{
	var office:Office;

	var nightManager:NightManager;

	var leftPan:FlxObject;
	var rightPan:FlxObject;
	override public function create()
	{
		super.create();

		office = new Office(0, 0);
		add(office);

		rightPan = new FlxObject(0, 0, 320, FlxG.height);
		rightPan.scrollFactor.set(0, 0);
		leftPan = new FlxObject(960, 0, 320, FlxG.height);
		leftPan.scrollFactor.set(0, 0);
		add(rightPan);
		add(leftPan);
		nightManager = new NightManager(this);
		add(nightManager);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Handles office scrolling and making sure it doesn't move off screen
		var minX:Float = FlxG.width - office.width;
		var maxX:Float = 0;

		if (FlxG.mouse.overlaps(leftPan) && office.x > minX)
		{
			office.x += -office.panSpeed;
		}

		if (FlxG.mouse.overlaps(rightPan) && office.x < maxX)
		{
			office.x += office.panSpeed;
		}
	}
}
