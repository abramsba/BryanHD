
class B_AKM : BHDWeapon {

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

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_762";
		BHDWeapon.BAmmoClass         "B762Ammo";
		BHDWeapon.BMagazineClass     "B762Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "AKMPA0";
		BHDWeapon.BSpriteWithoutMag  "AKMPB0";
		BHDWeapon.BMagazineSprite    "AKMCA0";
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
		BHDWeapon.BBackSightImage    "akmsight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       8;
		BHDWeapon.BFrontSightImage   "akmiron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      10;
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