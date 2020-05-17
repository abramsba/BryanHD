

class Focuser : Inventory {
	default { Inventory.MaxAmount 1; }
	double targetFov;
	double currentFov;
	int direction;
	override void DoEffect() {
		if (targetFov == 0 || currentFov == 0 || direction == 0) {
			return;
		}

		currentFov += (direction * 6);
		if (direction == -1 && (currentFov <= targetFov)) {
			direction == 0;
			currentFov = targetFov;
		}
		else if (direction ==  1 && (currentFov >= targetFov)) {
			direction == 0;
			currentFov = targetFov;
		}
		PlayerPawn pl = PlayerPawn(owner);
		pl.player.fov = currentFov;
	}

}

class FocusIn : Inventory {
	default { Inventory.MaxAmount 1; }
	override bool Use(bool pickup) {
		Focuser f = Focuser(owner.FindInventory("Focuser"));
		f.direction = -1;
		f.targetFov = 70;
		f.currentFov = owner.player.fov;
		return false;
	}
}

class FocusOut : Inventory {
	default { Inventory.MaxAmount 1; }
	override bool Use(bool pickup) {
		Focuser f = Focuser(owner.FindInventory("Focuser"));
		f.direction = 1;
		f.targetFov = owner.player.desiredFov;
		f.currentFov = owner.player.fov;
		return false;
	}
}