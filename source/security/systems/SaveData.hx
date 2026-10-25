package security.systems;

import flixel.util.FlxSave;

class SaveData
{
    public static var save:FlxSave;

    public static function init()
    {
        save = new FlxSave();
        save.bind("SecurityEngine");

        if (save.data.night == null)
        {
            save.data.night = 1;
            save.flush();
        }
    }    
}
