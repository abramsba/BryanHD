
class B_MP5K : BaseStandardRifle {

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
		BHDWeapon.BSFireSound        "m16/silfire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "akm/boltf";
		BHDWeapon.BBoltBackwardSound "akm/boltb";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               2;
		BHDWeapon.BBackSightImage    "mpksight";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       28;
		BHDWeapon.BFrontSightImage   "mpkiron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      4;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "9MM_MP5K_BARREL";
		BHDWeapon.bScopeMount        "NATO_RAILS";
	}

	states {
		Spawn:
			MP5P A -1 GetMagState();
			Stop;

		Ready:
			MP5K A 1 GetAttachmentState();
			Goto Super::Ready;

		Select0:
			MP5K A 0 GetAttachmentState();
			MP5K A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			MP5K A 0 A_StartDeselect();

		Deselect0:
			MP5K A 0 GetAttachmentState();
			MP5K A 0 { 
				return ResolveState("Deselect0Small"); 
			}
	}
}


class Mp5kSilencerOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_MP5k";
		Offset.WeaponOverlay "B_M16_Silencer";
		Offset.OffX -1;
		Offset.OffY 20;
	}
}


class Mp5kExtenderOffset : BarrelOffset {
	default {
		Offset.WeaponClass "B_MP5k";
		Offset.WeaponOverlay "B_M16_Extender";
		Offset.OffX -1;
		Offset.OffY 20;
	}
}

class Mp5kAcogGreenOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5k";
		Offset.WeaponOverlay "B_ACOG_Green";
		Offset.OffX -1;
		offset.OffY 10;
	}
}

class Mp5kAcogRedOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5k";
		Offset.WeaponOverlay "B_ACOG_Red";
		Offset.OffX -1;
		offset.OffY 10;
	}
}

class Mp5kGDotOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5k";
		Offset.WeaponOverlay "B_Sight_Gdot";
		Offset.OffX -1;
		offset.OffY 5;
	}
}

class Mp5kRDotOffset : ScopeOffset {
	default {
		Offset.WeaponClass "B_MP5k";
		Offset.WeaponOverlay "B_Sight_Rdot";
		Offset.OffX -1;
		offset.OffY 5;
	}
}