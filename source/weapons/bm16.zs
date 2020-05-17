
class B_M16 : BBasicWeapon {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder   20;
		weapon.slotnumber       4;
		weapon.slotpriority     3;
		inventory.pickupsound   "misc/w_pkup";
		inventory.pickupmessage "You got the m16.";
		scale                   0.7;
		weapon.bobrangex        0.22;
		weapon.bobrangey        0.9;
		obituary                "%o was assaulted by %k.";
		tag                     "M16";
		inventory.icon          "M16PA0";

		BBasicWeapon.BHeatDrain         12;
		BBasicWeapon.BBulletClass       "HDB_556";
		BBasicWeapon.BAmmoClass         "B556Ammo";
		BBasicWeapon.BMagazineClass     "B556Mag";
		BBasicWeapon.BGunMass           6.2;
		BBasicWeapon.BCookOff           30;
		BBasicWeapon.BHeatLimit         255;
		BBasicWeapon.BSpriteWithMag     "M16PA0";
		BBasicWeapon.BSpriteWithoutMag  "M16PB0";
		BBasicWeapon.BMagazineSprite    "M16CA0";
		BBasicWeapon.BWeaponBulk        90;
		BBasicWeapon.BMagazineBulk      19;
		BBasicWeapon.BBulletBulk        1;
		BBasicWeapon.BMagazineCapacity  30;
		BBasicWeapon.BarrelLength       25;
		BBasicWeapon.BarrelWidth        1;
		BBasicWeapon.BarrelDepth        3;
		BBasicWeapon.BFireSound         "m16/fire";
		BBasicWeapon.BChamberSound      "weapons/rifchamber";
		BBasicWeapon.BBoltForwardSound  "akm/boltf";
		BBasicWeapon.BBoltBackwardSound "akm/boltb";
		BBasicWeapon.BClickSound        "weapons/rifleclick2";
		BBasicWeapon.BLoadSound         "weapons/rifleload";
		BBasicWeapon.BROF               2;
	}

	states {
		Spawn:
			M16P A -1;
			Stop;
		Ready:
			M16G A 1;
			Goto Super::Ready;
		Select0:
			M16G A 0 {
				return ResolveState("select0small");
			}
		Deselect0:
			M16G A 0 {
				return ResolveState("deselect0small");
			}
	}

}