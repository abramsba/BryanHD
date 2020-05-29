


// Base Class for Rifle
class BHDWeapon : HDWeapon {

	default {
		BHDWeapon.SoundClass "chicken";
		BHDWeapon.BSpriteWithFrame 0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.EjectShellClass "NULL";
	}

	property EjectShellClass: ejectShellClass;
	String ejectShellClass;

	property SoundClass: soundClass;
	Name SoundClass;

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

	property BSpriteWithFrame: bSpriteWithFrame;
	int bSpriteWithFrame;

	property BSpriteWithoutMag: bSpriteWithoutMag;
	string bSpriteWithoutMag;

	property BSpriteWithoutFrame: bSpriteWithoutFrame;
	int bSpriteWithoutFrame; 

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

	property BSFireSound : bSFireSound;
	string bSFireSound;

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

	property BSilentOffsetX : bSilentOffsetX;
	property BSilentOffsetY : bSilentOffsetY;
	float bSilentOffsetX;
	float bSilentOffsetY;

	BaseBarrelAttachment barrelAttachment;
	BaseSightAttachment scopeAttachment;
	BaseMiscAttachment miscAttachment;

	Class<BaseBarrelAttachment> barrelClass;
	Vector2 barrelOffsets;
	bool useBarrelOffsets;

	Class<BaseMiscAttachment> miscClass;
	Vector2 miscOffsets;
	bool useMiscOffsets;

	Class<BaseSightAttachment> scopeClass;
	Vector2 scopeOffsets;
	bool useScopeOffsets;

	bool miscActive;
	void toggleMisc() const {
		miscActive = !miscActive;
	}

	property BBarrelMount: bBarrelMount;
	string bBarrelMount;

	property BScopeMount: bScopeMount;
	string bScopeMount;

	property BMiscMount: bMiscMount;
	string bMiscMount;

	// Pretty API that I need to use consistently TODO

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

	int getBarrelSerialID() const {
		int all = weaponStatus[I_3RD] & B_BARREL;
		return all;
	}

	int getMiscSerialID() const {
		int all = weaponStatus[I_3RD] & B_MISC;
		return (all >> 8);
	}

	int getScopeSerialID() const {
		int all = weaponStatus[I_3RD] & B_SCOPE;
		return (all >> 16);
	}

	void setBarrelSerialID(int id) const {
		weaponStatus[I_3RD] &= ~B_BARREL;
		weaponStatus[I_3RD] |= id;
	}

	void setMiscSerialID(int id) const {
		weaponStatus[I_3RD] &= ~B_MISC;
		int offset = id << 8;
		weaponStatus[I_3RD] |= offset;
	}

	void setScopeSerialID(int id) const {
		weaponStatus[I_3RD] &= ~B_SCOPE;
		int offset = id << 16;
		weaponStatus[I_3RD] |= offset;
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
		AttachmentManager mgr = AttachmentManager(EventHandler.Find("AttachmentManager"));
		int barrelId = getLoadoutVar(input, "ba");
		int scopeId = getLoadoutVar(input, "bs");
		int miscId = getLoadoutVar(input, "bm");
		
		Class<BaseSightAttachment> bsClass = mgr.getScopeClass(scopeId);
		if (bsClass) {
			string bsMountId = GetDefaultByType(bsClass).mountId;
			if (bsMountId == bScopeMount) {
				setScopeSerialID(scopeId);
				scopeClass = bsClass;
			}
		}

		Class<BaseBarrelAttachment> baClass = mgr.getBarrelClass(barrelId);
		if (baClass) {
			string baMountId = GetDefaultByType(baClass).mountId;
			if (baMountId == bBarrelMount) {
				setBarrelSerialID(barrelId);
				barrelClass = baClass;
			}
		}

		Class<BaseMiscAttachment> bmClass = mgr.getMiscClass(miscId);
		if (bmClass) {
			string bmMountId = GetDefaultByType(bmClass).mountId;
			if (bmMountId == bMiscMount) {
				setMiscSerialID(miscId);
				miscClass = bmClass;
			}
		}		
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

		if (SpawnState == GetDefaultByType("Actor").SpawnState || SpawnState == NULL) {
			return NULL;

		}
		if (bUndroppable || bUntossable || Owner == NULL || Amount <= 0 || amt == 0) {
			return NULL;
		}
		DropTime = 30;
		bSpecial = bSolid = false;
		if (miscActive) {
			FlashLightManager mgr = FlashLightManager(EventHandler.Find("FlashLightManager"));
			mgr.destLight(consoleplayer);
		}
		miscActive = false;
		let copyWeapon = super.CreateTossable(amt);
		return copyWeapon;
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

	String getFrontSightImage() const {
		if (scopeClass) {
			let img = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontImage;
			return img;
		}
		return bFrontSightImage;
	}

	String getBackSightImage() const {
		if (scopeClass) {
			let img = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackImage;
			return img;
		}
		return bBackSightImage;
	}

	Vector2 getFrontSightOffsets() const {
		if (scopeClass) {
			let x = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontOffX;
			let y = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).FrontOffY;
			return (x, y);
		}
		return (bFrontOffsetX, bFrontOffsetY);
	}

