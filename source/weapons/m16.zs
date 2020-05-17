// ------------------------------------------------------------
// M16_ 4.26mm UAC Standard Automatic Rifle
// ------------------------------------------------------------
const HDCONST_M16_COOKOFF = 30;

class M16_AssaultRifle : HDWeapon {

	default{
		+hdweapon.fitsinbackpack
		weapon.selectionorder 20;
		weapon.slotnumber 4;
		weapon.slotpriority 3;
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the M16.";
		scale 0.7;
		weapon.bobrangex 0.22;
		weapon.bobrangey 0.9;
		obituary "%o was assaulted by %k.";
		tag "M16";
		inventory.icon "M16PA0";
	}

	override void tick() {
		super.tick();
		drainheat(M16_S_HEAT, 12);
	}

	override bool AddSpareWeapon(actor newowner) {
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner,bool reverse,bool doselect) {
		return GetSpareWeaponRegular(newowner,reverse,doselect);
	}

	override void postbeginplay() {
		super.postbeginplay();
		barrellength = 25; 
		barrelwidth = 1;
		barreldepth = 3;
	}

	override double gunmass(){
		bool ok = true;
		int that = ok + 4;
		return 6.2 + weaponstatus[M16_S_MAG] * 0.02;
	}

	override void GunBounce(){
		super.GunBounce();
		if(!random(0, 5)) {
			weaponstatus[0] &= ~M16_F_CHAMBERBROKEN;
		}
	}

	override void OnPlayerDrop(){
		if(!random(0, 15)) {
			weaponstatus[0] |= M16_F_CHAMBERBROKEN;
		}
		if(owner && weaponstatus[M16_S_HEAT] > HDCONST_M16_COOKOFF)
			owner.dropinventory(self);
	}

	override string pickupmessage(){
		return "Picked up a M16.";
	}

	override string,double getpickupsprite(){
		if(weaponstatus[M16_S_MAG] < 0)
			return "M16PB0", 1.;
		else
			return "M16PA0", 1.;
	}

	override void DrawHUDStuff(HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl){
		if(sb.hudlevel==1){
			int nextmagloaded = sb.GetNextLoadMag(hdmagammo(hpl.findinventory("B556Mag")));
			sb.drawimage("M16CA0", (-46, -3), sb.DI_SCREEN_CENTER_BOTTOM, scale: (2, 2));
			sb.drawnum(hpl.countinv("B556Mag"),-43,-8,sb.DI_SCREEN_CENTER_BOTTOM);
		}

		if(!(hdw.weaponstatus[0] & M16_F_NOFIRESELECT)) {
			sb.drawwepcounter(hdw.weaponstatus[M16_S_AUTO], -22, -10, "RBRSA3A7", "STFULAUT", "STBURAUT" );
		}

		int lod=clamp(hdw.weaponstatus[M16_S_MAG]%100,0,30);
		sb.drawwepnum(lod,30);
		if(hdw.weaponstatus[0] & M16_F_CHAMBER){
			sb.drawwepdot(-16,-10,(3,1));
			lod++;
		}

		if(hdw.weaponstatus[M16_S_MAG]>100)lod=random[shitgun](10,99);
		sb.drawnum(lod,-16,-22,sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_TEXT_ALIGN_RIGHT,Font.CR_RED);
	}

	override string gethelptext(){
		bool gl=!(weaponstatus[0]&M16_F_NOLAUNCHER);
		bool glmode=gl&&(weaponstatus[0]&M16_F_GLMODE);
		return
		WEPHELP_FIRESHOOT
		..(gl?(WEPHELP_ALTFIRE..(glmode?("  Rifle mode\n"):("  GL mode\n"))):"")
		..WEPHELP_RELOAD.."  Reload mag\n"
		..(glmode?(WEPHELP_FIREMODE.."+"..WEPHELP_UPDOWN.."  Airburst\n")
			:(
			((weaponstatus[0]&M16_F_NOFIRESELECT)?"":WEPHELP_FIREMODE.."  Semi/Auto/Burst\n")
			..WEPHELP_ZOOM.."+"..WEPHELP_FIREMODE.."+"..WEPHELP_UPDOWN.."  Zoom\n"))
		..WEPHELP_MAGMANAGER
		..WEPHELP_UNLOAD.."  Unload "..(glmode?"GL":"magazine")
		;
	}

