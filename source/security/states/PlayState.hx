package security.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import security.objects.Office;

class PlayState extends FlxState
{
	var office:Office;


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
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
