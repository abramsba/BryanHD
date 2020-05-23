
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

class B556Brass : HDAmmo {
	default {
		+inventory.ignoreskill
		+forcexybillboard
		+cannotpush
		+hdpickup.multipickup
		+hdpickup.cheatnogive
		height 16;
		radius 8;
		tag "5.56mm NATO Casing";
		HDPickUp.RefId "B556Casing";
		HdPickup.Bulk 1;
		XScale 0.7;
		YScale 0.8;
		Inventory.PickupMessage "Picked up some brass.";
	}
	states {
		spawn:
			RBRS A -1;
			Stop;
	}
}

class B556Spent : HDUPK {
	override void postbeginplay(){
		super.postbeginplay();
		A_ChangeVelocity(frandom(-3,3), frandom(-0.4,0.4), 0, CVF_RELATIVE);
	}

	default {
		+Missile
		+HDUPK.multipickup
		Height 4;
		Radius 2;
		BounceType "Doom";
		HDUPK.PickupType "B556Brass";
		HDUPK.PickupMessage "Picked up some brass.";

		bouncesound "misc/casing";
		xscale 0.7;
		yscale 0.8;
		maxstepheight 0.6;
	}

	states {
		spawn:
			RBRS A 2 {
				angle+=45;
				if(floorz==pos.z&&!vel.z)A_Countdown();
			}
			Wait;

		death:
			RBRS A -1 {
				actor p=spawn("B556Brass",self.pos,ALLOW_REPLACE);
				p.vel = self.vel;
				p.vel.xy*=3;
				p.angle=angle;
				if(p.vel!=(0,0,0)){
					p.A_FaceMovementDirection();
					p.angle+=90;
				}
				destroy();
			}
			Stop;

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