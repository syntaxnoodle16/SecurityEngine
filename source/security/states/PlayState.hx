package security.states;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import security.objects.OfficeObject;
import security.systems.NightManager;
import security.substates.CamsSubState;
import flixel.util.FlxTimer;
import flixel.FlxCamera;

class PlayState extends FlxState
{
	public var office:OfficeObject;

	var nightManager:NightManager;

	var leftPan:FlxObject;
	var rightPan:FlxObject;

	public var power:Float = 100;

	var currentTime:Int = 0; // The time, 0 = 12AM, 1 = 1AM, etc

	var hourTime:Float = 45; // How long an hour in the game lasts in real time

	var hourTimer:FlxTimer;

	public var night:Int;

	public var camsOpen:Bool = false;

	// UI

	var powerText:FlxText;
	var usageText:FlxText;
	var timeText:FlxText;
	var nightText:FlxText;

	var hudCamera:FlxCamera;

	public var powerOut:Bool = false;

	public function new(_night:Int)
	{
		super();

		night = _night;
	}

	override public function create()
	{
		super.create();

		power = 100.99;

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

		persistentUpdate = true;

		currentTime = 0;


		hudCamera = new FlxCamera();
		hudCamera.bgColor = 0x00000000;

		FlxG.cameras.add(hudCamera, false);


		setAILevels();

		FlxG.log.add("PlayState Loaded! Night: " + night);


		// UI

		powerText = new FlxText(0, 0, 0, "Power: ", 32, true);
		usageText = new FlxText(0, 38, 0, "Usage: ", 32, true);
		timeText = new FlxText(0, 78, 0, "Time: ", 32, true);
		nightText = new FlxText(0, 118, 0, "Night ", 32, true);

		powerText.cameras = [hudCamera];
		usageText.cameras = [hudCamera];
		timeText.cameras = [hudCamera];
		nightText.cameras = [hudCamera];


		add(powerText);
		add(usageText);
		add(timeText);
		add(nightText);
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

		if (!powerOut && FlxG.keys.justPressed.S)
		{
			camsOpen = true;
			this.openSubState(new CamsSubState(nightManager));
		}

		if (currentTime == 6)
		{
			endNight();
		}


		powerText.text = "Power: " + Std.int(power) + "%";



		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(office.leftDoorButton))
		{
    		office.leftDoorClosed = !office.leftDoorClosed;
    		office.leftDoor.visible = office.leftDoorClosed;
		}

		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(office.rightDoorButton))
		{
    		office.rightDoorClosed = !office.rightDoorClosed;
    		office.rightDoor.visible = office.rightDoorClosed;
		}




		var usage:Int = 1; // base power usage

		if (camsOpen)
    		usage++;

    	if (office.leftDoorClosed)
        	usage++;

    	if (office.rightDoorClosed)
        	usage++;

    	if (office.leftLightOn)
        	usage++;

    	if (office.rightLightOn)
        	usage++;

		var powerDrainRate:Float = 0.3;

    	power -= usage * powerDrainRate * elapsed;

		usageText.text = "Usage: " + usage;

		nightText.text = "Night " + night;

		if (currentTime == 0)
		{
			timeText.text = "12 AM";
		} else
		{
			timeText.text = currentTime + " AM";
		}

		if (power <= 0 && !powerOut)
		{
    		power = 0;
    		powerOut = true;

			closeSubState();

    		// Force doors open
			office.leftDoorClosed = false;
			office.rightDoorClosed = false;

    		office.leftDoor.visible = false;
    		office.rightDoor.visible = false;

    		// Turn lights off
    		office.leftLightOn = false;
    		office.rightLightOn = false;

    		// Max out all AI
    		for (animatronic in nightManager.animatronics)
    		{
    		    animatronic.aiLevel = 20;
    		}
		}

		//FlxG.log.add("Usage: " + usage);
	}
}
