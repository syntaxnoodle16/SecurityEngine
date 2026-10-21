package security.systems;

import security.systems.Animatronic;

class NightManager
{
    public var animatronics:Array<Animatronic>;

    public var rooms:Array<Room>;

    public var Animatronic1:Animatronic;

    public function new()
    {
        Animatronic1 = new Animatronic(5);

        animatronics = [];

        animatronics.push(Animatronic1);
    }
}