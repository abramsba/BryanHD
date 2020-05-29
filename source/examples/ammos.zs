
class B556Ammo : BRoundAmmo {
	default {
		tag "5.56 round";
		hdpickup.refid "b56";
		hdpickup.bulk ENC_556;
	}
	override string pickupmessage(){
		return "Picked up a stray 5.56 round.";
	}
}

class B556Brass : BRoundShell {
	default {
		tag "5.56 brass";
		HDPickUp.RefId "B556Brass";
		HdPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 5.56 brass.";
	}
}

class B556Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B556Brass";
		HDUPK.PickupType "B556Brass";
		HDUPK.PickupMessage "Picked up some 5.56 brass.";
	}
}









class B762Ammo : BRoundAmmo {
	default {
		tag "7.62 round";
		hdpickup.refid "b76";
		hdpickup.bulk ENC_762;
	}
	override string pickupmessage(){
		return "Picked up a stray 7.62 round.";
	}
}

class B762Brass : BRoundShell {
	default {
		tag "7.62 brass";
		HDPickUp.RefId "B762Casing";
		HdPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 7.62 brass.";
	}
}

class B762Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B762Brass";
		HDUPK.PickupType "B762Brass";
		HDUPK.PickupMessage "Picked up some 7.62 brass.";
	}
}








class B792Ammo : BRoundAmmo {
	default {
		tag "7.92 round";
		hdpickup.refid "b79";
		hdpickup.bulk ENC_762;
	}
	override string pickupmessage() {
		return "Picked up a stray 7.92 round.";
	}
}

class B792Brass : BRoundShell {
	default {
		tag "7.92 brass";
		HdPickup.RefId "B792Casing";
		HdPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 7.92 brass";
	}
}

class B792Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B792Brass";
		HDUPK.PickupType "B792Brass";
		HDUPK.PickupMessage "Picked up some 7.92 brass";
	}
}




