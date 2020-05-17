
class B_AKM : BBasicWeapon {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder   20;
		weapon.slotnumber       4;
		weapon.slotpriority     3;
		inventory.pickupsound   "misc/w_pkup";
		inventory.pickupmessage "You got the AKM.";
		scale                   0.7;
		weapon.bobrangex        0.22;
		weapon.bobrangey        0.9;
		obituary                "%o was assaulted by %k.";
		tag                     "AKM";
		inventory.icon          "AKMPA0";

		BBasicWeapon.BHeatDrain         12;
		BBasicWeapon.BBulletClass       "HDB_762";
		BBasicWeapon.BAmmoClass         "B762Ammo";
		BBasicWeapon.BMagazineClass     "B762Mag";
		BBasicWeapon.BGunMass           6.2;
		BBasicWeapon.BCookOff           30;
		BBasicWeapon.BHeatLimit         255;
		BBasicWeapon.BSpriteWithMag     "AKMPA0";
		BBasicWeapon.BSpriteWithoutMag  "AKMPB0";
		BBasicWeapon.BMagazineSprite    "AKMCA0";
		BBasicWeapon.BWeaponBulk        90;
		BBasicWeapon.BMagazineBulk      19;
		BBasicWeapon.BBulletBulk        1;
		BBasicWeapon.BMagazineCapacity  30;
		BBasicWeapon.BarrelLength       25;
		BBasicWeapon.BarrelWidth        1;
		BBasicWeapon.BarrelDepth        3;
		BBasicWeapon.BFireSound         "akm/fire";
		BBasicWeapon.BChamberSound      "weapons/rifchamber";
		BBasicWeapon.BBoltForwardSound  "akm/boltf";
		BBasicWeapon.BBoltBackwardSound "akm/boltb";
		BBasicWeapon.BClickSound        "weapons/rifleclick2";
		BBasicWeapon.BLoadSound         "weapons/rifleload";
		BBasicWeapon.BROF               2;
	}

	states {
		Spawn:
			AKMP A -1;
			Stop;
		Ready:
			AKMG A 1;
			Goto Super::Ready;
		Select0:
			AKMG A 0 {
				return ResolveState("select0small");
			}
		Deselect0:
			AKMG A 0 {
				return ResolveState("deselect0small");
			}
	}

}