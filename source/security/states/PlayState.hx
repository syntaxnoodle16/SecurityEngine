package security.states;

import security.systems.SaveData;
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

	var hourTime:Float = 45; // How long an hour in the game lasts in real time (in seconds)

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
		var nextNight = night + 1;
		if (nextNight != 6 || nextNight != 8) // When the custom night is added, it will be night 7, therefore the night after that will be night 8.
		{
			SaveData.save.data.night = nextNight;
			SaveData.save.flush();
			FlxG.switchState(()->new PlayState(nextNight));
		} else
		{
			FlxG.switchState(TitleScreenState.new);
		}
	}

	var aiLevels:Map<Int, Int> = [
	    [1] => 2,
	    [2] => 5,
	    [3] => 8,
	    [4] => 10,
	    [5] => 12,
	    [6] => 14
	];
	function setAILevels()
	{
		if (aiLevels.exists(night))
		{
			var aiLevel:Int = aiLevels.get(night);
			nightManager.blueMan.aiLevel = aiLevel;
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
			office.x += -office.panSpeed * elapsed;
		}

		if (FlxG.mouse.overlaps(rightPan) && office.x < maxX)
		{
			office.x += office.panSpeed * elapsed;
		}

		if (!powerOut && !nightManager.gameOver && FlxG.keys.justPressed.S)
		{
			if (camsOpen)
			{
				camsOpen = false;
				closeSubState();
			} else
			{
				camsOpen = true;
				openSubState(new CamsSubState(nightManager));
			}
		}

		if (currentTime == 6)
		{
			endNight();
		}


		powerText.text = 'Power: ${Std.int(power)}%';



		if (!powerOut && FlxG.mouse.justPressed && FlxG.mouse.overlaps(office.leftDoorButton))
		{
    		office.leftDoorClosed = !office.leftDoorClosed;
    		office.leftDoor.visible = office.leftDoorClosed;
		}

		if (!powerOut && FlxG.mouse.justPressed && FlxG.mouse.overlaps(office.rightDoorButton))
		{
    		office.rightDoorClosed = !office.rightDoorClosed;
    		office.rightDoor.visible = office.rightDoorClosed;
		}
		if (!powerOut && FlxG.mouse.justPressed && FlxG.mouse.overlaps(office.leftLightButton))
		{
			office.leftLightOn = !office.leftLightOn;
		}
		if (!powerOut && FlxG.mouse.justPressed && FlxG.mouse.overlaps(office.rightLightButton))
		{
			office.rightLightOn = !office.rightLightOn;
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

		timeText.text = (currentTime == 0 ? 12 : currentTime) + " AM";

		if (power <= 0 && !powerOut)
		{
    		power = 0;
    		powerOut = true;

			closeSubState();

    		// Force doors open
			office.leftDoorClosed = office.rightDoorClosed = false;

    		office.leftDoor.visible = office.rightDoor.visible = false;

    		// Turn lights off
    		office.leftLightOn = office.rightLightOn = false;

    		// Max out all AI (to kill the player faster, remove this if you want to add your own power outage sequence)
    		for (animatronic in nightManager.animatronics)
    		{
    		    animatronic.aiLevel = 20;
    		}
		}

		if (powerOut)
		{
			power = 0;
		}

		//FlxG.log.add("Usage: " + usage);
	}
}
