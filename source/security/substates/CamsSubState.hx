package security.substates;

import flixel.group.FlxGroup.FlxTypedGroup;
import security.systems.NightManager;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxG;
import security.states.PlayState;

class CamsSubState extends FlxSubState
{
    var map:FlxSprite;

    var camImage:FlxSprite;

    var nightManager:NightManager;

    var selectedCam:Int = 0;

    public var animatronicOverlays:FlxTypedGroup<FlxSprite>;

    var blueManOverlay:FlxSprite;

    var camVelocity:Float = 20;

    public function new(_nightManager:NightManager)
    {
        super(FlxColor.BLACK);

        nightManager = _nightManager;
    }

    override public function create()
    {
        super.create();

        animatronicOverlays = new FlxTypedGroup<FlxSprite>();

        map = new FlxSprite(850, 300);
        map.loadGraphic("assets/images/cams/map.png");

        camImage = new FlxSprite(0, 0);
        add(camImage);

        blueManOverlay = new FlxSprite(0, 0);
        add(blueManOverlay);

        animatronicOverlays.add(blueManOverlay);

        add(map);

        loadCurrentCam();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.LEFT)
        {
            selectedCam--;
            loadCurrentCam();
        }

        if (FlxG.keys.justPressed.RIGHT)
        {
            selectedCam++;
            loadCurrentCam();
        }

        updateOverlays();

        // Automatic camera panning
        var minX:Float = FlxG.width - camImage.width;
        var maxX:Float = 0;

        camImage.x += camVelocity * elapsed;

        for (overlay in animatronicOverlays.members)
        {
            if (overlay != null)
            {
                overlay.x += camVelocity * elapsed;
            }
        }

        if (camImage.x >= maxX)
        {
            camImage.x = maxX;
            camVelocity *= -1;
        }

        if (camImage.x <= minX)
        {
            camImage.x = minX;
            camVelocity *= -1;
        }
    }

    function loadCurrentCam()
    {
        selectedCam = Std.int(Math.max(0, Math.min(selectedCam, nightManager.cams.length - 1)));

        var cam = nightManager.cams[selectedCam];

        camImage.loadGraphic(
            "assets/images/cams/rooms/" + cam.imageName + ".png"
        );

        // Reset pan when changing cameras
        camImage.x = 0;

        for (overlay in animatronicOverlays.members)
        {
            if (overlay != null)
            {
                overlay.x = 0;
            }
        }

        camVelocity = 20;

        updateOverlays();
    }

    function updateOverlays()
    {
        var cam = nightManager.cams[selectedCam];

        if (nightManager.blueMan.currentRoom == cam.roomID)
        {
            blueManOverlay.loadGraphic(
                "assets/images/animatronics/blueMan/" + cam.imageName + ".png"
            );

            blueManOverlay.visible = true;
        }
        else
        {
            blueManOverlay.visible = false;
        }
    }
}