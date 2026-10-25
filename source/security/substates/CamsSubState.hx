package security.substates;

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

    var blueManOverlay:FlxSprite;

    public function new(_nightManager:NightManager)
    {
        super(FlxColor.BLACK);

        nightManager = _nightManager;
    }

    override public function create()
    {
        super.create();

        map = new FlxSprite(850, 300);
        map.loadGraphic("assets/images/cams/map.png");

        camImage = new FlxSprite(0, 0);
        add(camImage);

        blueManOverlay = new FlxSprite(0, 0);
        add(blueManOverlay);

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

        loadCurrentCam();
    }

    function loadCurrentCam()
    {
        selectedCam = Std.int(Math.max(0, Math.min(selectedCam, nightManager.cams.length - 1)));
        var cam = nightManager.cams[selectedCam];

        camImage.loadGraphic(
            "assets/images/cams/rooms/" + cam.imageName + ".png"
        );

        if (nightManager.blueMan.currentRoom == cam.roomID)
        {
            blueManOverlay.loadGraphic("assets/images/animatronics/blueMan/" + cam.imageName + ".png");
            blueManOverlay.visible = true;
        } else
        {
            blueManOverlay.visible = false;
        }
    }
}