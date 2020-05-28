
// Out of date, won't work properly
class B_AK47 : BHDWeapon {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the AK47.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "AK47";
		inventory.icon               "AKMPA0";

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_762";
		BHDWeapon.BAmmoClass         "B762Ammo";
		BHDWeapon.BMagazineClass     "B762_AK47_Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "AK4PA0";
		BHDWeapon.BSpriteWithoutMag  "AK4PB0";
		BHDWeapon.BMagazineSprite    "AK4CA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      19;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		BHDWeapon.BFireSound         "akm/fire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltf";
		BHDWeapon.BBoltBackwardSound "akm/boltb";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               2;
		BHDWeapon.BBackSightImage    "ak4sight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       20;
		BHDWeapon.BFrontSightImage   "ak47iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      4;
	}

	states {
		Spawn:
			AK4P A -1 {
				if (invoker.magazineGetAmmo() > 0) {
					return ResolveState("SpawnMag");
				}
				return ResolveState("SpawnNoMag");
			}
		SpawnMag:
			AK4P A -1;
			Goto Super::Spawn;
		SpawnNoMag:
			AK4P B -1;
			Goto Super::Spawn;
		Spawn2:
			AK47 A 0;
			Goto Super::Spawn2;
		Ready:
			AK47 A 1;
			Goto Super::Ready;
		Select0:
			AK47 A 0 {
				return ResolveState("select0small");
			}
		Deselect0:
			AK47 A 0;
			Goto Super::Deselect0;
	}

}