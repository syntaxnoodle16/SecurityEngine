package security.systems;

class Room
{
    public var locationID:Int; // The id for the location, used for animatronic movement, like an animatronic moving from ShowStage (id: 1) to DiningArea (id: 2)

    public function new(id:Int)
    {
        locationID = id;
    }
}