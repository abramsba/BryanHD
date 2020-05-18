
class B_M16 : BHDWeapon {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the m16.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "M16";
		inventory.icon               "M16PA0";

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_556";
		BHDWeapon.BAmmoClass         "B556Ammo";
		BHDWeapon.BMagazineClass     "B556Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M16PA0";
		BHDWeapon.BSpriteWithoutMag  "M16PB0";
		BHDWeapon.BMagazineSprite    "M16CA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      19;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		BHDWeapon.BFireSound         "m16/fire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltb";
		BHDWeapon.BBoltBackwardSound "akm/boltf";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               1;
		BHDWeapon.BBackSightImage    "m16sight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       8;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      10;
	}

	states {
		Spawn:
			M16P A -1 {
				if (invoker.magazineGetAmmo() > 0) {
					return ResolveState("SpawnMag");
				}
				return ResolveState("SpawnNoMag");
			}
		SpawnMag:
			M16P A -1;
			Goto Super::Spawn;
		SpawnNoMag:
			M16P B -1;
			Goto Super::Spawn;
		Spawn2:
			M16P A 0;
			Goto Super::Spawn2;
		Ready:
			M16G A 1;
			Goto Super::Ready;
		Select0:
			M16G A 0 {
				return ResolveState("select0small");
			}
		Deselect0:
			M16G A 0;
			Goto Super::Deselect0;
	}




}



class M16Giver : HDWeaponGiver {
	default {
		tag "M16";
		hdweapongiver.bulk (90.+(ENC_762MAG_LOADED+30.*ENC_762_LOADED));
		hdweapongiver.weapontogive "B_M16";
		hdweapongiver.config "noglsemi";
		inventory.icon "AKMPA0";
	}
}