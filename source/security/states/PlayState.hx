package security.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import security.objects.OfficeObject;
import security.systems.NightManager;
import security.substates.CamsSubState;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var office:OfficeObject;

	var nightManager:NightManager;

	var leftPan:FlxObject;
	var rightPan:FlxObject;

	var power:Int = 100;

	var currentTime:Int = 0; // The time, 0 = 12AM, 1 = 1AM, etc

	var hourTime:Float = 45; // How long an hour in the game lasts in real time

	var hourTimer:FlxTimer;

	public var night:Int;

	public function new(_night:Int)
	{
		super();

		night = _night;
	}

	override public function create()
	{
		super.create();

		office = new OfficeObject(0, 0);
		add(office);

		rightPan = new FlxObject(0, 0, 320, FlxG.height);
		rightPan.scrollFactor.set(0, 0);
		leftPan = new FlxObject(960, 0, 320, FlxG.height);
		leftPan.scrollFactor.set(0, 0);
		add(rightPan);
		add(leftPan);
		nightManager = new NightManager(this);
		add(nightManager);

		hourTimer = new FlxTimer();

		hourTimer.start(hourTime, changeHour, 7);


		setAILevels();

		FlxG.log.add("PlayState Loaded! Night: " + night);
	}

	function changeHour(timer:FlxTimer)
	{
		currentTime += 1;
	}

	function endNight()
	{
		FlxG.switchState(()->new PlayState(night + 1));
	}

	function setAILevels()
	{
		if (night == 1)
		{
			nightManager.blueMan.aiLevel = 2;
		}
		if (night == 2)
		{
			nightManager.blueMan.aiLevel = 5;
		}
		if (night == 3)
		{
			nightManager.blueMan.aiLevel = 8;
		}
		if (night == 4)
		{
			nightManager.blueMan.aiLevel = 10;
		}
		if (night == 5)
		{
			nightManager.blueMan.aiLevel = 12;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Handles office scrolling and making sure it doesn't move off screen
		var minX:Float = FlxG.width - office.background.width;
		var maxX:Float = 0;

		if (FlxG.mouse.overlaps(leftPan) && office.x > minX)
		{
			office.x += -office.panSpeed;
		}

		if (FlxG.mouse.overlaps(rightPan) && office.x < maxX)
		{
			office.x += office.panSpeed;
		}

		if (FlxG.keys.justPressed.S)
		{
			this.openSubState(new CamsSubState(nightManager));
		}

		if (currentTime == 6)
		{
			endNight();
		}
	}
}
