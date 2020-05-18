
// Constants
const I_FLAGS = 0;
const I_MAG   = 1;
const I_AUTO  = 2;
const I_ZOOM  = 3;
const I_HEAT  = 4;
CONST I_BORE  = 6;

const F_CHAMBER        = 1;
const F_CHAMBER_BROKE  = 2;
const F_NO_FIRE_SELECT = 32;
const F_UNLOAD_ONLY    = 128;

// Base Class for Rifle
class BHDWeapon : HDWeapon {

	property BHeatDrain: bHeatDrain;
	int bHeatDrain;

	property BBulletClass: bBulletClass;
	string bBulletClass;

	property BAmmoClass: bAmmoClass;
	string bAmmoClass;

	property BMagazineClass: bMagazineClass;
	string bMagazineClass;

	property BGunMass: bGunMass;
	double bGunMass;

	property BCookOff: bCookOff;
	int bCookOff;

	property BHeatLimit: bHeatLimit;
	int bHeatLimit;

	property BSpriteWithMag: bSpriteWithMag;
	string bSpriteWithMag;

	property BSpriteWithoutMag: bSpriteWithoutMag;
	string bSpriteWithoutMag;

	property BMagazineSprite: bMagazineSprite;
	string bMagazineSprite;

	property BWeaponBulk: bWeaponBulk;
	int bWeaponBulk;

	property BMagazineBulk: bMagazineBulk;
	int bMagazineBulk;

	property BBulletBulk: bBulletBulk;
	int bBulletBulk;

	property BMagazineCapacity: bMagazineCapacity;
	int bMagazineCapacity;

	property BFireSound : bFireSound;
	string bFireSound;

	property BChamberSound : bChamberSound;
	string bChamberSound;

	property BClickSound : bClickSound;
	string bClickSound;

	property BLoadSound : bLoadSound;
	string bLoadSound;

	property BBoltForwardSound : bBoltForwardSound;
	string bBoltForwardSound;

	property BBoltBackwardSound : bBoltBackwardSound;
	string bBoltBackwardSound;

	property BBackSightImage : bBackSightImage;
	string bBackSightImage;

	property BBackOffsetX : bBackOffsetX;
	property BBackOffsetY : bBackOffsetY;
	int bBackOffsetX;
	int bBackOffsetY;

	property BFrontSightImage : bFrontSightImage;
	string bFrontSightImage;

	property BFrontOffsetX : bFrontOffsetX;
	property BFrontOffsetY : bFrontOffsetY;
	int bFrontOffsetX;
	int bFrontOffsetY;

	property BROF : bROF;
	int bROF;

	property BarrelLength: barrelLength;
	property BarrelWidth: barrelWidth;
	property BarrelDepth: barrelDepth;

	// Pretty API

	int magazineGetAmmo() const {
		return weaponStatus[I_MAG];
	}

	bool magazineHasAmmo() const {
		return weaponStatus[I_MAG] > 0;
	}

	void magazineAddAmmo(int amt) {
		weaponStatus[I_MAG] += amt;
	}

	void fixChamber() {
		weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
	}

	void breakChamber() {
		weaponStatus[I_FLAGS] |= F_CHAMBER_BROKE;
	}

	void unchamber() {
		weaponStatus[I_FLAGS] &= ~F_CHAMBER;
	}

	void setChamber() {
		weaponStatus[I_FLAGS] |= F_CHAMBER;
	}

	bool brokenChamber() const {
		return (weaponStatus[I_FLAGS] & F_CHAMBER_BROKE) > 0;
	}

	bool chambered() const {
		return (weaponStatus[I_FLAGS] & F_CHAMBER) > 0;
	}

	int heatAmount() const {
		return weaponStatus[I_HEAT];
	}

	void addHeat(int h) {
		weaponStatus[I_HEAT] += h;
	}

	bool overheated() const {
		return weaponStatus[I_HEAT] > bCookOff;
	}

	int fireMode() const {
		return weaponStatus[I_AUTO];
	}

	void setFireMode(int mode) {
		weaponStatus[I_AUTO] = mode;
	}

	int boreStretch() const {
		return weaponStatus[I_BORE];
	}

	void addBoreStretch(int amount) {
		weaponStatus[I_BORE] += amount;
	}

	// DOom Overrides
	override void PostBeginPlay() {
		super.PostBeginPlay();
		player = Players[consoleplayer];
	}


	// HD API

	// Overrides

	override void Tick() {
		super.tick();
		drainheat(I_HEAT, bHeatDrain);
	}

