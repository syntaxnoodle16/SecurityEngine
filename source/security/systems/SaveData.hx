package security.systems;

import flixel.util.FlxSave;
import openfl.Lib;

class SaveData
{
    public static var save:FlxSave;

    public static function init()
    {
        save = new FlxSave();
        var fileName:String;
        fileName = Lib.application.meta.get("file");
        save.bind(fileName);

        if (save.data.night == null)
        {
            save.data.night = 1;
            save.flush();
        }
    }    
}
