
class B_M16 : BaseStandardRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          1;
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
		BHDWeapon.BSFireSound        "m16/silfire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltb";
		BHDWeapon.BBoltBackwardSound "akm/boltf";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               1;
		BHDWeapon.BBackSightImage    "m16sight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       26;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      7;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "556_NATO_BARREL";
		BHDWeapon.bScopeMount        "NONE";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BHDWeapon.EjectShellClass    "B556Spent";
		hdweapon.refid               "bw1";
	}

	states {
		Spawn:
			M16P A -1 GetMagState();

		Ready:
			M16G A 1 GetAttachmentState();
			Goto Super::Ready;

		Select0:
			M16G A 0 GetAttachmentState();
			M16G A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			M16G A 0 A_StartDeselect();

		//Deselect0:
		//	M16G A 0 GetAttachmentState();
		//	M16G A 0 { 
		//		return ResolveState("Deselect0Small"); 
		//	}

		Flash:
			TNT1 A 0 {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					let psp = player.FindPSprite(-1000);
					if (psp) {
						psp.sprite = GetSpriteIndex("FLSHA0");
						psp.frame = 0;
					}
				}
			}
			Goto super::flash;

		Flashes:
			FLSH A -1;
			FLSH B -1;

	}

	

	
}

class B_M16_M203 : BaseGLRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          20;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M16 M203.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "M16 M203";
		inventory.icon               "M16PC0";

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_556";
		BHDWeapon.BAmmoClass         "B556Ammo";
		BHDWeapon.BMagazineClass     "B556Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M16PC0";
		BHDWeapon.BSpriteWithoutMag  "M16PD0";
		BHDWeapon.BSpriteWithFrame    2;
		BHDWeapon.BSpriteWithoutFrame 3;
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
		BHDWeapon.BBackSightImage    "m16sight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       26;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      7;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "556_NATO_BARREL";
		BHDWeapon.bScopeMount        "NONE";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BaseAltRifle.bAltMagClass    "HDRocketAmmo";
		BaseAltRifle.BAltMagPicture  "ROQPA0";
		BHDWeapon.EjectShellClass    "B556Spent";
		hdweapon.refid               "bw2";
	}

	states {
		Spawn:
			M16P C -1 GetMagState();

		Ready:
			M16G A 1 GetAttachmentState();
			Goto Super::Ready;

		Select0:
			M16G A 0 GetAttachmentState();
			M16G A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			M16G A 0 A_StartDeselect();

		//Deselect0:
		//	M16G A 0 GetAttachmentState();
		//	M16G A 0 { 
		//		return ResolveState("Deselect0Small"); 
		//	}

		Flash:
			TNT1 A 0 {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					let psp = player.FindPSprite(-1000);
					if (psp) {
						psp.sprite = GetSpriteIndex("FLSHA0");
						psp.frame = random(0, 1);
					}
				}
			}
			Goto super::flash;
	
		Flashes:
			FLSH A -1;
			FLSH B -1;

	}
}