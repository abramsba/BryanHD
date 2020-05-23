
class B_M16_Flashlight : BaseMiscAttachment {
	default {
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId 1;
		BaseAttachment.BaseSprite "FLMR";
		BaseAttachment.BaseFrame 0;
		BaseMiscAttachment.OnSprite "FLMR";
		BaseMiscAttachment.OnFrame 1;
		BaseMiscAttachment.EventClass "B_Flashlight_Event";
		HDPickup.Bulk 1;
		HDPickup.RefId "M16FLS";
		Tag "M16 flashlight mount";
		Inventory.Icon "FLMRC0";
		Inventory.PickupMessage "Picked up M16 flashlight mount";
	}

	States {
		Spawn:
			FLMR C -1;
			Stop;

		OverlayImage:
			FLMR A -1;
			FLMR B -1;
			Stop;
	}
}

class B_Flashlight_Event : BaseMiscAttachmentEvent {
	override bool onUsed(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		super.onUsed(cls, weapon, player);
		// If flashlight on, enable player light
		// else turn it off
		console.printf("Flashlight event");
		return true;
	}
}