	Vector2 getBackSightOffsets() const {
		if (scopeClass) {
			let x = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackOffX;
			let y = GetDefaultByType((Class<BaseSightAttachment>)(scopeClass)).BackOffY;
			return (x, y);
		}
		return (bBackOffsetX, bBackOffsetY);
	}

	Vector2 getBarrelOffsets() const {
		return (0, 0);
	}

	vector2 lastBob;

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {

		BHDWeapon basicWep = BHDWeapon(hdw);


		double dotoff = max(abs(bob.x), abs(bob.y));

		// TODO Get from scope if has scope
		double dotLimit = 6;
		if (basicWep.scopeClass) {
			dotLimit = GetDefaultByType((Class<BaseSightAttachment>)(basicWep.scopeClass)).DotThreshold;
		}

		if (dotoff < dotLimit){
			sb.drawImage(getFrontSightImage(), getFrontSightOffsets() + bob * 3, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.9 - dotoff * 0.04);
		}
		sb.drawimage(getBackSightImage(), getBackSightOffsets() + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER );

		if (basicWep.scopeClass is "BaseScopeAttachment" && scopeview) {
			let def = GetDefaultByType((Class<BaseScopeAttachment>)(basicWep.scopeClass));

			string image               = def.ScopeImage;
			string ScopeSightImageName = def.SightImage;

			double xscalecam        = def.xscalecam;
			double yscalecam        = def.yscalecam;
			double xposcam          = def.xposcam;
			double yposcam          = def.yposcam; //58;

			double scaledwidth      = def.scaledwidth;

			double xclipcam         = def.xclipcam;
			double yclipcam         = def.yclipcam;

			double scopeholex       = def.scopeholex;
			double scopeholey       = def.scopeholey;
			double scopescalex      = def.scopescalex;
			double scopescaley      = def.scopescaley;

			double scopeImageX      = def.scopeImagex;
			double scopeImageY      = def.scopeImagey;
			double scopeImageScaleX = def.scopeImageScaleX;
			double scopeImageScaleY = def.scopeImageScaley;
			double scopeBackX       = def.scopeBackX;
			double scopeBackY       = def.scopeBackY;

			

			Vector2 cameraPos = (xposcam, yposcam);
			Vector2 scaleCamera = (xscalecam, yscalecam);
			Vector2 clipCamera = (xclipcam, yclipcam);
			Vector2 scopeHole = (scopeholex, scopeholey);
			Vector2 scopeScale = (scopescalex, scopescaley);
			Vector2 scopeImage = (scopeimagex, scopeimagey);
			Vector2 scopeImageScale = (scopeImageScaleX, scopeImageScaleY);
			Vector2 scopeBack = (scopeBackX, scopeBackY);

			TexMan.SetCameraToTexture(hpc, "HDXHCAM3", 5);
			sb.drawImage("HDXHCAM3", cameraPos + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: scaleCamera);

			int cx,cy,cw,ch;
			[cx,cy,cw,ch]=screen.GetClipRect();
			sb.SetClipRect(
				clipCamera.x + bob.x, 
				clipCamera.y + bob.y, 
				scaledwidth, 
				scaledwidth,
				sb.DI_SCREEN_CENTER
			);

			
			sb.drawimage(
				"scophole", 
				scopeHole + bob * 3, 
				sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, 
				scale: scopeScale
			);

			sb.drawImage(
				ScopeSightImageName, 
				scopeImage + bob * 3, 
				sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, 
				scale: scopeImageScale
			);
			

			sb.SetClipRect(cx,cy,cw,ch);

			sb.drawImage(image, scopeBack + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER );
		}


	}


