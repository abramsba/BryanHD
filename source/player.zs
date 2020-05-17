
class PlayerEvents : EventHandler {
	override void PlayerEntered(PlayerEvent e) {
		PlayerPawn pawn = players[e.PlayerNumber].mo;
		pawn.GiveInventoryType("Focuser");
		pawn.GiveInventoryType("FocusIn");
		pawn.GiveInventoryType("FocusOut");
	}
}