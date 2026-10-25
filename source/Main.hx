package;

import security.systems.SaveData;
import security.states.TitleScreenState;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		SaveData.init();
		addChild(new FlxGame(0, 0, TitleScreenState));
	}
}
