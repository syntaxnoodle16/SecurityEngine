package security.animatronics;

import security.systems.NightManager;
import security.objects.OfficeObject;
import security.systems.Animatronic;


// This Animatronic is an example, delete it or rename it if you plan to add your own (be sure to remove references to it too)

class BlueMan extends Animatronic
{
    public function new(_office:OfficeObject, _nightManager:NightManager)
    {
        super(3.45, _office, _nightManager, "blueMan");

        this.path = [1, 2, 3, 5, 7];
        currentRoom = this.path[0];
    }
}