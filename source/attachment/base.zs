

class BaseAttachment : HDPickup {
	property MountId: mountId;
	string mountId; 

	property SerialId: serialId;
	meta int serialId;

	property SpriteOffsetX: spriteOffsetX;
	property SpriteOffsetY: spriteOffsetY;
	double spriteOffsetX;
	double spriteOffsetY;

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

	// Overrides for users
	virtual void OnAttach(BHDWeapon weapon, PlayerPawn pawn) {}
	virtual void OnDettach(BHDWeapon weapon, PlayerPawn pawn) {}

}

class BaseBarrelAttachment : BaseAttachment {
	property Length: Length;
	double length;

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bBarrelMount != self.MountId) {
			return false;
		}

		if (weapon.getBarrelSerialID() > 0) {
			player.GiveInventory(weapon.barrelClass, 1);
			OnDettach(weapon, player);
		}
		weapon.setBarrelSerialID(self.serialId);
		weapon.barrelClass = getClass();

		let offsetIndex = mgr.barrelOffsetIndex(weapon, getClass());
		if (offsetIndex > -1) {
			Vector2 pos = mgr.getBarrelOffset(offsetIndex);
			weapon.useBarrelOffsets = true;
			weapon.barrelOffsets = pos;
		}
		else {
			weapon.useBarrelOffsets = false;
			weapon.barrelOffsets = (0, 0);
		}

		onAttach(weapon, player);
		return true;
	}

}

class BaseScopeAttachment : BaseAttachment {

	property BackImage: backImage;
	string backImage;

	property FrontImage: frontImage;
	string frontImage;

	property FrontOffX: frontOffX;
	property FrontOffY: frontOffY;
	property BackOffX: BackOffX;
	property BackOffY: BackOffY;
	double frontoffx;
	double frontoffy;
	double backoffx;
	double backoffy;

	property DotThreshold: dotThreshold;
	meta int dotThreshold;

	default {
		BaseScopeAttachment.DotThreshold 6;
	}

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bScopeMount != self.MountId) {
			return false;
		}

		if (weapon.getScopeSerialID() > 0) {
			player.GiveInventory(weapon.scopeClass, 1);
		}
		weapon.setScopeSerialID(self.serialID);
		weapon.scopeClass = getClass();

		let offsetIndex = mgr.scopeOffsetIndex(weapon, getClass());
		if (offsetIndex > -1) {
			Vector2 pos = mgr.getScopeOffset(offsetIndex);
			weapon.useScopeOffsets = true;
			weapon.scopeOffsets = pos;
		}
		else {
			weapon.useScopeOffsets = false;
			weapon.scopeOffsets = (0, 0);
		}

		onAttach(weapon, player);
		return true;
	}

}

class BaseSilencerAttachment : BaseBarrelAttachment {}
class BaseFlashAttachment : BaseBarrelAttachment {}

class BaseMiscAttachment : BaseAttachment {

	property OnSprite: OnSprite;
	string onSprite;

	property OnFrame: OnFrame;
	int onFrame;

	property EventClass: eventClass;
	string eventClass;

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bMiscMount != self.MountId) {
			return false;
		}

		if (weapon.getMiscSerialID() > 0) {
			player.GiveInventory(weapon.miscClass, 1);
			OnDettach(weapon, player);
		}
		weapon.setMiscSerialID(self.serialId);
		weapon.miscClass = getClass();

		let offsetIndex = mgr.miscOffsetIndex(weapon, getClass());
		if (offsetIndex > -1) {
			Vector2 pos = mgr.getMiscOffset(offsetIndex);
			weapon.useMiscOffsets = true;
			weapon.miscOffsets = pos;
		}
		else {
			weapon.useScopeOffsets = false;
			weapon.miscOffsets = (0, 0);
		}

		onAttach(weapon, player);
		return true;
	}

	static bool UsedHook(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		string evt = GetDefaultByType(cls).EventClass;
		BaseMiscAttachmentEvent inst = null;
		if (evt != "") {
			inst = BaseMiscAttachmentEvent(new (evt));
		}
		else {
			inst = new ("BaseMiscAttachmentEvent");
		}
		if (inst == null) {
			return false;
		}
		return inst.onUsed(cls, weapon, player);
	}

}

class BaseMiscAttachmentEvent {
	// Default behavior is this class is called to goggle the switch on the weapon
	// it does nothing though. To add behavior on used, inherit this class and override this function
	virtual bool onUsed(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		weapon.toggleMisc();
		return true;
	}

}
