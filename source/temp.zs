
class BSilencerRemover : HDPickup {
	default {
		Inventory.MaxAmount 1;
		Inventory.Icon "SL56E0";
		-hdpickup.fitsinbackpack
		tag "Silencer Remover";
	}

	override bool Use(bool pickup) {
		PlayerInfo info = players[consoleplayer];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (weapon.getBarrelSerialID() > 0) {
				info.mo.GiveInventory(weapon.barrelClass, 1);
				// TODO: Hm, to call this we need an actor
				// weapon.OnDettach(weapon, player);
				owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("BarrelAttachmentRemove"));

				//weapon.setBarrelSerialID(0);
				//weapon.barrelClass = null;
				//weapon.useBarrelOffsets = false;
				//weapon.barrelOffsets = (0, 0);
			}
		}
		return false;
	}

	States {
		Spawn:
			SL56 E -1;
			Stop;
		
	}
}

class BScopeRemover : HDPickup {
	default {
		Inventory.MaxAmount 1;
		Inventory.Icon "SCOPD0";
		-hdpickup.fitsinbackpack
		tag "Scope Remover";
	}

	override bool Use(bool pickup) {
		PlayerInfo info = players[consoleplayer];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (weapon.getScopeSerialID() > 0) {
				info.mo.GiveInventory(weapon.scopeClass, 1);
				owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("ScopeAttachmentRemove"));
				//weapon.setScopeSerialID(0);
				//weapon.scopeClass = null;
				//weapon.useScopeOffsets = false;
				//weapon.scopeOffsets = (0, 0);
			}
		}
		return false;
	}

	States {
		Spawn:
			SCOP D -1;
			Stop;
		
	}
}

class BMiscRemover : HDPickup {
	default {
		Inventory.MaxAmount 1;
		Inventory.Icon "FLMRD";
		-hdpickup.fitsinbackpack
		tag "Scope Remover";
	}

	override bool Use(bool pickup) {
		PlayerInfo info = players[consoleplayer];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (weapon.getMiscSerialID() > 0) {
				info.mo.GiveInventory(weapon.miscClass, 1);
				owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("MiscAttachmentRemove"));
				//weapon.setMiscSerialID(0);
				//weapon.miscClass = null;
				//weapon.useMiscOffsets = false;
				//weapon.miscOffsets = (0, 0);
			}
		}
		return false;
	}

	States {
		Spawn:
			FLMR D -1;
			Stop;
		
	}
}