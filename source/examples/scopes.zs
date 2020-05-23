
class B_Scope40mm : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 1;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 0;
		BaseAttachment.MountId "NATO_RAILS";
		BaseScopeAttachment.FrontImage "TNT1A0";
		BaseScopeAttachment.BackImage "TNT1A0";
		HDPickup.Bulk 1;
		HDPickup.RefId "BM16SCOP";
		Tag "4x40 M16 Scope";
		Inventory.Icon "SCOPB0";
		Inventory.PickupMessage "Picked up a 4x40 M16 Scope.";
	}

	States {
		Spawn:
			SCOP B -1;
			Stop;

		OverlayImage:
			SCOP A -1;
			Stop;
	}
}

class B_ACOG_Red : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 2;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 0;
		BaseAttachment.MountId "NATO_RAILS";
		BaseScopeAttachment.FrontImage "acog1";
		BaseScopeAttachment.BackImage "acog1sg";
		BaseScopeAttachment.FrontOffY 16;
		BaseScopeAttachment.BackOffY 8;
		HDPickup.Bulk 1;
		HDPickup.RefId "ACOG1SIG";
		Tag "ACOG Sight (Red)";
		Inventory.Icon "SCOPE0";
		Inventory.PickupMessage "Picked up an ACOG Sight (Red).";
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

class B_ACOG_Green : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 3;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 2;
		BaseAttachment.MountId "NATO_RAILS";
		BaseScopeAttachment.FrontImage "acog2";
		BaseScopeAttachment.BackImage "acog1sg";
		BaseScopeAttachment.FrontOffY 16;
		BaseScopeAttachment.BackOffY 8;
		BaseScopeAttachment.DotThreshold 30;
		HDPickup.Bulk 1;
		HDPickup.RefId "ACOG1SIG";
		Tag "ACOG Sight (Green)";
		Inventory.Icon "SCOPF0";
		Inventory.PickupMessage "Picked up an ACOG Sight (Green).";
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

class B_Sight_Rdot : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 4;
		BaseAttachment.BaseSprite "SDOT";
		BaseAttachment.BaseFrame 0;
		BaseAttachment.MountId "NATO_RAILS";
		BaseScopeAttachment.FrontImage "rdot";
		BaseScopeAttachment.BackImage "rdotsg";
		BaseScopeAttachment.FrontOffY 1;
		BaseScopeAttachment.BackOffY 4;
		BaseScopeAttachment.DotThreshold 180;
		HDPickup.Bulk 1;
		HDPickup.RefId "SIG1SIT";
		Tag "Red-dot Sight";
		Inventory.Icon "SDOTB0";
		Inventory.PickupMessage "Picked up a Red-dot Sight.";
	}

	States {
		Spawn:
			SDOT B -1;
			Stop;

		OverlayImage:
			SDOT A -1;
			Stop;
	}
}



class B_Sight_Gdot : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 5;
		BaseAttachment.BaseSprite "SDOT";
		BaseAttachment.BaseFrame 0;
		BaseAttachment.MountId "NATO_RAILS";
		BaseScopeAttachment.FrontImage "gdot";
		BaseScopeAttachment.BackImage "rdotsg";
		BaseScopeAttachment.FrontOffY 10;
		BaseScopeAttachment.BackOffY 8;
		BaseScopeAttachment.DotThreshold 180;
		HDPickup.Bulk 1;
		HDPickup.RefId "SIG1SIT";
		Tag "Green-dot Sight";
		Inventory.Icon "SDOTC0";
		Inventory.PickupMessage "Picked up a Green-dot Sight.";
	}

	States {
		Spawn:
			SDOT C -1;
			Stop;

		OverlayImage:
			SDOT A -1;
			Stop;
	}
}