	override bool AddSpareWeapon(actor newowner) {
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect) {
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	override double GunMass(){
		return bGunMass + (magazineGetAmmo() * 0.02);
	}

	override void GunBounce() {
		super.GunBounce();
		if (!random(0, 5)) {
			fixChamber();
		}
	}

	override void OnPlayerDrop() {
		if(!random(0, 15)) {
			breakChamber();
		}
		if(overheated()) {
			owner.dropInventory(self);
		}
	}

	override string, double GetPickupSprite() {
		if(magazineHasAmmo()) {
			return bSpriteWithMag, 1.;
		}
		else {
			return bSpriteWithoutMag, 1.;
		}
	}

	override double WeaponBulk(){
		double blx = bWeaponBulk;
		int mgg = magazineGetAmmo();
		return blx + (mgg < 0 ? 0 : (bMagazineBulk + mgg * bBulletBulk));
	}

	override void DropOneAmmo(int amt){
		if(owner){
			amt = clamp(amt, 1, 10);
			if (owner.CountInv(bAmmoClass)) {
				owner.A_DropInventory(bAmmoClass, amt * bMagazineCapacity);
			}
			else {
				owner.A_DropInventory(bAmmoClass, amt);
			}
		}
	}

	override void ForceBasicAmmo(){
		owner.A_TakeInventory(bAmmoClass);
		owner.A_TakeInventory(bMagazineClass);
		owner.A_GiveInventory(bMagazineClass);
	}

	override void InitializeWepStats (bool idfa) {
		weaponStatus[I_MAG] = bMagazineCapacity;
	}

	override void LoadoutConfigure(string input){
		// ... ?
	}

	// HD Action Functions


	action bool A_CheckCookoff() {
		if (invoker.overheated() && !invoker.brokenChamber() && invoker.chambered()) {
			SetWeaponState("cookoff");
			return true;
		}
		return false;
	}

	action bool BrokenRound() {
		if (!invoker.brokenChamber()) {
			int currentHeat = invoker.heatAmount();
			if (currentHeat > invoker.bHeatLimit) {
				invoker.addBoreStretch(1);
			}
			currentHeat *= currentHeat >>= 10; // ?
			int pivot = (invoker.owner ? 1 : 10) +
			            max(invoker.fireMode(), currentHeat) +
			            invoker.boreStretch() +
			            (invoker.magazineGetAmmo() > 100 ? 10 : 0);
			if (random(0, 2000) < pivot) {
				invoker.breakChamber();
			}
		}
		return invoker.brokenChamber();
	}

	override inventory CreateTossable(int amt){
		// If self actor lacks a SpawnState, don't drop it. (e.g. A base weapon
		// like the fist can't be dropped because you'll never see it.)
		if (SpawnState == GetDefaultByType("Actor").SpawnState || SpawnState == NULL) {
			return NULL;

		}
		if (bUndroppable || bUntossable || Owner == NULL || Amount <= 0 || amt == 0) {
			return NULL;
		}
		BecomePickup();
		DropTime = 30;
		bSpecial = bSolid = false;
		self.sprite = magazineGetAmmo() != -1 ? GetSpriteIndex(bSpriteWithoutMag) : GetSpriteIndex(bSpriteWithoutMag);
		return self;
	}

	override void DrawHUDStuff(HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl){
		BHDWeapon basicWep = BHDWeapon(hdw);
		if (sb.hudLevel == 1) {
			int nextMag = sb.GetNextLoadMag(HDMagAmmo(hpl.findInventory(basicWep.bMagazineClass)));
			sb.DrawImage(basicWep.bMagazineSprite, (-46, -3), sb.DI_SCREEN_CENTER_BOTTOM, scale: (2, 2));
			sb.DrawNum(hpl.CountInv(basicWep.bMagazineClass), -43, -8, sb.DI_SCREEN_CENTER_BOTTOM);
		}
		if(!(hdw.weaponstatus[I_FLAGS] & F_NO_FIRE_SELECT)) {
			sb.drawwepcounter(hdw.weaponstatus[I_AUTO], -22, -10, "RBRSA3A7", "STFULAUT", "STBURAUT" );
		}
		int ammoBarAmt = clamp(basicWep.magazineGetAmmo() % 100, 0, basicWep.bMagazineCapacity);
		sb.DrawWepNum(ammoBarAmt, basicWep.bMagazineCapacity);
		if (basicWep.chambered()) {
			sb.DrawWepDot(-16, -10, (3, 1));
			ammoBarAmt++;
		}
		sb.DrawNum(ammoBarAmt, -16, -22, sb.DI_SCREEN_CENTER_BOTTOM | sb.DI_TEXT_ALIGN_RIGHT, Font.CR_RED);
	}

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {
		BHDWeapon basicWep = BHDWeapon(hdw);
		double dotoff = max(abs(bob.x), abs(bob.y));
		if (dotoff < 6){
			sb.drawImage(basicWep.bFrontSightImage, (basicWep.bFrontOffsetX, basicWep.bFrontOffsetY) + bob * 3, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.9 - dotoff * 0.04);
		}
		sb.drawimage(basicWep.bBackSightImage, (basicWep.bBackOffsetX, basicWep.bBackOffsetY) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER );
	}

	// States

	states {

		Ready:
			#### A 0 {
				if (A_CheckCookoff()) {
					return ResolveState("ReadyEnd");
				}
				if (pressingZoom()) {
					A_ZoomAdjust(I_ZOOM, 16, 70);
				}
				else {
					A_WeaponReady(WRF_ALL);
				}

				if (invoker.firemode() > 2) {
					invoker.setFireMode(2);
				}

				return ResolveState("ReadyEnd");
			}

		Spawn:
			#### A 0 {
				if (!invoker.chambered() && !invoker.brokenChamber() && invoker.magazineGetAmmo() > 0 && invoker.magazineGetAmmo() < (invoker.bMagazineCapacity - 1)) {
					invoker.weaponStatus[I_MAG]--;
					invoker.setChamber();
					BrokenRound();
				}
				return ResolveState("Spawn2");
			}

