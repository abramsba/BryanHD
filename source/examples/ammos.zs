
class B556Ammo : HDRoundAmmo {

	default {
		+inventory.ignoreskill
		+hdpickup.cheatnogive
		+hdpickup.multipickup
		xscale 0.5; 
		yscale 0.6;
		tag "5.56mm NATO round";
		hdpickup.refid HDLD_556MAG;
		hdpickup.bulk ENC_556;
		inventory.icon "RCLSA3A7";
	}

	override string pickupmessage(){
		return "Picked up a stray 5.56 NATO round.";
	}

	override void splitpickup(){
		int amm = min(amount, random(4, 26));
		while(amount > amm) {
			int ld = min(amount, random(4, 26));
			actor a = spawn("B556Ammo", pos);
			a.vel += vel + (frandom(-1,1), frandom(-1,1), frandom(-1,1));
			a.angle = frandom(0, 360);
			inventory(a).amount = ld;
			amount -= ld;
		}
		if(amount < 1){
			destroy();
			return;
		}
		scale.y = getdefaultbytype(getclass()).scale.y * max(1., amount*0.3);
		if(amount > 1) {
			frame = 1;
		}
	}

	override void GetItemsThatUseThis(){
		itemsthatusethis.push("M16_AssaultRifle");
	}

	states(actor) {
		spawn:
			RCLS A -1;
			stop;
	}
}

class B762Ammo : HDRoundAmmo {

	default {
		+inventory.ignoreskill
		+hdpickup.cheatnogive
		+hdpickup.multipickup
		xscale 0.5; 
		yscale 0.6;
		tag "7.62mm round";
		hdpickup.refid HDLD_762MAG;
		hdpickup.bulk ENC_762;
		inventory.icon "RCLSA3A7";
	}

	override string pickupmessage(){
		return "Picked up a stray 7.76 round.";
	}

	override void splitpickup(){
		int amm = min(amount, random(4, 26));
		while(amount > amm) {
			int ld = min(amount, random(4, 26));
			actor a = spawn("B762Ammo", pos);
			a.vel += vel + (frandom(-1,1), frandom(-1,1), frandom(-1,1));
			a.angle = frandom(0, 360);
			inventory(a).amount = ld;
			amount -= ld;
		}
		if(amount < 1){
			destroy();
			return;
		}
		scale.y = getdefaultbytype(getclass()).scale.y * max(1., amount*0.3);
		if(amount > 1) {
			frame = 1;
		}
	}

	override void GetItemsThatUseThis(){
		itemsthatusethis.push("AKM_AssaultRifle");
	}

	states(actor) {
		spawn:
			RCLS A -1;
			stop;
	}
}