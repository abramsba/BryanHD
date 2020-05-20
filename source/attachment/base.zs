
class BaseAttachment : HDPickup {
	property MountId: mountId;
	string mountId; 
	default {
		+HDPickup.FitsInBackpack
	}

	override bool Use(bool pickup) {
		//console.printf("Using attachment %p %s", owner.player, owner.getClassName());
		if (owner.player.readyWeapon && owner.player.readyWeapon is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(owner.player.readyWeapon);
			bool attached = AttemptAttach(wep, owner.player.mo);
			if (!attached) {
				console.printf("Failed to attach.");
			}
			return true;
		}
		else {
			console.printf("Incompatible weapon.");
			return false;
		}
	}

	virtual bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		return false;
	}
}

class BaseBarrelAttachment : BaseAttachment {
	property Length: Length;
	double length;

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		if (!weapon.barrelAttachment) {
			console.printf("Barrel: %p", weapon.barrelAttachment);
			weapon.barrelAttachment = self;
			return true;
		}
		return false;
	}
}

class BaseScopeAttachment : BaseAttachment {

}

class BaseMiscAttachment : BaseAttachment {

}