	override void DrawSightPicture(
		HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl,
		bool sightbob,vector2 bob,double fov,bool scopeview,actor hpc,string whichdot) {
		double dotoff = max(abs(bob.x), abs(bob.y));
		if (dotoff < 6){
			sb.drawImage("m16iron", (0,8) + bob * 3, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.9 - dotoff * 0.04);
		}
		sb.drawimage("m16sight", (0, 4) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER );
	}

	override double weaponbulk(){
		double blx = 90;
		int mgg = weaponstatus[M16_S_MAG];
		return blx + (mgg < 0 ? 0 : (ENC_556MAG_LOADED + mgg * ENC_556_LOADED));
	}

	override void failedpickupunload(){
		failedpickupunloadmag(M16_S_MAG, "B556Mag");
	}

	override void DropOneAmmo(int amt){
		if(owner){
			amt = clamp(amt, 1, 10);
			if (owner.countinv("B556Ammo")) {
				owner.A_DropInventory("B556Ammo",amt*30);
			}
			else{
				double angchange=(weaponstatus[0]&M16_F_NOLAUNCHER)?0:-10;
				if(angchange)owner.angle-=angchange;
				owner.A_DropInventory("B556Mag",amt);
				if(angchange){
					owner.angle+=angchange*2;
					owner.A_DropInventory("HDRocketAmmo",amt);
					owner.angle-=angchange;
				}
			}
		}
	}

	override void ForceBasicAmmo(){
		owner.A_TakeInventory("B556Ammo");
		owner.A_TakeInventory("B556Mag");
		owner.A_GiveInventory("B556Mag");
	}

	action bool A_CheckCookoff(){
		if(invoker.weaponstatus[M16_S_HEAT] > HDCONST_M16_COOKOFF && !(invoker.weaponstatus[0] & M16_F_CHAMBERBROKEN) && invoker.weaponstatus[M16_S_FLAGS] & M16_F_CHAMBER) {
			setweaponstate("cookoff");
			return true;
		}
		return false;
	}

	action bool brokenround(){
		if(!(invoker.weaponstatus[M16_S_FLAGS]&M16_F_CHAMBERBROKEN)){
			int hht=invoker.weaponstatus[M16_S_HEAT];
			if(hht>240)invoker.weaponstatus[M16_S_BORESTRETCHED]++;
			hht*=hht;hht>>=10;
			int rnd=
				(invoker.owner?1:10)
				+max(invoker.weaponstatus[M16_S_AUTO],hht)
				+invoker.weaponstatus[M16_S_BORESTRETCHED]
				+(invoker.weaponstatus[M16_S_MAG]>100?10:0);
			if(random(0,2000)<rnd){
				invoker.weaponstatus[M16_S_FLAGS]|=M16_F_CHAMBERBROKEN;
			}
		}return invoker.weaponstatus[M16_S_FLAGS]&M16_F_CHAMBERBROKEN;
	}

