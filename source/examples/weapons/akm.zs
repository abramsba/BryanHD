
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
		BHDWeapon.EjectShellClass    "B762Spent";
		hdweapon.refid               "bw4";
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

class B_AKM_PICRAIL : B_AKM {
	default {
		inventory.pickupmessage      "You got the AKM with rails.";
		tag                          "AKMPR";
		inventory.icon               "AKPPA0";
		BHDWeapon.BSpriteWithMag     "AKPPA0";
		BHDWeapon.BSpriteWithoutMag  "AKPPB0";
		BHDWeapon.bScopeMount        "NATO_RAILS"; // test
		hdweapon.refid               "bw5";
	}
	states {
		Spawn:
			AKPP A -1 GetMagState();

		Ready:
			AKPG A 1 GetAttachmentState();
			Goto BHDWeapon::Ready;

		Select0:
			AKPG A 0 GetAttachmentState();
			AKPG A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			AKPG A 0 A_StartDeselect();

		Deselect0:
			AKPG A 0 GetAttachmentState();
			AKPG A 0 { 
				return ResolveState("Deselect0Small"); 
			}
	}
}
