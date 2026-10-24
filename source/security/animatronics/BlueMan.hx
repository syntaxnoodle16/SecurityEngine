package security.animatronics;

import security.systems.NightManager;
import security.objects.OfficeObject;
import security.systems.Animatronic;

class BlueMan extends Animatronic
{
    public function new(_office:OfficeObject, _nightManager:NightManager)
    {
        super(3.45, _office, _nightManager);

        this.path = [1, 2, 3, 5, 7];
        currentRoom = this.path[0];
    }
}