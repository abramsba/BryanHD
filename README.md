# Bryan's HD extensions

This extension pack includes

- Random modern weapons I managed to find sprites for
- A wrapper class for quickly creating new simple weapons

For an example class see `source/weapons/bm16.zs`.

```
class MyGun : BBasicWeapon {
	default {
		...
	}
	states {
		Spawn:
			<SPRITENAME> A -1;
			Stop;
		Ready:
			<SPRITENAME> A 1;
			Goto Super::Ready;
		Select0:
			<SPRITENAME> A 0 {
				return ResolveState("select0small");
			}
		Deselect0:
			<SPRITENAME> A 0 {
				return ResolveState("deselect0small");
			}
	}
}
```

## Properties:

I don't know what half of these do yet:

 * `BBasicWeapon.BHeatDrain`: send to `drainHeat()` (e.g. 12);
 * `BBasicWeapon.BBulletClass`: The actor class for the bullet (e.g. "HDB_776")
 * `BBasicWeapon.BAmmoClass`: The actor class for the ammo (e.g. "B556Ammo")
 * `BBasicWeapon.BMagazineClass`: The actor class for the magazine (e.g. "B556Mag")
 * `BBasicWeapon.BGunMass`: The mass of the gun (e.g. 6.2)
 * `BBasicWeapon.BCookOff`: When the gun cooks off? (e.g. 30)
 * `BBasicWeapon.BHeatLimit`: Heat limit? (e.g. 255)
 * `BBasicWeapon.BSpriteWithMag`: The sprite to show if the gun has a mag "(e.g. M16PA0)"
 * `BBasicWeapon.BSpriteWithoutMag`: The sprite to show if the gun has no mag "(e.g. M16PB0)"
 * `BBasicWeapon.BMagazineSprite`: The sprite of the magazine (e.g. "M16CA0")
 * `BBasicWeapon.BWeaponBulk`: How bulky the weapon is (e.g. 90)
 * `BBasicWeapon.BMagazineBulk`: How bulky is the magazine (e.g. 19)
 * `BBasicWeapon.BBulletBulk`: How bulky are the bullets (e.g. 1)
 * `BBasicWeapon.BMagazineCapacity`: What is the magazine max capacity (e.g. 30)
 * `BBasicWeapon.BarrelLength`: How long is the barrel? Sets `HDWeapon.barrelLength` (e.g. 25)
 * `BBasicWeapon.BarrelWidth`: How wide is the barrel? Sets `HDWeapon.barrelWdith` (e.g. 1)
 * `BBasicWeapon.BarrelDepth`: How deep is the barrel? Sets `HDWeapon.barrelDepth` (e.g. 3)
 * `BBasicWeapon.BFireSound`: Sound to use when firing (e.g. "m16/fire")
 * `BBasicWeapon.BChamberSound`: Sound to use for chambering  (e.g. "weapons/rifchamber")
 * `BBasicWeapon.BBoltForwardSound`: Sound to use for the back bolt motion (e.g. "akm/boltf")
 * `BBasicWeapon.BBoltBackwardSound`: Sound to use for the forward bolt motion (e.g. "akm/boltb");
 * `BBasicWeapon.BClickSound`: Sound for the click sound (e.g. "weapons/rifleclick2")
 * `BBasicWeapon.BLoadSound`: Sound for loading magazine (e.g. "weapons/rifleload")
 * `BBasicWeapon.BROF`: Rate of fire used for SetTics