
class BaseAcog : BaseScopeAttachment {
	default {
		BaseSightAttachment.FrontImage "acogcr";
		BaseSightAttachment.BackImage "acogsg2";
		BaseSightAttachment.FrontOffY 5;
		BaseSightAttachment.BackOffY 9;
		BaseScopeAttachment.XScaleCam        0.31;
		BaseScopeAttachment.YScaleCam        0.31;
		BaseScopeAttachment.XPosCam          0;
		BaseScopeAttachment.YPosCam          56;
		BaseScopeAttachment.ScaledWidth      57;
		BaseScopeAttachment.XClipCam         -28;
		BaseScopeAttachment.YClipCam         27;
		BaseScopeAttachment.ScopeHoleX       0;
		BaseScopeAttachment.ScopeHoleY       58;
		BaseScopeAttachment.ScopeScaleX      0.78;
		BaseScopeAttachment.ScopeScaleY      0.78;
		BaseScopeAttachment.ScopeImageX      0;
		BaseScopeAttachment.ScopeImageY      64;
		BaseScopeAttachment.ScopeImageScaleX 1;
		BaseScopeAttachment.ScopeImageScaleY 1;
		BaseScopeAttachment.ScopeBackX       0;
		BaseScopeAttachment.ScopeBackY       54;
		HDPickup.Bulk 1;
		BaseScopeAttachment.ScopeImage "acog2sg";
		BaseScopeAttachment.SightImage "acog1";
		BaseAttachment.MountId "NATO_RAILS";
	}
}

class BaseAcogType2 : BaseAcog {
	default {
		BaseSightAttachment.FrontImage "rdot";
		BaseScopeAttachment.SightImage "acog2";
		BaseSightAttachment.BackImage "rdotcog";
		BaseSightAttachment.FrontOffY 1;
		BaseSightAttachment.BackOffY 0;
	}
}

class BaseCompactDotSight : BaseSightAttachment {
	default {
		BaseAttachment.MountId "NATO_RAILS";
		BaseSightAttachment.BackImage "rdotsg";
		BaseSightAttachment.FrontOffY 1;
		BaseSightAttachment.BackOffY 9;
		HDPickup.Bulk 1;
	}
}


class BaseFullDotSight : BaseSightAttachment {
	default {
		BaseSightAttachment.FrontImage "rdot";
		BaseSightAttachment.BackImage "rdssg";
		BaseSightAttachment.FrontOffY 1;
		BaseSightAttachment.BackOffY -2;
		BaseSightAttachment.DotThreshold 180;
		HDPickup.Bulk 1;
		BaseAttachment.MountId "NATO_RAILS";
	}
}

class BaseHoloSight : BaseFullDotSight {
	default {
		BaseSightAttachment.FrontImage "holir";
		BaseSightAttachment.BackImage "holsg";
		BaseSightAttachment.FrontOffY 3;
		BaseSightAttachment.BackOffY 4;
	}
}

// Red Sights

class B_ACOG_Red : BaseAcog {
	default {
		BaseAttachment.SerialId 1;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 0;
		Tag "Red M4 ACOG (iron Sight).";
		Inventory.Icon "SCOPE0";
		Inventory.PickupMessage "Picked up a red M4 ACOG (iron Sight).";
	}

	States {
		Spawn:
			SCOP E -1;
			Stop;

		OverlayImage:
			SCOP A -1;
			Stop;
	}
}

class B_ACOG_red2 : BaseAcogType2 {
	default {
		BaseAttachment.SerialId 2;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 13;
		Tag "Red M4 ACOG Sight (red dot)";
		Inventory.Icon "SCOPG0";
		Inventory.PickupMessage "Picked up a red M4 ACOG sight (red dot).";
	}

	States {
		Spawn:
			SCOP G -1;
			Stop;

		OverlayImage:
			SCOP N -1;
			Stop;
	}
}

// Compact Red Dots

class B_Sight_Rdot : BaseCompactDotSight {
	default {
		BaseAttachment.SerialId 3;
		BaseAttachment.BaseSprite "SDOT";
		BaseAttachment.BaseFrame 0;
		BaseSightAttachment.FrontImage "rdot";
		BaseSightAttachment.BackOffY 5;
		HDPickup.RefId "SIG1SIT";
		Tag "Red-dot Sight";
		Inventory.Icon "SCOPI0";
		Inventory.PickupMessage "Picked up a Red-dot Sight.";
	}

	States {
		Spawn:
			SCOP I -1;
			Stop;

		OverlayImage:
			SDOT A -1;
			Stop;
	}
}

// Full Dot Sights

class B_Sight_CRdot : BaseFullDotSight {
	default {
		BaseAttachment.SerialId 4;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 10;
		HDPickup.RefId "acr";
		Tag "Red-dot full sight";
		Inventory.Icon "SCOPG0";
		Inventory.PickupMessage "Picked up a red-dot full sight.";
	}

	States {
		Spawn:
			SCOP G -1;
			Stop;

		OverlayImage:
			SCOP K -1;
			Stop;
	}
}