		Spawn2:
			#### A 0 {
				if (invoker.weaponStatus[I_MAG] > 0) {
					sprite = getSpriteIndex(invoker.bSpriteWithMag);
				}

				if (invoker.weaponStatus[I_MAG] < 0) {
					frame = 1;
				}

				if (invoker.chambered() && !invoker.brokenChamber() && invoker.overheated()) {
					SetStateLabel("SpawnShoot");
				}
				
			}
			Stop;

		SpawnShoot:
			#### A 1;
			Stop;

		User3:
			#### A 0 A_MagManager(invoker.bMagazineClass);
			#### A 0 {
				return ResolveState("Ready");
			}

		Fire:
			#### A 2 {
				if (invoker.fireMode() > 0) {
					A_SetTics(invoker.bROF);
				}
				return ResolveState("ShootGun");
			}

		ShootGun:
			#### A 1 {
				if (invoker.brokenChamber() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					return ResolveState("Nope");
				}
				else if (!invoker.chambered()) {
					return ResolveState("Chamber_Manual");
				}
				else {
					A_GunFlash();
					A_WeaponReady(WRF_NONE);
					if (invoker.weaponStatus[I_AUTO] >= 2) {
						invoker.weaponStatus[I_AUTO]++;
					}
					return ResolveState(NULL);
				}

			}
			#### B 1;
			#### B 0 {
				return ResolveState("Chamber");
			}

		Flash:
			TNT1 A 1 {
				A_Light1();
				HDFlashAlpha(-16);
				A_StartSound(invoker.bFireSound, CHAN_WEAPON);
				A_ZoomRecoil(max(0.95, 1. -0.05 * invoker.fireMode()));
				double burn = max(invoker.heatAmount(), invoker.boreStretch()) * 0.01;
				HDBulletActor.FireBullet(self, invoker.bBulletClass, spread: burn > 1.2 ? burn : 0);
				A_MuzzleClimb(
					-frandom(0.1,0.1), -frandom(0,0.1),
					-0.2,              -frandom(0.3,0.4),
					-frandom(0.4,1.4), -frandom(1.3,2.6)
				);
				invoker.addHeat(random(3, 5));
				invoker.unchamber();
				A_AlertMonsters();
			}
			TNT1 A 0 { 
				return ResolveState("LightDone");
			}

		Firemode:
			#### A 1 {
				if (invoker.weaponStatus[I_FLAGS] > F_NO_FIRE_SELECT) {
					invoker.weaponStatus[I_AUTO] = 0;
					return ResolveState("Nope");
				}

				if (invoker.weaponStatus[I_AUTO] >= 2) {
					invoker.weaponStatus[I_AUTO] = 0;
				}
				else {
					invoker.weaponStatus[I_AUTO]++;
				}
				A_WeaponReady(WRF_NONE);
				return ResolveState("Nope");
			}

		Chamber:
			#### B 0 Offset(0, 32) {
				if (!invoker.magazineHasAmmo()) {
					return ResolveState("nope");
				}

				if (invoker.magazineGetAmmo() % 100 > 0) {
					if (invoker.magazineGetAmmo() == (invoker.bMagazineCapacity + 1)) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity;
					}
					invoker.magazineAddAmmo(-1);
					invoker.setChamber();
				}
				else {
					invoker.weaponStatus[I_MAG] = min(invoker.magazineGetAmmo(), 0);
					A_StartSound(invoker.bChamberSound, CHAN_WEAPON, CHANF_OVERLAP);
				}

				if (BrokenRound()) {
					return ResolveState("Jam");
				}
				A_WeaponReady(WRF_NOFIRE);
				return ResolveState(NULL);
			}
			#### B 1 A_CheckCookoff();
			#### A 0 A_JumpIf(invoker.fireMode() < 1, "Nope");
			#### A 0 A_JumpIf(invoker.fireMode() > 4, "Nope");
			#### A 0 A_JumpIf(invoker.fireMode() > 1, 1);
			#### A 0 A_Refire();
			#### A 0 {
				return ResolveState("Ready");
			}

		Chamber_Manual:
			#### A 0 { 
				if (invoker.chambered()) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 3 Offset(-1, 36) A_WeaponBusy();
			#### D 4 Offset(-3, 42) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 100 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = 29;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}

					A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
					invoker.setChamber();
					BrokenRound();
					return ResolveState(NULL);
				}
				return ResolveState("Nope");
			}
			#### E 2 offset(-1, 36);
			#### D 2 offset(0, 34) {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}


		FinishChamber:
			#### B 1;
			#### A 0 A_CheckCookOff();
			#### A 0 A_Refire();
			#### A 0 {
				return ResolveState("Ready");
			}

		Cookoff:
			#### A 0 {
				A_ClearRefire();
				if (invoker.weaponStatus[I_MAG] >= 0 && JustPressed(BT_RELOAD) || JustPressed(BT_UNLOAD)) {
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_StartSound(invoker.bLoadSound, CHAN_WEAPON, CHANF_OVERLAP);
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, invoker.weaponStatus[I_MAG]);
					invoker.weaponStatus[I_MAG]= -1;
				}
				return ResolveState("ShootGun");
			}

		user4:
		Unload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				if (invoker.magazineGetAmmo() >= 0) {
					return ResolveState("UnloadMag");
				}
				else if (invoker.chambered() || invoker.brokenChamber()) {
					return ResolveState("UnloadChamber");
				}
				else {
					return ResolveState("UnloadMag");
				}
			}

		Reload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				if (!invoker.brokenChamber() && invoker.magazineGetAmmo() % 100 >= invoker.bMagazineCapacity && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
					return ResolveState("Nope");
				}
				else if (invoker.magazineGetAmmo() < 0 && invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
					return ResolveState("UnloadChamber");
				}
				else if (!HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass)) {
					return ResolveState("UnloadMag");
				}
				return ResolveState("Nope");
			}

		UnloadMag:
			#### A 1 Offset(0, 33);
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-8, 37);
			#### A 2 Offset(-11, 39) {
				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(-12, 40) {
				A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				A_StartSound(invoker.bLoadSound, CHAN_WEAPON);
			}
			#### A 20 offset(-14, 44) {
				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = -1;
				if (!PressingUnload() && !PressingReload() || A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, inMag);
					A_SetTics(1);
				}
				else {
					HDMagAmmo.GiveMag(self, invoker.bMagazineClass, inMag);
					A_StartSound("weapons/pocket", CHAN_WEAPON);
				}
				return ResolveState("MagOut");
			}

		UnloadChamber:
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-9, 39);
			#### A 3 Offset(-19, 44) A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
			#### B 2 Offset(-16, 42) {
				A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
				if (invoker.chambered() && !invoker.brokenChamber()) {
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					invoker.WeaponStatus[I_FLAGS] &= ~F_CHAMBER;
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				}
				else if (!random(0, 4)) {
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					for (int i = 0; i < 3; i++) {
						A_SpawnItemEx("TinyWallChunk", 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					}
					if (!random(0, 5)) {
						A_SpawnItemEx("HDSmokeChunk", 12, 0, height - 12, 4, frandom(-2, 2), frandom(2, 4));
					}
				}
				else if (invoker.brokenChamber()) {
					A_StartSound("weapons/smack", CHAN_WEAPON, CHANF_OVERLAP);
				}
				return ResolveState("ReloadEnd");
			}

		MagOut:
			#### A 0 {
				if (invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY || !CountInv(invoker.bMagazineClass)) {
					return ResolveState("ReloadEnd");
				}
				return ResolveState("LoadMag");
			}

		LoadMag:
			#### A 12 {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (!magRef) {
					return ResolveState("ReloadEnd");
				}

				A_StartSound("weapons/pocket", CHAN_WEAPON);
				A_SetTics(10);
				return ResolveState(NULL);
			}
			#### A 8 Offset(-15, 45) A_StartSound(invoker.bLoadSound, CHAN_WEAPON);
			#### A 1 Offset(-14, 44) {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
					A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				}
				return ResolveState("ReloadEnd");
			}

		ReloadEnd:
			#### A 2 Offset(-11, 39);
			#### A 1 Offset(-8, 37) A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(-3, 34);
			#### A 0 {
				return ResolveState("Chamber_Manual");
			}

		Hold:
			#### A 0 A_JumpIf(invoker.weaponStatus[I_FLAGS] & F_NO_FIRE_SELECT, "Nope");
			#### A 0 A_JumpIf(invoker.weaponstatus[I_AUTO] > 4, "Nope");
			#### A 0 A_JumpIf(invoker.weaponStatus[I_AUTO], "ShootGun");


	}


}