	states{
	ready:
		M16G A 1{
			if (A_CheckCookoff()) {
				return;
			}

			if (pressingzoom()) {
				A_ZoomAdjust(M16_S_ZOOM, 16, 70);
			}
			else {
				A_WeaponReady(WRF_ALL);
			}

			if(invoker.weaponstatus[M16_S_AUTO] > 2) {
				invoker.weaponstatus[M16_S_AUTO] = 2;  
			}
		}
		goto readyend;

	firemode:
		M16G A 0 A_JumpIf(invoker.weaponstatus[0] & M16_F_GLMODE,"abadjust");
		M16G A 1{
			if (invoker.weaponstatus[0] & M16_F_NOFIRESELECT) {
				invoker.weaponstatus[M16_S_AUTO] = 0;
				return;
			}
			if (invoker.weaponstatus[M16_S_AUTO] >= 2) {
				invoker.weaponstatus[M16_S_AUTO] = 0;
			}  
			else {
				invoker.weaponstatus[M16_S_AUTO]++;
			}
			A_WeaponReady(WRF_NONE);
		}
		goto nope;


	select0:
		M16G A 0{
			invoker.weaponstatus[0] &= ~M16_F_GLMODE;
			if (invoker.weaponstatus[0] & M16_F_NOLAUNCHER) {
				invoker.weaponstatus[0] &= ~M16_F_GRENADELOADED;
				setweaponstate("select0small");
			}
		}
		goto select0big;

	deselect0:
		M16G A 0{
			if (invoker.weaponstatus[M16_S_HEAT] > HDCONST_M16_COOKOFF && !(invoker.weaponstatus[0] & M16_F_CHAMBERBROKEN) && (invoker.weaponstatus[M16_S_MAG] || invoker.weaponstatus[M16_S_FLAGS]&M16_F_CHAMBER)) {
				DropInventory(invoker);
				return;
			}
			if (invoker.weaponstatus[0] & M16_F_NOLAUNCHER) {
				setweaponstate("deselect0small");
			}
		}
		goto deselect0big;

	flash:
		TNT1 A 0 {
			int rng = random(0, 3);
			if (rng == 0) {
				return ResolveState("flash0");
			}
			else if (rng == 1) {
				return ResolveState("flash1");
			}
			else {
				return ResolveState("flash2");
			}
		}

	flash0:
		M16F A 0 Bright;
		goto lightfire;

	flash1:
		M16F B 0 Bright;
		goto lightfire;

	flash2:
		M16F C 0 Bright;
		goto lightfire;

	lightfire:
		M16F # 1 bright{
			A_Light1();
			HDFlashAlpha(-16);
			A_StartSound("m16/fire", CHAN_WEAPON);
			A_ZoomRecoil(max(0.95, 1. -0.05 * min(invoker.weaponstatus[M16_S_AUTO], 3)));
			double brnd = max(invoker.weaponstatus[M16_S_HEAT], invoker.weaponstatus[M16_S_BORESTRETCHED]) * 0.01;
			HDBulletActor.FireBullet(self, "HDB_426", spread:brnd>1.2?brnd:0);
			A_MuzzleClimb(
				-frandom(0.1,0.1), -frandom(0,0.1),
				-0.2,              -frandom(0.3,0.4),
				-frandom(0.4,1.4), -frandom(1.3,2.6)
			);
			invoker.weaponstatus[M16_S_FLAGS] &= ~M16_F_CHAMBER;
			invoker.weaponstatus[M16_S_HEAT] += random(3,5);
			A_AlertMonsters();
		}
		goto lightdone;


	fire:
		M16G A 2{
			if(invoker.weaponstatus[M16_S_AUTO] > 0) {
				A_SetTics(3);
			}
		}
		goto shootgun;

	hold:
		M16G A 0 A_JumpIf(invoker.weaponstatus[0] & M16_F_NOFIRESELECT, "nope");
		M16G A 0 A_JumpIf(invoker.weaponstatus[M16_S_AUTO] > 4, "nope");
		M16G A 0 A_JumpIf(invoker.weaponstatus[M16_S_AUTO], "shootgun");

	althold:
		---- A 1{
			if(!A_CheckCookoff()) {
				A_WeaponReady(WRF_NOFIRE);
			}
		}
		---- A 0 A_Refire();
		goto ready;

