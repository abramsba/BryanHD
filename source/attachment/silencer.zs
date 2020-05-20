
class B_M16_Silencer : BaseBarrelAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "556_NATO_BARREL";
		HDPickup.Bulk 1;
		HDPickup.RefId "BM16SIL";
		Tag "5.56m barrel silencer";
		Inventory.Icon "SL56A0";
		Inventory.PickupMessage "Picked up 5.56m barrel silencer.";
	}

	States {
		Spawn:
			PIST A -1;
			Stop;
	}
	
}