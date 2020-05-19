
class SilencerIn : Inventory {
	default { Inventory.MaxAmount 1; }
	override bool Use(bool pickup) {
		PlayerInfo player = players[consoleplayer];
		BHDWeapon wep = BHDWeapon(player.ReadyWeapon);
		wep.silencer = !wep.silencer;
		return false;
	}
}