	jam:
		M16G A 1 offset(-1,36){
			A_StartSound("weapons/riflejam", CHAN_WEAPON, CHANF_OVERLAP);
			invoker.weaponstatus[0] |= M16_F_CHAMBERBROKEN;
			invoker.weaponstatus[M16_S_FLAGS] &= ~M16_F_CHAMBER;
		}
		M16G A 1 offset(1,30) A_StartSound("weapons/riflejam", CHAN_WEAPON, CHANF_OVERLAP);
		goto nope;

	shootgun:
		M16G A 1{
			if (invoker.weaponstatus[0]&M16_F_CHAMBERBROKEN || (!(invoker.weaponstatus[M16_S_FLAGS]&M16_F_CHAMBER) && invoker.weaponstatus[M16_S_MAG] < 1)) {
				setweaponstate("nope");
			}
			else if (!(invoker.weaponstatus[M16_S_FLAGS] & M16_F_CHAMBER)) {
				setweaponstate("chamber_manual");
			}
			else{
				A_GunFlash();
				A_WeaponReady(WRF_NONE);
				if (invoker.weaponstatus[M16_S_AUTO] >= 2)
					invoker.weaponstatus[M16_S_AUTO]++;  
			}
		}

	chamber:
		M16G A 0 offset(0,32){
			if (invoker.weaponstatus[M16_S_MAG] < 1){
				setweaponstate("nope");
				return;
			}
			if (invoker.weaponstatus[M16_S_MAG] % 100 > 0){  
				if (invoker.weaponstatus[M16_S_MAG]==31) {
					invoker.weaponstatus[M16_S_MAG]=30;
				}
				invoker.weaponstatus[M16_S_MAG]--;
				invoker.weaponstatus[M16_S_FLAGS] |= M16_F_CHAMBER;
			}
			else{
				invoker.weaponstatus[M16_S_MAG] = min(invoker.weaponstatus[M16_S_MAG], 0);
				A_StartSound("weapons/rifchamber", CHAN_WEAPON, CHANF_OVERLAP);
			}
			if(brokenround()){
				setweaponstate("jam");
				return;
			}
			A_WeaponReady(WRF_NOFIRE); //not WRF_NONE: switch to drop during cookoff
		}
		M16G A 0 A_CheckCookoff();
		M16G A 0 A_JumpIf(invoker.weaponstatus[M16_S_AUTO] < 1, "nope");
		M16G A 0 A_JumpIf(invoker.weaponstatus[M16_S_AUTO] > 4, "nope");
		M16G A 2 A_JumpIf(invoker.weaponstatus[M16_S_AUTO] > 1, 1);
		M16G A 0 A_Refire();
		goto ready;

	cookoffaltfirelayer:
		TNT1 AAA 1{
			if (JustPressed(BT_ALTFIRE)) {
				invoker.weaponstatus[0] ^= M16_F_GLMODE;
				A_SetTics(10);
			}
			else if (JustPressed(BT_ATTACK) && invoker.weaponstatus[0] & M16_F_GLMODE) {
				A_Overlay(11, "nadeflash");
			}
		}
		stop;

	cookoff:
		M16G A 0{
			A_ClearRefire();
			if ((invoker.weaponstatus[M16_S_MAG] >= 0) && (justpressed(BT_RELOAD) || justpressed(BT_UNLOAD))) {
				A_StartSound("weapons/rifleclick2", CHAN_WEAPON, CHANF_OVERLAP);
				A_StartSound("weapons/rifleload", CHAN_WEAPON, CHANF_OVERLAP);
				HDMagAmmo.SpawnMag(self,"B556Mag", invoker.weaponstatus[M16_S_MAG]);
				invoker.weaponstatus[M16_S_MAG] =- 1;
			}
			else if (!(invoker.weaponstatus[0] & M16_F_NOLAUNCHER)) {
				A_Overlay(10,"cookoffaltfirelayer");
			}
			setweaponstate("shootgun");
		}


	user3:
		M16G A 0 A_MagManager("B556Mag");
		goto ready;

