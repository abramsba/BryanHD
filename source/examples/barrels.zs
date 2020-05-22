class B_M16_Silencer : BaseSilencerAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "556_NATO_BARREL";
		BaseAttachment.SerialId 1;
		BaseAttachment.BaseSprite "SL56";
		BaseAttachment.BaseFrame 0;
		HDPickup.Bulk 1;
		HDPickup.RefId "BM16SIL";
		Tag "5.56m barrel silencer";
		Inventory.Icon "SL56D0";
		Inventory.PickupMessage "Picked up 5.56m barrel silencer.";
	}

	States {
		Spawn:
			SL56 D -1;
			Stop;
		OverlayImage:
			SL56 A -1;
			Stop;
	}
	
}

class B_M16_Extender : BaseBarrelAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "556_NATO_BARREL";
		BaseAttachment.SerialId 2;
		BaseAttachment.BaseSprite "SL56";
		BaseAttachment.BaseFrame 1;
		HDPickup.Bulk 1;
		HDPickup.RefId "BM16SIL";
		Tag "5.56m barrel extender";
		Inventory.Icon "SL56C0";
		Inventory.PickupMessage "Picked up 5.56m barrel extender.";
	}

	States {
		Spawn:
			SL56 C -1;
			Stop;
		OverlayImage:
			SL56 B -1;
			Stop;
	}
	
}