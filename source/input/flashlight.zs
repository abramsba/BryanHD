

class FlashlightIn : Inventory {
	default { Inventory.MaxAmount 1; }
	override bool Use(bool pickup) {
		PlayerInfo player = players[consoleplayer];
		BHDWeapon wep = BHDWeapon(player.ReadyWeapon);
		wep.flashlight = !wep.flashlight;
		if (wep.flashlightOn) {
			wep.flashlightOn = false;
		}
		return false;
	}
}

class FlashlightOnIn : Inventory {
	default { Inventory.MaxAmount 1; }
	override bool Use(bool pickup) {
		PlayerInfo player = players[consoleplayer];
		BHDWeapon wep = BHDWeapon(player.ReadyWeapon);
		if (wep.flashlight) {
			wep.flashlightOn = !wep.flashlightOn;
		}
		return false;
	}
}