	user4:
	unload:
		M16G A 0{
			invoker.weaponstatus[M16_S_FLAGS] |= M16_F_UNLOADONLY;
			if (invoker.weaponstatus[M16_S_MAG] >= 0) {
				setweaponstate("unloadmag");
			}
			else if (invoker.weaponstatus[M16_S_FLAGS] & M16_F_CHAMBER || invoker.weaponstatus[M16_S_FLAGS] & M16_F_CHAMBERBROKEN) {
				setweaponstate("unloadchamber");
			}
			else{
				setweaponstate("unloadmag");
			}
		}

	reload:
		M16G A 0{
			invoker.weaponstatus[M16_S_FLAGS] &= ~M16_F_UNLOADONLY;
			if (!(invoker.weaponstatus[0] & M16_F_CHAMBERBROKEN) && invoker.weaponstatus[M16_S_MAG] % 100 >= 30 && !(invoker.weaponstatus[M16_S_FLAGS] & M16_F_UNLOADONLY)) {
				setweaponstate("nope");
			}
			else if (invoker.weaponstatus[M16_S_MAG] < 0 && invoker.weaponstatus[0] & M16_F_CHAMBERBROKEN) {
				invoker.weaponstatus[M16_S_FLAGS]|=M16_F_UNLOADONLY;
				setweaponstate("unloadchamber");
			}
			else if (!HDMagAmmo.NothingLoaded(self, "B556Mag")) {
				setweaponstate("unloadmag");
			}
		}
		goto nope;

	unloadmag:
		M16G A 1 offset(0, 33);
		M16G A 1 offset(-3, 34);
		M16G A 1 offset(-8, 37);
		M16G A 2 offset(-11, 39){
			if(invoker.weaponstatus[M16_S_MAG] < 0) {
				setweaponstate("magout");
			}
			if(invoker.weaponstatus[0] & M16_F_CHAMBERBROKEN) {
				invoker.weaponstatus[M16_S_FLAGS] |= M16_F_UNLOADONLY;
			}
			A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
			A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			A_StartSound("weapons/rifleclick2", CHAN_WEAPON, CHANF_OVERLAP);
		}
		M16G A 4 offset(-12, 40){
			A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
			A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			A_StartSound("weapons/rifleload",CHAN_WEAPON);
		}
		M16G A 20 offset(-14, 44){
			int inmag = invoker.weaponstatus[M16_S_MAG];
			if(inmag > 31) {
				inmag %= 30;
			}
			invoker.weaponstatus[M16_S_MAG] =- 1;
			if(!PressingUnload() && !PressingReload() || A_JumpIfInventory("B556Mag", 0, "null")) {
				HDMagAmmo.SpawnMag(self, "B556Mag", inmag);
				A_SetTics(1);
			}
			else{
				HDMagAmmo.GiveMag(self, "B556Mag", inmag);
				A_StartSound("weapons/pocket", CHAN_WEAPON);
			}
		}

	magout:
		M16G A 0{
			if(
				invoker.weaponstatus[M16_S_FLAGS]&M16_F_UNLOADONLY
				||!countinv("B556Mag")
			)setweaponstate("reloadend");
		}

	loadmag:
		---- A 12{
			let zmag = B556Mag(findinventory("B556Mag"));
			if (!zmag) {
				setweaponstate("reloadend");
				return;
			}
			A_StartSound("weapons/pocket", CHAN_WEAPON);
			A_SetTics(10);
		}

	loadmagclean:
		M16G A 8 offset(-15,45)A_StartSound("weapons/rifleload",CHAN_WEAPON);
		M16G A 1 offset(-14,44){
			let zmag = B556Mag(findinventory("B556Mag"));
			if (!zmag){
				setweaponstate("reloadend");return;
			}
			invoker.weaponstatus[M16_S_MAG] = zmag.TakeMag(true);
			A_StartSound("weapons/rifleclick2",CHAN_WEAPON);
		}
		goto reloadend;