class B_Sight_Holo_Red : BaseHoloSight {
	default {
		BaseAttachment.SerialId 5;
		BaseAttachment.BaseSprite "HOLG";
		BaseAttachment.BaseFrame 0;
		Tag "Red-dot round sight";
		Inventory.Icon "HOLGB0";
		Inventory.PickupMessage "Picked up a red-dot round sight.";
	}

	States {
		Spawn:
			HOLG B -1;
			Stop;

		OverlayImage:
			HOLG A -1;
			Stop;
	}
}











/*

class B_ACOG_Green : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 3;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 2;
		BaseAttachment.MountId "NATO_RAILS";
		BaseSightAttachment.FrontImage "acogcr";
		BaseSightAttachment.BackImage "acogsg2";
		BaseSightAttachment.FrontOffY 5;
		BaseSightAttachment.BackOffY 15;
		//BaseSightAttachment.DotThreshold 30;

		BaseScopeAttachment.ScopeImage "acog2sg";
		BaseScopeAttachment.SightImage "acog2";

		BaseScopeAttachment.XScaleCam        0.31;
		BaseScopeAttachment.YScaleCam        0.31;
		BaseScopeAttachment.XPosCam          0;
		BaseScopeAttachment.YPosCam          63;
		BaseScopeAttachment.ScaledWidth      57;
		BaseScopeAttachment.XClipCam         -28;
		BaseScopeAttachment.YClipCam         35;
		BaseScopeAttachment.ScopeHoleX       0;
		BaseScopeAttachment.ScopeHoleY       62;
		BaseScopeAttachment.ScopeScaleX      0.78;
		BaseScopeAttachment.ScopeScaleY      0.78;
		BaseScopeAttachment.ScopeImageX      0;
		BaseScopeAttachment.ScopeImageY      70;
		BaseScopeAttachment.ScopeImageScaleX 1;
		BaseScopeAttachment.ScopeImageScaleY 1;
		BaseScopeAttachment.ScopeBackX       0;
		BaseScopeAttachment.ScopeBackY       63;


		HDPickup.Bulk 1;
		HDPickup.RefId "ACOG1SIG";
		Tag "Green M4 ACOG (Iron Sight)";
		Inventory.Icon "SCOPF0";
		Inventory.PickupMessage "Picked up a green M4 ACOG (Iron Sight).";
	}

	States {
		Spawn:
			SCOP F -1;
			Stop;

		OverlayImage:
			SCOP C -1;
			Stop;
	}
}





/*
class B_Sight_Gdot : BaseSightAttachment {
	default {
		BaseAttachment.SerialId 5;
		BaseAttachment.BaseSprite "SDOT";
		BaseAttachment.BaseFrame 0;
		BaseAttachment.MountId "NATO_RAILS";
		BaseSightAttachment.FrontImage "gdot";
		BaseSightAttachment.BackImage "rdotsg";
		BaseSightAttachment.FrontOffY 1;
		BaseSightAttachment.BackOffY 14;
		BaseSightAttachment.DotThreshold 180;
		HDPickup.Bulk 1;
		HDPickup.RefId "SIG1SIT";
		Tag "Green-dot Sight";
		Inventory.Icon "SCOPJ0";
		Inventory.PickupMessage "Picked up a Green-dot Sight.";
	}

	States {
		Spawn:
			SCOP J -1;
			Stop;

		OverlayImage:
			SDOT A -1;
			Stop;
	}
}


class B_ACOG_Green2 : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 6;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 12;
		BaseAttachment.MountId "NATO_RAILS";
		BaseSightAttachment.FrontImage "rdot";
		BaseSightAttachment.BackImage "rdotsg";
		BaseSightAttachment.FrontOffY 1;
		BaseSightAttachment.BackOffY 14;
		BaseSightAttachment.DotThreshold 180;

		BaseScopeAttachment.ScopeImage "acog2sg";
		BaseScopeAttachment.SightImage "acog2";

		BaseScopeAttachment.XScaleCam        0.31;
		BaseScopeAttachment.YScaleCam        0.31;
		BaseScopeAttachment.XPosCam          0;
		BaseScopeAttachment.YPosCam          63;
		BaseScopeAttachment.ScaledWidth      57;
		BaseScopeAttachment.XClipCam         -28;
		BaseScopeAttachment.YClipCam         35;
		BaseScopeAttachment.ScopeHoleX       0;
		BaseScopeAttachment.ScopeHoleY       62;
		BaseScopeAttachment.ScopeScaleX      0.78;
		BaseScopeAttachment.ScopeScaleY      0.78;
		BaseScopeAttachment.ScopeImageX      0;
		BaseScopeAttachment.ScopeImageY      70;
		BaseScopeAttachment.ScopeImageScaleX 1;
		BaseScopeAttachment.ScopeImageScaleY 1;
		BaseScopeAttachment.ScopeBackX       0;
		BaseScopeAttachment.ScopeBackY       63;


		HDPickup.Bulk 1;
		HDPickup.RefId "ACOG1SIG";
		Tag "Green M4 ACOG (red Dot)";
		Inventory.Icon "SCOPH0";
		Inventory.PickupMessage "Picked up a green M4 ACOG (red dot)";
	}

	States {
		Spawn:
			SCOP H -1;
			Stop;

		OverlayImage:
			SCOP M -1;
			Stop;
	}
}
*/


