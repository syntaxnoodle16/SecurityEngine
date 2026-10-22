package security.systems;

class Cam
{
    public var cameraID:Int;
    public var roomID:Int;
    public var cameraName:String;

    public function new(id:Int, room:Int, name:String)
    {
        cameraID = id;
        roomID = room;
        cameraName = name;
    }
}