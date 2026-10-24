package security.systems;

class Cam
{
    public var cameraID:Int;
    public var roomID:Int;
    public var cameraName:String;
    public var imageName:String;

    public function new(id:Int, room:Int, name:String, image:String)
    {
        cameraID = id;
        roomID = room;
        cameraName = name;
        imageName = image;
    }
}