	action state GetMagState() {
		if (invoker.magazineGetAmmo() > 0) {
			return ResolveState("SpawnMag");
		}
		return ResolveState("SpawnNoMag");
	}

	bool flashlight;
	bool flashlightOn;

	action void GetAttachmentStateBarrel(AttachmentManager mgr) {
		// Barrel
		int sid = -1;
		int oid = -1;

		//console.printf("Attach barrel %b", invoker.useBarrelOffsets);

		//TakeInventory("BSilencerRemover", 1);
		if (invoker.useBarrelOffsets) {
			//console.printf("with %i %i", invoker.barrelOffsets.x, invoker.barrelOffsets.y);
			A_OverlayOffset(LAYER_BARREL, invoker.barrelOffsets.x, invoker.barrelOffsets.y);
		}
		else {
			//console.printf("none");
			A_OverlayOffset(LAYER_BARREL, 0, 0);
		}

		if (invoker.getBarrelSerialID() == 0) {
			//console.printf("hi mom?");
			//
			invoker.barrelClass = null;
			A_ClearOverlays(LAYER_BARREL, LAYER_BARREL);
		}
		else {
			//GiveInventoryType("BSilencerRemover");
			if (!invoker.barrelClass && invoker.getBarrelSerialID() > 0) {
				sid = invoker.getBarrelSerialID();
				invoker.barrelClass = mgr.getBarrelClass(sid);
			}

			sid = GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).serialId;
			if (invoker.getBarrelSerialID() > 0 && invoker.getBarrelSerialID() != sid) {
				sid = invoker.getBarrelSerialID();
				invoker.barrelClass = mgr.getBarrelClass(sid);
				//invoker.barrelLength += GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).barrelLength;
			}

			if (invoker.getBarrelSerialID() > 0) {
				let psp = players[consoleplayer].FindPSprite(LAYER_BARREL);
				if (!psp) {
					A_Overlay(LAYER_BARREL, "BarrelOverlay");
				}

				oid = mgr.barrelOffsetIndex(invoker, invoker.barrelClass);
				//console.printf("%i %p %p", oid, invoker, invoker.barrelClass);
				if (oid > -1) {
					invoker.barrelOffsets = mgr.getBarrelOffset(oid);
					A_OverlayOffset(LAYER_BARREL, invoker.barrelOffsets.x, invoker.barrelOffsets.y);
					invoker.useBarrelOffsets = true;
				}
				else {
					invoker.barrelOffsets = (0, 0);
					invoker.useBarrelOffsets = false;
				}

			}
			else {
				A_ClearOverlays(LAYER_BARREL, LAYER_BARREL);
			}
		}
	}

	action void GetAttachmentStateScope(AttachmentManager mgr) {
		int sid = -1;
		int oid = -1;

		if (invoker.useScopeOffsets) {
			A_OverlayOffset(LAYER_SCOPE, invoker.scopeOffsets.x, invoker.scopeOffsets.y);
		}
		else {
			A_OverlayOffset(LAYER_SCOPE, 0, 0);
		}

		if (invoker.getScopeSerialID() == 0) {
			invoker.scopeClass = null;
			A_ClearOverlays(LAYER_SCOPE, LAYER_SCOPE);
		}
		else {
			if (!invoker.scopeClass && invoker.getScopeSerialID() > 0) {
				sid = invoker.getScopeSerialID();
				invoker.scopeClass = mgr.getScopeClass(sid);
			}

			sid = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).serialId;
			if (invoker.getScopeSerialID() > 0 && invoker.getScopeSerialID() != sid) {
				sid = invoker.getScopeSerialID();
				invoker.scopeClass = mgr.getScopeClass(sid);
			}

			if (invoker.getScopeSerialID() > 0) {
				let psp = players[consoleplayer].FindPSprite(LAYER_SCOPE);
				if (!psp) {
					A_Overlay(LAYER_SCOPE, "ScopeOverlay");
				}

				oid = mgr.scopeOffsetIndex(invoker, invoker.scopeClass);
				if (oid > -1) {
					invoker.scopeOffsets = mgr.getScopeOffset(oid);
					A_OverlayOffset(LAYER_SCOPE, invoker.scopeOffsets.x, invoker.scopeOffsets.y);
					invoker.useScopeOffsets = true;
				}
				else {
					invoker.scopeOffsets = (0, 0);
					invoker.useScopeOffsets = false;
				}
				
			}
			else {
				A_ClearOverlays(LAYER_SCOPE, LAYER_SCOPE);
			}
		}
	}

	action void GetAttachmentStateMisc(AttachmentManager mgr) {
		int sid = -1;
		int oid = -1;

		if (invoker.useMiscOffsets) {
			A_OverlayOffset(LAYER_MISC, invoker.miscOffsets.x, invoker.miscOffsets.y);
		}
		else {
			A_OverlayOffset(LAYER_MISC, 0, 0);
		}

		if (invoker.getMiscSerialID() == 0) {
			invoker.miscClass = null;
			A_ClearOverlays(LAYER_MISC, LAYER_MISC);
		}
		else {
			if (!invoker.miscClass && invoker.getMiscSerialID() > 0) {
				sid = invoker.getMiscSerialID();
				invoker.miscClass = mgr.getMiscClass(sid);
			}

			sid = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).serialId;
			if (invoker.getMiscSerialID() > 0 && invoker.getMiscSerialID() != sid) {
				sid = invoker.getMiscSerialID();
				invoker.miscClass = mgr.getMiscClass(sid);
			}

			if (invoker.getMiscSerialID() > 0) {
				let psp = players[consoleplayer].FindPSprite(LAYER_MISC);
				if (!psp) {
					A_Overlay(LAYER_MISC, "MiscOverlay");
				}

				oid = mgr.miscOffsetIndex(invoker, invoker.miscClass);
				if (oid > -1) {
					invoker.miscOffsets = mgr.getMiscOffset(oid);
					A_OverlayOffset(LAYER_MISC, invoker.miscOffsets.x, invoker.miscOffsets.y);
					invoker.useMiscOffsets = true;
				}
				else {
					invoker.miscOffsets = (0, 0);
					invoker.useMiscOffsets = false;
				}
				
			}
			else {
				A_ClearOverlays(LAYER_MISC, LAYER_MISC);
			}
		}
	}

	action void GetAttachmentState() {
		int sid = -1;
		AttachmentManager mgr = AttachmentManager(EventHandler.Find("AttachmentManager"));
		GetAttachmentStateBarrel(mgr);
		GetAttachmentStateScope(mgr);
		GetAttachmentStateMisc(mgr);
	}

	states {

		BarrelOverlay:
			TNT1 A 0 {
				if (invoker.barrelClass) {
					string sp = GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).BaseSprite;
					int idx = GetDefaultByType((Class<BaseBarrelAttachment>)(invoker.barrelClass)).BaseFrame;
					let psp = players[consoleplayer].FindPSprite(LAYER_BARREL);
					if (psp) {
							psp.sprite = GetSpriteIndex(sp);
							psp.frame = idx;
					}
				}
				A_SetTics(1);
			}
			Loop;

		ScopeOverlay:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					string sp = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).BaseSprite;
					int idx = GetDefaultByType((Class<BaseSightAttachment>)(invoker.scopeClass)).BaseFrame;
					let psp = players[consoleplayer].FindPSprite(LAYER_SCOPE);
					if (psp) {
							psp.sprite = GetSpriteIndex(sp);
							psp.frame = idx;
					}
				}
				A_SetTics(1);
			}
			Loop;

		MiscOverlay:
			TNT1 A 0 {
				if (invoker.miscClass) {
					string sp;
					int idx;

					if (!invoker.miscActive) {
						sp = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).BaseSprite;
						idx = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).BaseFrame;
					} 
					else {
						sp = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).OnSprite;
						idx = GetDefaultByType((Class<BaseMiscAttachment>)(invoker.miscClass)).OnFrame;
					}

					let psp = players[consoleplayer].FindPSprite(LAYER_MISC);
					if (psp) {
							psp.sprite = GetSpriteIndex(sp);
							psp.frame = idx;
					}
				}
				A_SetTics(1);
			}
			Loop;

		FlashlightOn:
			TNT1 A 0;
			Stop;

		FlashLightOff:
			TNT1 A 0;
			Stop;

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

		SpawnMag:
			#### # -1 {
				sprite = GetSpriteIndex(invoker.BSpriteWithMag);
				frame = invoker.BSpriteWithFrame;
			}
			Goto Super::Spawn;

		SpawnNoMag:
			#### # -1 {
				sprite = GetSpriteIndex(invoker.BSpriteWithoutMag);
				frame = invoker.BSpriteWithoutFrame;
			}
			Goto Super::Spawn;

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
					A_Overlay(-1000, "Flash");
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
			#### # 1 Bright {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					A_Light1();
					HDFlashAlpha(-16);
				}

				bool silenced = invoker.barrelClass is "BaseSilencerAttachment";
				string sound = silenced ? invoker.bSFireSound : invoker.bFireSound;

				A_StartSound(sound, CHAN_WEAPON, CHANF_OVERLAP);
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

				double fc = max(pitch * 0.01, 5);
				double cosp = cos(pitch);

				// Todo: Make it not constantly be in your face 
				//       create property to spawn this bullet
				A_SPawnItemEx(
					invoker.EjectShellClass,
					cosp * 6, 
					5, 
					height - 8 - sin(pitch) * 6,
					cosp * -2,
					1,
					2 - sin(pitch),
					0,
					SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);

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

		Select0:
			M16G A 0 GetAttachmentState();
			Goto super::select0small;

		Deselect0:
			M16G A 0 GetAttachmentState();
			Goto super::deselect0small;


		AttachmentStart:
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(1, 37);
			#### A 1 Offset(1, 38);
			#### A 1 Offset(1, 39);
			#### A 1 Offset(2, 40);
			#### A 1 Offset(2, 41);
			#### A 1 Offset(2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(2, 43);
			#### A 1 Offset(1, 44);
			#### A 1 Offset(1, 45);
			#### A 1 Offset(1, 46);
			#### A 1 Offset(1, 45);
			#### A 1 Offset(1, 44);
			#### A 1 Offset(2, 43);
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(2, 43);
			#### A 1 Offset(2, 42);
			#### A 1 Offset(2, 40);
			#### A 1 Offset(1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				return ResolveState("Ready");
			}

		BarrelAttachmentRemove:
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(-1, 37);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(-1, 39);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-2, 41);
			#### A 1 Offset(-2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 46);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-2, 43);
			#### A 0 {
				invoker.setBarrelSerialID(0);
				invoker.barrelClass = null;
				invoker.useBarrelOffsets = false;
				invoker.barrelOffsets = (0, 0);
			}
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-2, 42);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				return ResolveState("Ready");
			}

		ScopeAttachmentRemove:
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(-1, 37);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(-1, 39);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-2, 41);
			#### A 1 Offset(-2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 46);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-2, 43);
			#### A 0 {
				invoker.setScopeSerialID(0);
				invoker.scopeClass = null;
				invoker.useScopeOffsets = false;
				invoker.scopeOffsets = (0, 0);
			}
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-2, 42);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				return ResolveState("Ready");
			}

		MiscAttachmentRemove:
			#### A 1 A_WeaponBusy();
			#### A 1 Offset(-1, 37);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(-1, 39);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-2, 41);
			#### A 1 Offset(-2, 42);
			#### A 0 A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 46);
			#### A 1 Offset(-1, 45);
			#### A 1 Offset(-1, 44);
			#### A 1 Offset(-2, 43);
			#### A 0 {
				invoker.setMiscSerialID(0);
				invoker.miscClass = null;
				invoker.useMiscOffsets = false;
				invoker.miscOffsets = (0, 0);
			}
			#### A 0 GetAttachmentState();
			#### A 0 A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 15 Offset(-2, 43);
			#### A 1 Offset(-2, 42);
			#### A 1 Offset(-2, 40);
			#### A 1 Offset(-1, 38);
			#### A 1 Offset(0, 36);
			#### A 0 {
				return ResolveState("Ready");
			}

	}

	override void detachfromowner(){
		super.detachfromowner();
	}


}