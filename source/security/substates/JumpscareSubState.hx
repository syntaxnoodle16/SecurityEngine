package security.substates;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxAtlasFrames;

class JumpscareSubState extends FlxSubState
{
    var jumpScare:FlxSprite;
    public function new()
    {
        super(0x33000000);
    }

    override public function create()
    {
        jumpScare = new FlxSprite(0, 0);
        jumpScare.frames = FlxAtlasFrames.fromSparrow(
        "assets/images/jumpscares/animatronic1-jumpscare.png",
        "assets/images/jumpscares/animatronic1-jumpscare.xml"
        );
        jumpScare.animation.addByPrefix("jumpscare", "jumpscare", 24, false);
        add(jumpScare);
        jumpScare.animation.play("jumpscare");
    }
}