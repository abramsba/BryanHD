
class B556Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "B556Ammo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid HDLD_556MAG;
		tag "5.56mm NATO STANAG magazine";
		inventory.pickupmessage "Picked up a 5.56mm NATO STANAG magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M16CA0", "M16C", "B556Ammo", 1.7;
	}

	override void GetItemsThatUseThis(){
		itemsthatusethis.push("M16_AssaultRifle");
	}

	states{
		spawn:
			M16C A -1;
			stop;
		spawnempty:
			M16C A -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class B776Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "SevenMilAmmo";
		hdmagammo.roundbulk ENC_776_LOADED;
		hdmagammo.magbulk ENC_776MAG_EMPTY;
		hdpickup.refid HDLD_776RL;
		tag "7.76 AK47 magazine";
		inventory.pickupmessage "Picked up a 7.76 AK47 magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "AK4CA0", "AK4C", "SevenMilAmmo", 1.7;
	}

	override void GetItemsThatUseThis(){
		ItemsThatUseThis.push("AK47_AssaultRifle");
	}

	states{
		spawn:
			AK4C A -1;
			stop;
		spawnempty:
			AK4C A -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class B762Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "B762Ammo";
		hdmagammo.roundbulk ENC_762_LOADED;
		hdmagammo.magbulk ENC_762MAG_EMPTY;
		hdpickup.refid HDLD_762MAG;
		tag "7.62 AKM magazine";
		inventory.pickupmessage "Picked up a 7.62 AKM magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "AKMPA0", "AKMP", "B762Ammo", 1.7;
	}

	override void GetItemsThatUseThis(){
		ItemsThatUseThis.push("AKM_AssaultRifle");
	}

	states{
		spawn:
			AKMC A -1;
			stop;
		spawnempty:
			AKMC A -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}
