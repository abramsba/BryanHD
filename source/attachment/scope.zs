
class B_Scope40mm : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 1;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 0;
		BaseAttachment.MountId "M16_SCOPE_RAIL";
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
		BaseAttachment.MountId "M16_SCOPE_RAIL";
		BaseScopeAttachment.FrontImage "acog1";
		BaseScopeAttachment.BackImage "acog1sg";
		BaseScopeAttachment.FrontOffY 16;
		BaseScopeAttachment.BackOffY 8;
		HDPickup.Bulk 1;
		HDPickup.RefId "ACOG1SIG";
		Tag "ACOG Sight (Red)";
		Inventory.Icon "SCOPB0";
		Inventory.PickupMessage "Picked up an ACOG Sight (Red).";
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

class B_ACOG_Green : BaseScopeAttachment {
	default {
		BaseAttachment.SerialId 3;
		BaseAttachment.BaseSprite "SCOP";
		BaseAttachment.BaseFrame 2;
		BaseAttachment.MountId "M16_SCOPE_RAIL";
		BaseScopeAttachment.FrontImage "acog2";
		BaseScopeAttachment.BackImage "acog1sg";
		BaseScopeAttachment.FrontOffY 16;
		BaseScopeAttachment.BackOffY 8;
		HDPickup.Bulk 1;
		HDPickup.RefId "ACOG1SIG";
		Tag "ACOG Sight (Green)";
		Inventory.Icon "SCOPB0";
		Inventory.PickupMessage "Picked up an ACOG Sight (Green).";
	}

	States {
		Spawn:
			SCOP B -1;
			Stop;

		OverlayImage:
			SCOP C -1;
			Stop;
	}
}