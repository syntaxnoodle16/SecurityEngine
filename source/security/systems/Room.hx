package security.systems;

class Room
{
    public var locationID:Int; // The id for the room (its called locationID because thats what rooms were originally called), used for animatronic movement, like an animatronic moving from ShowStage (id: 1) to DiningArea (id: 2)

    public function new(id:Int)
    {
        locationID = id;
    }
}