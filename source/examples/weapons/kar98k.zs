
// WIP Bolt Rifles todo
class B_KAR98K : BaseBoltRifle {

		default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          3;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the KAR98K.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "KAR98K";
		inventory.icon               "KR9GA0";

		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_792";
		BHDWeapon.BAmmoClass         "B792Ammo";
		BHDWeapon.BMagazineClass     "B792_KAR98_Clip";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "KR9GA0";
		BHDWeapon.BSpriteWithoutMag  "KR9GB0";
		BHDWeapon.BMagazineSprite    "KR9AA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      19;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  5;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		BHDWeapon.BFireSound         "m16/fire";
		BHDWeapon.BSFireSound        "m16/silfire";
		BHDWeapon.BChamberSound      "weapons/rifchamber";
		BHDWeapon.BBoltForwardSound  "kar/bolt";
		BHDWeapon.BBoltBackwardSound "kar/bolt";
		BHDWeapon.BClickSound        "weapons/rifleclick2";
		BHDWeapon.BLoadSound         "weapons/rifleload";
		BHDWeapon.BROF               1;
		BHDWeapon.BBackSightImage    "karsg";
		BHDWeapon.BBackOffsetX       0;
		BHDWeapon.BBackOffsetY       24;
		BHDWeapon.BFrontSightImage   "karir";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      4;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "KAR98K_BARREL";
		BHDWeapon.EjectShellClass    "B792Spent";
		hdweapon.refid               "bw3";
		BHDWeapon.bScopeMount        "NATO_RAILS";
	}

	states {
		Spawn:
			KR9G A -1 GetMagState();

		Ready:
			KR98 A 1 GetAttachmentState();
			Goto BHDWeapon::Ready;

		Select0:
			KR98 A 0 GetAttachmentState();
			KR98 A 0 { 
				return ResolveState("Select0Small"); 
			}

		deselect:
			KR98 A 0 A_StartDeselect();

		Deselect0:
			KR98 A 0 GetAttachmentState();
			KR98 A 0 { 
				return ResolveState("Deselect0Small"); 
			}

	}

}

class KarScopeOffset1 : ScopeOffset {
	default {
		Offset.WeaponClass "B_KAR98K";
		Offset.WeaponOverlay "B_Sight_CRdot";
		Offset.OffX -1;
		Offset.OffY 10;
	}
}