	reloadend:
		M16G A 2 offset(-11,39);
		M16G A 1 offset(-8,37) A_MuzzleClimb(frandom(0.2,-2.4),frandom(0.2,-1.4));
		M16G A 0 A_CheckCookoff();
		M16G A 1 offset(-3,34);
		goto chamber_manual;

	chamber_manual:
		M16G A 0 A_JumpIf(invoker.weaponstatus[M16_S_FLAGS] & M16_F_CHAMBER, "nope");
		M16G A 3 offset(-1,36) A_WeaponBusy();
		M16G A 4 offset(-3,42){
			if(!invoker.weaponstatus[M16_S_MAG] % 100) invoker.weaponstatus[M16_S_MAG] = 0;
			if(
				!(invoker.weaponstatus[M16_S_FLAGS]&M16_F_CHAMBER)
				&& !(invoker.weaponstatus[M16_S_FLAGS]&M16_F_CHAMBER)
				&& invoker.weaponstatus[M16_S_MAG]%100>0
			){
				A_StartSound("weapons/rifleclick",CHAN_WEAPON);
				if(invoker.weaponstatus[M16_S_MAG] > 30)
					invoker.weaponstatus[M16_S_MAG] = 29;
				else 
					invoker.weaponstatus[M16_S_MAG]--;

				invoker.weaponstatus[M16_S_FLAGS] |= M16_F_CHAMBER;
				brokenround();
			}
			else setweaponstate("nope");
		}
		M16G A 2 offset(-1,36);
		M16G A 0 offset(0,34);
		goto nope;

	unloadchamber:
		M16G A 1 offset(-3,34);
		M16G A 1 offset(-9,39);
		M16G A 3 offset(-19,44) A_MuzzleClimb(frandom(-0.4,0.4),frandom(-0.4,0.4));
		M16G A 2 offset(-16,42){
			A_MuzzleClimb(frandom(-0.4,0.4),frandom(-0.4,0.4));
			if (invoker.weaponstatus[M16_S_FLAGS] & M16_F_CHAMBER && !(invoker.weaponstatus[0]&M16_F_CHAMBERBROKEN)) {
				A_SpawnItemEx("B556Ammo", 0, 0, 20, random(4,7), random(-2,2), random(-2,1), 0, SXF_NOCHECKPOSITION);
				invoker.weaponstatus[M16_S_FLAGS] &= ~M16_F_CHAMBER;
				A_StartSound("weapons/rifleclick2", CHAN_WEAPON, CHANF_OVERLAP);
			}
			else if (!random(0,4)) {
				invoker.weaponstatus[0] &= ~M16_F_CHAMBERBROKEN;
				invoker.weaponstatus[M16_S_FLAGS] &= ~M16_F_CHAMBER;
				A_StartSound("weapons/rifleclick", CHAN_WEAPON, CHANF_OVERLAP);
				for(int i = 0; i < 3; i++) {
					A_SpawnItemEx("TinyWallChunk", 0, 0, 20, random(4,7), random(-2,2), random(-2,1), 0, SXF_NOCHECKPOSITION);
				}
				if(!random(0,5)) {
					A_SpawnItemEx("HDSmokeChunk", 12, 0, height-12, 4, frandom(-2,2), frandom(2,4));
				}
			}else if(invoker.weaponstatus[0]&M16_F_CHAMBERBROKEN){
				A_StartSound("weapons/smack",CHAN_WEAPON,CHANF_OVERLAP);
			}
		}
		goto reloadend;

	nadeflash:
		TNT1 A 0 A_JumpIf(invoker.weaponstatus[M16_S_FLAGS]&M16_F_GRENADELOADED,1);
		stop;
		TNT1 A 2 {
			A_FireHDGL();
			invoker.weaponstatus[M16_S_FLAGS]&=~M16_F_GRENADELOADED;
			A_StartSound("weapons/grenadeshot",CHAN_WEAPON);
			A_ZoomRecoil(0.95);
		}
		TNT1 A 2 A_MuzzleClimb(
			0,0,0,0,
			-1.2,-3.,
			-1.,-2.8
		);
		stop;

