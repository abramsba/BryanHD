
class B_AKM : BHDWeapon {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the AKM.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "AKM";
		inventory.icon               "AKMPA0";

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_762";
		BHDWeapon.BAmmoClass         "B762Ammo";
		BHDWeapon.BMagazineClass     "B762_AKM_Mag";
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
		BHDWeapon.BSFireSound        "m16/silfire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltf";
		BHDWeapon.BBoltBackwardSound "akm/boltb";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               5;
		BHDWeapon.BBackSightImage    "akmsight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       24;
		BHDWeapon.BFrontSightImage   "akmiron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      6;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "NONE";
		BHDWeapon.bScopeMount        "NONE"; // test
		BHDWeapon.bMiscMount         "NONE";
	}

	states {
		Spawn:
			AKMP A -1 GetMagState();

		Ready:
			AKMG A 1 GetAttachmentState();
			Goto Super::Ready;

		Select0:
			AKMG A 0 GetAttachmentState();
			AKMG A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			AKMG A 0 A_StartDeselect();

		Deselect0:
			AKMG A 0 GetAttachmentState();
			AKMG A 0 { 
				return ResolveState("Deselect0Small"); 
			}

	}

}

class AkmSilencerOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_AKM";
		Offset.WeaponOverlay "B_M16_Silencer";
		Offset.OffX 0;
		Offset.OffY -9;
	}
}


class AkmExtenderOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_AKM";
		Offset.WeaponOverlay "B_M16_Extender";
		Offset.OffX 0;
		Offset.OffY -9;
	}
}
