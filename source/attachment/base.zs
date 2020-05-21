
const B_BARREL = 31;
const B_MISC   = 65280;
const B_SCOPE  = 16711680;

class BaseAttachment : HDPickup {
	property MountId: mountId;
	string mountId; 

	property SerialId: serialId;
	meta int serialId;

	property BaseSprite: baseSprite;
	string baseSprite;

	property BaseFrame: baseFrame;
	int baseFrame;

	default {
		+HDPickup.FitsInBackpack
		BaseAttachment.SerialId -1;
	}

	override bool Use(bool pickup) {
		if (owner.player.readyWeapon && owner.player.readyWeapon is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(owner.player.readyWeapon);
			bool attached = AttemptAttach(wep, owner.player.mo);
			if (!attached) {
				console.printf("Failed to attach.");
			}
			return attached;
		}
		else {
			console.printf("Incompatible weapon.");
			return false;
		}
	}

	virtual bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		return false;
	}

	virtual void SetHDStatus(BHDWeapon weapon) {}
}

class BaseBarrelAttachment : BaseAttachment {
	property Length: Length;
	double length;

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		weapon.weaponStatus[I_BARREL] = self.serialId;
		weapon.barrelClass = getClass();
		return true;
	}

}

class BaseScopeAttachment : BaseAttachment {

}

class BaseMiscAttachment : BaseAttachment {

}