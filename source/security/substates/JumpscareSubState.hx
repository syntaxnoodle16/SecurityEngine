package security.substates;

import security.states.GameOverState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxAtlasFrames;

class JumpscareSubState extends FlxSubState
{
    var jumpScare:FlxSprite;

    var assetName:String;
    public function new(jumpScareAssetName:String)
    {
        super(0x33000000);

        assetName = jumpScareAssetName;
    }

    override public function create()
    {
        super.create();

        jumpScare = new FlxSprite(0, 0);
        jumpScare.frames = FlxAtlasFrames.fromSparrow(
        "assets/images/jumpscares/" + assetName + "-jumpscare.png",
        "assets/images/jumpscares/" + assetName + "-jumpscare.xml"
        );
        jumpScare.animation.addByPrefix("jumpscare", "jumpscare", 24, false);
        add(jumpScare);
        jumpScare.animation.play("jumpscare");
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (jumpScare.animation.finished)
        {
            FlxG.switchState(GameOverState.new);
        }
    }
}