	firefrag:
		M16G A 2;
		M16G A 3 A_Gunflash("nadeflash");
		goto nope;


	altfire:
		M16G A 1 offset(0,34){
			A_SetCrosshair(21);
			A_SetHelpText();
		}
		goto nope;


	altreload:
		goto ready;

	spawn:
		M16P A 0 {
			//don't jam just because
			if(
				!(invoker.weaponstatus[0]&M16_F_CHAMBER)
				&&!(invoker.weaponstatus[0]&M16_F_CHAMBERBROKEN)
				&&invoker.weaponstatus[M16_S_MAG]>0
				&&invoker.weaponstatus[M16_S_MAG]<51
			){
				invoker.weaponstatus[M16_S_MAG]--;
				invoker.weaponstatus[0]|=M16_F_CHAMBER;
				brokenround();
			}
		}

	spawn2:
		---- A -1{
			//set sprite
			if (invoker.weaponstatus[M16_S_MAG] > 0) {
				sprite = getspriteindex("M16PA0");
			}

			//set to no-mag frame
			
			if(invoker.weaponstatus[M16_S_MAG]<0){
				frame=1;
			}

			if(
				invoker.weaponstatus[0]&M16_F_CHAMBER
				&&!(invoker.weaponstatus[0]&M16_F_CHAMBERBROKEN)
				&&invoker.weaponstatus[M16_S_HEAT]>HDCONST_M16_COOKOFF
			)setstatelabel("spawnshoot");
		}

	spawnshoot:
		#### C 1 bright light("SHOT"){
			sprite = getspriteindex("M16PA0");
			double brnd = invoker.weaponstatus[M16_S_HEAT] * 0.01;
			let bbb = HDBulletActor.FireBullet(self, "HDB_556", spread:brnd>1.2 ? invoker.weaponstatus[M16_S_HEAT] * 0.1 : 0);

			//if overlapping owner, treat owner as shooter
			let targ = invoker.target;
			if(targ && abs(targ.pos.x - invoker.pos.x) <= targ.radius && abs(targ.pos.y - invoker.pos.y) <= targ.radius) {
				bbb.target = targ;
			}
			A_ChangeVelocity(frandom(-0.4, 0.1) * cos(pitch), frandom(-0.1, 0.08), sin(pitch) + frandom(-1., 1.), CVF_RELATIVE);
			A_StartSound("weapons/rifle", CHAN_VOICE);
			invoker.weaponstatus[M16_S_HEAT] += random(3, 5);
			angle+=frandom(2, -7);
			pitch+=frandom(-4, 4);
		}
		#### B 0{
