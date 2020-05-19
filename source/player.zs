
class PlayerEvents : EventHandler {

	override void PlayerEntered(PlayerEvent e) {
		PlayerPawn pawn = players[e.PlayerNumber].mo;
		pawn.GiveInventoryType("Focuser");
		pawn.GiveInventoryType("FocusIn");
		pawn.GiveInventoryType("FocusOut");
		pawn.GiveInventoryType("SilencerIn");
		pawn.GiveInventoryType("FlashlightIn");
		pawn.GiveInventoryType("FlashlightOnIn");
	}

	void createLight(PlayerPawn pl) {
		let lightnPos = pl.pos + (0, 0, 48);
		lightNear = PointLight(Actor.Spawn("PointLight", lightnPos));
		lightNear.args[0] = 100;
		lightNear.args[1] = 100;
		lightNear.args[2] = 100;
		lightNear.args[3] = 48;

		let lightcPos = pl.pos + (0, 0, 0);
		lightCone = SpotLight(Actor.Spawn("SpotLight", lightcPos));
		lightCone.args[0] = 255;
		lightCone.args[1] = 255;
		lightCone.args[2] = 255;
		lightCone.args[3] = 512;
		lightCone.SpotInnerAngle = 1;
		lightCone.SpotOuterAngle = 35;
	}

	void adjustPosition(int index) {
		PlayerInfo info = players[index];
		PlayerPawn pawn = info.mo;
		lightNear.setXYZ(pawn.pos + (0, 0, 16));
		lightCone.setXYZ(pawn.pos + (0, 0, 48));
		lightCone.angle = pawn.angle;
		lightCone.pitch = pawn.pitch;
	}

	void checkPlayer(int index) {
		PlayerInfo info = players[index];
		PlayerPawn pawn = info.mo;
		if (info.ReadyWeapon is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(info.ReadyWeapon);
			if (wep.flashlight && wep.flashlightOn) {
				if (!lightNear) {
					createLight(pawn);
				}
				adjustPosition(index);
			}
			else {
				if (lightNear) {
					lightNear.destroy();
					lightCone.destroy();
				}
			}
		}
	}

	override void WorldTick() {
		checkPlayer(0);
	}

	PointLight lightNear;
	SpotLight lightCone;



}