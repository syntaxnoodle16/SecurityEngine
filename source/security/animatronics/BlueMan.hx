package security.animatronics;

import security.systems.Animatronic;

class BlueMan extends Animatronic
{
    public function new()
    {
        super(3.45);

        this.path = [1, 2, 3, 5, 7];
        currentRoom = this.path[0];
    }
}