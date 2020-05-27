
class B_M4 : BaseStandardRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          2;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M4.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "M4";
		inventory.icon               "M4RPA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_556";
		BHDWeapon.BAmmoClass         "B556Ammo";
		BHDWeapon.BMagazineClass     "B556Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M4RPA0";
		BHDWeapon.BSpriteWithoutMag  "M4RPB0";
		BHDWeapon.BMagazineSprite    "M16CA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      19;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		BHDWeapon.BFireSound         "m16/fire";
		BHDWeapon.BSFireSound        "m16/silfire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltb";
		BHDWeapon.BBoltBackwardSound "akm/boltf";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               1;
		BHDWeapon.BBackSightImage    "mrsig1";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       26;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      7;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "556_NATO_BARREL";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
	}

	states {
		Spawn:
			M4RP A -1 GetMagState();
			Stop; 
			
		Ready:
			M4RG A 1 GetAttachmentState();
			Goto Super::Ready;
			
		Select0:
			M4RG A 0 GetAttachmentState();
			M4RG A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			M4RG A 0 A_StartDeselect();

		Deselect0:
			M4RG A 0 GetAttachmentState();
			M4RG A 0 { 
				return ResolveState("Deselect0Small"); 
			}

	}
}


class B_M4_M203 : BaseGLRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          10;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M4 M203.";
		scale                        0.7;
		weapon.bobrangex             0.27;
		weapon.bobrangey             0.96;
		obituary                     "%o was assaulted by %k.";
		tag                          "M4GL";
		inventory.icon               "M4RPC0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_556";
		BHDWeapon.BAmmoClass         "B556Ammo";
		BHDWeapon.BMagazineClass     "B556Mag";
		BHDWeapon.BGunMass           7.5;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M4RPC0";
		BHDWeapon.BSpriteWithFrame   2;
		BHDWeapon.BSpriteWithoutFrame 3;
		BHDWeapon.BSpriteWithoutMag  "M4RPD0";
		BHDWeapon.BMagazineSprite    "M16CA0";
		BHDWeapon.BWeaponBulk        100;
		BHDWeapon.BMagazineBulk      19;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		BHDWeapon.BFireSound         "m16/fire";
		BHDWeapon.BSFireSound        "m16/silfire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltb";
		BHDWeapon.BBoltBackwardSound "akm/boltf";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               1;
		BHDWeapon.BBackSightImage    "mrsig1";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       26;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      7;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "556_NATO_BARREL";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BaseAltRifle.bAltMagClass    "HDRocketAmmo";
		BaseAltRifle.BAltMagPicture  "ROQPA0";

	}

	states {
		Spawn:
			M4RP C -1 GetMagState();
			Stop; 
			
		Ready:
			M4RG A 1 GetAttachmentState();
			Goto Super::Ready;
			
		Select0:
			M4RG A 0 GetAttachmentState();
			M4RG A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			M4RG A 0 A_StartDeselect();

		Deselect0:
			M4RG A 0 GetAttachmentState();
			M4RG A 0 { 
				return ResolveState("Deselect0Small"); 
			}

	}
}
