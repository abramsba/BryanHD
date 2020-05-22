
class MiscAttachmentInput : Inventory {
	default { Inventory.MaxAmount 1; }

	override bool Use(bool pickup) {
		PlayerInfo info = players[consoleplayer];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(info.readyWeapon);
			if (wep.miscClass) {
				BaseMiscAttachment.UsedHook(wep.miscClass, wep, info.mo);
				
			}
		}
		return false;
	}



}