//			if(invoker.weaponstatus[M16_S_AUTO]>1)A_SetTics(0);
			invoker.weaponstatus[0] &= ~(M16_F_CHAMBER | M16_F_CHAMBERBROKEN);
			if(invoker.weaponstatus[M16_S_MAG] % 100 > 0) {
				invoker.weaponstatus[M16_S_MAG]--;
				invoker.weaponstatus[0] |= M16_F_CHAMBER;
				brokenround();
			}
		}
		goto spawn2;
	}

	override inventory CreateTossable(int amt){
		let owner = self.owner;
		let zzz = M16_assaultrifle(super.createtossable());
		if (!zzz){
			return null;
		}
		zzz.target = owner;
		return zzz;
	}

	override void InitializeWepStats(bool idfa){
		weaponstatus[M16_S_MAG]=30;
		if(!idfa && !owner){
			weaponstatus[M16_S_ZOOM]=30;
			weaponstatus[M16_S_AUTO]=0;
			weaponstatus[M16_S_HEAT]=0;
		}
		if(idfa)weaponstatus[0]&=~M16_F_CHAMBERBROKEN;
	}

	override void loadoutconfigure(string input){
		int nogl=getloadoutvar(input,"nogl",1);
		//disable launchers if rocket grenades blacklisted
		string blacklist=hd_blacklist;
		if(blacklist.IndexOf(HDLD_BLOOPER)>=0)nogl=1;
		if(!nogl){
			weaponstatus[0]&=~M16_F_NOLAUNCHER;
		}else if(nogl>0){
			weaponstatus[0]|=M16_F_NOLAUNCHER;
			weaponstatus[0]&=~M16_F_GRENADELOADED;
		}
		if(!(weaponstatus[0]&M16_F_NOLAUNCHER))weaponstatus[0]|=M16_F_GRENADELOADED;

		int zoom=getloadoutvar(input,"zoom",3);
		if(zoom>=0)weaponstatus[M16_S_ZOOM]=clamp(zoom,16,70);

		int semi=getloadoutvar(input,"semi",1);
		if(semi>0){
			weaponstatus[M16_S_AUTO]=-1;
			weaponstatus[0]|=M16_F_NOFIRESELECT;
		}else{
			int firemode=getloadoutvar(input,"firemode",1);
			if(firemode>=0){
				weaponstatus[0]&=~M16_F_NOFIRESELECT;
				weaponstatus[M16_S_AUTO]=clamp(firemode,0,2);
			}
		}
		if(
			!(weaponstatus[0]&M16_F_CHAMBER)
			&&weaponstatus[M16_S_MAG]>0
		){
			weaponstatus[0]|=M16_F_CHAMBER;
			if(weaponstatus[M16_S_MAG]==51)weaponstatus[M16_S_MAG]=49;
			else weaponstatus[M16_S_MAG]--;
		}
	}

}
enum M16_status{
	M16_F_CHAMBER=1,
	M16_F_CHAMBERBROKEN=2,
	M16_F_DIRTYMAG=4,
	M16_F_GRENADELOADED=8,
	M16_F_NOLAUNCHER=16,
	M16_F_NOFIRESELECT=32,
	M16_F_GLMODE=64,
	M16_F_UNLOADONLY=128,
	M16_F_STILLPRESSINGRELOAD=256,
	M16_F_LOADINGDIRTY=512,

	M16_S_FLAGS=0,
	M16_S_MAG=1, //-1 is empty
	M16_S_AUTO=2, //2 is burst, 2-5 counts ratchet
	M16_S_ZOOM=3,
	M16_S_HEAT=4,
	M16_S_AIRBURST=5,
	M16_S_BORESTRETCHED=6,
};

class M16_Semi:HDWeaponGiver{
	default{
		tag "M16_ assault rifle (semi only)";
		hdweapongiver.bulk (90.+(ENC_556MAG_LOADED+30.*ENC_556_LOADED));
		hdweapongiver.weapontogive "M16_AssaultRifle";
		hdweapongiver.config "noglsemi";
		inventory.icon "RIFSA0";
	}
}

class M16_Random:IdleDummy{
	states{
	spawn:
		TNT1 A 0 nodelay{
			let zzz=M16_AssaultRifle(spawn("M16_AssaultRifle",pos,ALLOW_REPLACE));
			if(!zzz)return;
			zzz.special=special;
			for(int i=0;i<5;i++)zzz.args[i]=args[i];
			if(!random(0,2)){
				zzz.weaponstatus[0]|=M16_F_NOLAUNCHER;
				if(!random(0,3))zzz.weaponstatus[0]|=M16_F_NOFIRESELECT;
			}
			if(zzz.weaponstatus[0]&M16_F_NOLAUNCHER){
				spawn("B556Mag",pos+(7,0,0),ALLOW_REPLACE);
				spawn("B556Mag",pos+(5,0,0),ALLOW_REPLACE);
			}else{
				spawn("HDRocketAmmo",pos+(10,0,0),ALLOW_REPLACE);
				spawn("HDRocketAmmo",pos+(8,0,0),ALLOW_REPLACE);
				spawn("B556Mag",pos+(5,0,0),ALLOW_REPLACE);
			}
		}stop;
	}
}




















































