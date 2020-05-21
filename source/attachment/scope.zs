
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