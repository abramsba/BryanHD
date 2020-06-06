
class B556Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "B556Ammo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid "m56";
		tag "5.56x45mm NATO STANAG magazine";
		inventory.pickupmessage "Picked up a 5.56x45mm NATO STANAG magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M16CA0", "M16C", "B556Ammo", 1.7;
	}

	override void GetItemsThatUseThis(){
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

class B9mm_MP5K_MAG : HDMagAmmo {
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "HDPistolAmmo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid "mmp";
		tag "MP5K Magazine";
		inventory.pickupmessage "Picked up a MP5K magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "MP5CA0", "MP5C", "HDPistolAmmo", 1.7;
	}

	override void GetItemsThatUseThis(){
	}

	states{
		spawn:
			MP5C A -1;
			stop;
		spawnempty:
			MP5C A -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class B762_AK47_Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "SevenMilAmmo";
		hdmagammo.roundbulk ENC_776_LOADED;
		hdmagammo.magbulk ENC_776MAG_EMPTY;
		
		tag "7.62x39mm AK47 magazine";
		inventory.pickupmessage "Picked up a 7.62x39mm AK47 magazine.";
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

class B762_AKM_Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "B762Ammo";
		hdmagammo.roundbulk ENC_762_LOADED;
		hdmagammo.magbulk ENC_762MAG_EMPTY;
		hdpickup.refid "mak";
		tag "7.62x39mm AKM magazine";
		inventory.pickupmessage "Picked up a 7.62x39mm AKM magazine.";
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

class B792_KAR98_Clip : HDMagAmmo{
	default{
		hdmagammo.maxperunit 5;
		hdmagammo.roundtype "B792Ammo";
		hdmagammo.roundbulk ENC_762_LOADED;
		hdmagammo.magbulk ENC_762MAG_EMPTY;
		hdpickup.refid "mka";
		tag "7.92x57mm clip";
		inventory.pickupmessage "Picked up a 7.92x57mm clip.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "KR9AA0", "KR9A", "B792Ammo", 1.7;
	}

	override void GetItemsThatUseThis(){
	}

	states{
		spawn:
			KR9A A -1;
			stop;
		spawnempty:
			KR9A B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}