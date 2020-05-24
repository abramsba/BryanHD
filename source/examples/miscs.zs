
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


class FlashSpotLight : SpotLight {

	int playerOwner;

	double pitchTarget;
	double pitchNow;
	double pitchDirection;

	void adjustPitch() {
		pitchNow += pitchDirection;
		if (pitchDirection > 0 && pitchNow > pitchTarget) {
			pitchNow = pitchTarget;
		}
		else if (pitchDirection < 0 && pitchNow < pitchTarget) {
			pitchNow = pitchTarget;
		}
	}

	override void BeginPlay() {
		playerOwner = -1;
	}

	override void Tick() {
		if (playerOwner > -1) {
			PlayerInfo info = players[playerOwner];
			HDPlayerPawn ply = HDPlayerPawn(info.mo);
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (info.mo) {
				if (weapon && !weapon.miscActive) {
					self.destroy();
					return;
				}
				let newPos = info.mo.pos + (0, 0, 40);
				newPos.z -= (ply.hudbob.y / 2.0);
				SetOrigin(newPos, true);
				A_SetAngle(info.mo.angle - ply.hudbob.x, SPF_INTERPOLATE);

				if (info.cmd.buttons & BT_SPEED) {
					pitchDirection = 1;
					pitchTarget = 30;
					adjustPitch();
				}
				else {
					pitchDirection = -5;
					pitchTarget = 0;
					adjustPitch();
				}
				A_SetPitch(info.mo.pitch + pitchNow, SPF_INTERPOLATE);
			}
		}
		super.tick();
	}

}

class FlashLightManager : EventHandler {

	Array<FlashSpotLight> spotLights;

	override void OnRegister() {
		for (int i = 0; i < 8; i++) {
			spotLights.push(null);
		}
	}

	override void WorldTick() {
		for (int i = 0; i < 8; i++) {
			PlayerInfo info = players[i];
			if (!info.mo) continue;
			SpotLight light = spotLights[i];
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (!light && weapon && weapon.miscActive) {
				weapon.miscActive = false;
			}
		}
	}


	void createLight(BHDWeapon weapon, PlayerPawn player) const {
		let newPos = player.pos + (0, 0, 48);
		let light = FlashSpotLight(player.Spawn("FlashSpotLight", player.pos));
		light.playerOwner = consoleplayer;
		spotLights[consoleplayer] = light;
		light.args[0] = 205;
		light.args[1] = 221;
		light.args[2] = 238;
		light.args[3] = 256;
		light.SpotOuterAngle = 40;
	}

	void destroyLight(BHDWeapon weapon, PlayerPawn player) const {
		SpotLight light = spotLights[consoleplayer];
		if (light) {
			light.destroy();
		}
	}

	void destLight(int index) const {
		SpotLight light = spotLights[index];
		if (light) {
			light.destroy();
		}
	}

}

class B_Flashlight_Event : BaseMiscAttachmentEvent {

	override bool onUsed(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		// Toggles On or off image, depending
		super.onUsed(cls, weapon, player);
		FlashLightManager mgr = FlashLightManager(EventHandler.Find("FlashLightManager"));
		if (weapon.miscActive) {
			mgr.createLight(weapon, player);
		}
		else {
			mgr.destroyLight(weapon, player);
		}
		return true;
	}

}
