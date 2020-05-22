
class B_MP5K : BHDWeapon {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the MP5K.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "MP5K";
		inventory.icon               "MP5PA0";

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_9";
		BHDWeapon.BAmmoClass         "HDPistolAmmo";
		BHDWeapon.BMagazineClass     "B9mm_MP5K_MAG";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "MP5PA0";
		BHDWeapon.BSpriteWithoutMag  "MP5PB0";
		BHDWeapon.BMagazineSprite    "MP5CA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      19;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		BHDWeapon.BFireSound         "mp5k/fire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltf";
		BHDWeapon.BBoltBackwardSound "akm/boltb";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               2;
		BHDWeapon.BBackSightImage    "mpksight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       8;
		BHDWeapon.BFrontSightImage   "mpkiron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      8;
	}

	states {
		Spawn:
			MP5P A -1 {
				if (invoker.magazineGetAmmo() > 0) {
					return ResolveState("SpawnMag");
				}
				return ResolveState("SpawnNoMag");
			}
		SpawnMag:
			MP5P A -1;
			Goto Super::Spawn;
		SpawnNoMag:
			MP5P B -1;
			Goto Super::Spawn;
		Spawn2:
			MP5K A 0;
			Goto Super::Spawn2;
		Ready:
			MP5K A 1;
			Goto Super::Ready;
		Select0:
			MP5K A 0 {
				return ResolveState("select0small");
			}
		Deselect0:
			MP5K A 0;
			Goto Super::Deselect0;
	}

}