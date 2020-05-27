
class BaseStandardRifle : BHDWeapon {}

class BaseAltRifle : BHDWeapon {

	property BAltMagClass: BAltMagClass;
	string bAltMagClass;

	property BAltMagPicture: BAltMagPicture;
	string bAltMagPicture;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl) {
		BaseAltRifle basicWep = BaseAltRifle(hdw);
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

		sb.drawImage(basicWep.bAltMagPicture, (-62, -4), SB.DI_SCREEN_CENTER_BOTTOM, scale: (0.6, 0.6));
		sb.drawNum(hpl.CountInv(basicWep.bAltMagClass), -56, -8, sb.DI_SCREEN_CENTER_BOTTOM);
	}

	States {
		AltFire:
			---- A 1 offset(0, 34) {
				invoker.weaponStatus[I_FLAGS] ^= F_GL_MODE;
				invoker.airburst = 0;
				A_SetCrosshair(21);
				A_SetHelpText();
			}
			---- A 0 {
				return ResolveState("Nope");
			}

		Fire:
			---- A 0 {
				if (invoker.weaponStatus[I_FLAGS] & F_GL_MODE) {
					return ResolveState("FireAlt");
				}
				return ResolveState(NULL);
			}
			Goto super::fire;

		FireAlt:
			---- A 2;
			---- A 3 A_GunFlash("AltFlash");
			---- A 0 {
				return ResolveState("Nope");
			}

		AltFlash:
			---- A 0 A_JumpIf(invoker.weaponStatus[I_FLAGS] & I_GRENADE, 1);
			Stop;
			---- A 2 {
				A_FireHDGL();
				invoker.weaponStatus[I_FLAGS] &= ~I_GRENADE;
				A_StartSound("weapon/grenadeshot", CHAN_WEAPON);
				A_ZoomRecoil(0.95);
			}
			---- A 2 A_MuzzleClimb(0, 0, 0, 0, -1.2, -3, -1, -2.8);
			Stop;

		AltReload:
			---- A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				if (!(invoker.weaponStatus[I_FLAGS] & I_GRENADE) && CountInv(invoker.bAltMagClass)) {
					return ResolveState("UnloadAlt");
				}
				return ResolveState("Nope");
			}

		UnloadAlt:
			---- A 0 {
				A_SetCrosshair(21);
				A_MuzzleClimb(-0.3, -0.3);
			}
			---- A 2 offset(0, 34);
			---- A 1 offset(4, 38) {
				A_MuzzleClimb(-0.3, -0.3);
			}
			---- A 2 offset(8, 48) {
				A_StartSound("weapons/grenopen", CHAN_WEAPON, CHANF_OVERLAP);
				A_MuzzleClimb(-0.3, -0.3);
				if (invoker.weaponstatus[I_FLAGS] & I_GRENADE) {
					A_StartSound("weapons/grenreload", CHAN_WEAPON);
				}
			}
			---- A 10 offset(10, 49) {
				if (!(invoker.weaponstatus[I_FLAGS] & I_GRENADE)) {
					if (!(invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY)) {
						A_SetTics(3);
						return;
					}
				}

				invoker.weaponStatus[I_FLAGS] &= ~I_GRENADE;
				if (!PressingUnload() || A_JumpIfInventory(invoker.bAltMagClass, 0, "null")) {
					A_SpawnItemEx(
						invoker.bAltMagClass, 
						cos(pitch) * 10,
						0,
						height - 10 - 10 * sin(pitch),
						vel.x,
						vel.y,
						vel.z,
						0,
						SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
				}
				else {
					A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
					A_GiveInventory("HDRocketAmmo", 1);
					A_MuzzleClimb(frandom(0.8, -0.2), frandom(0.4, -0.2));
				}
			}
			---- A 0 A_JumpIf(invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY, "areloadend");

		LoadAlt:
			---- A 4 offset(10, 50) A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			---- AAA 8 offset(10, 50) A_MuzzleClimb(frandom(-0.2, 0.8), frandom(-0.2, 0.4));
			---- A 18 offset(8, 50) {
				A_TakeInventory(invoker.bAltMagClass, 1, TIF_NOTAKEINFINITE);
				invoker.weaponStatus[I_FLAGS] |= I_GRENADE;
				A_StartSound("weapon/grenreload", CHAN_WEAPON);
			}

		AReloadEnd:
			---- A 4 offset(4, 44) A_StartSound("weapons/grenopen", CHAN_WEAPON);
			---- A 1 offset(0, 40);
			---- A 1 offset(0, 34) A_MuzzleClimb(frandom(-2.4, 0.2), frandom(-1.4, 0.2));
			---- A 0 {
				return ResolveState("Nope");
			}
	}
}




class BaseGLRifle : BaseAltRifle {

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl) {
		super.DrawHUDStuff(sb, hdw, hpl);
		if (hdw.weaponStatus[I_FLAGS] & F_GL_MODE) {
			int ab=hdw.airburst;
			sb.drawnum(ab,
				-30,-22,sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_TEXT_ALIGN_RIGHT,
				ab?Font.CR_WHITE:Font.CR_DARKGRAY
			);
			sb.drawwepdot(-30,-42+min(16,ab/10),(4,1));
			sb.drawwepdot(-30,-26,(1,16));
			sb.drawwepdot(-32,-26,(1,16));
		}
		if(hdw.weaponstatus[I_FLAGS] & I_GRENADE)
			sb.drawwepdot(-16,-13,(4,2.6));
	}

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {
		if (hdw.weaponStatus[I_FLAGS] & F_GL_MODE) {
			sb.drawgrenadeladder(hdw.airburst, bob);
		}
		else {
			super.DrawSightPicture(sb, hdw, hpl, sightbob, bob, fov, scopeview, hpc, whichdot);
		}
	}	

}


















// WIP
class BaseBoltRifle : BHDWeapon {

	action void A_ChamberGrit(int amt,bool onlywhileempty=false){
		int ibg = invoker.weaponstatus[I_GRIME];
		if(!random(0,4)) {
			ibg++;
		}
		invoker.weaponstatus[I_GRIME] = ibg;
	}

	States {
		ShootGun:
			#### A 1 {
				console.printf("Fired? 2");
				if (invoker.brokenChamber() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					console.printf("Nope");
					return ResolveState("Nope");
				}
				else if (invoker.chambered()) {
					console.printf("Flashing");
					A_GunFlash();
					A_WeaponReady(WRF_NONE);
					return ResolveState(NULL);
				}
				return ResolveState(NULL);
			}
			#### B 1;
			#### A 0 {
				return ResolveState("Ready");
			}

		AltFire:
			#### A 0 {
				console.printf("Alt fire!");
			}
			#### A 1 offset(0, 34) A_WeaponBusy();
			#### A 1 {
				if (invoker.magazineGetAmmo() == -1) {
					return ResolveState("Nope");
				}
				else if (invoker.chambered()) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### A 2 offset(2, 36);
			#### A 1 offset(4, 38);
			#### A 1 offset(0, 34);
			#### A 0 A_ChamberGrit(randompick(0, 0, 0, 0, -1, 1, 2), true);
			#### A 0 A_Refire("chamber");
			#### A 0 {
				return ResolveState("Ready");
			}

		Chamber:
			#### C 5;
			#### D 2;
			#### D 0 Offset(0, 32) {
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
			#### E 2 A_CheckCookoff();
			#### E 0 {
				return ResolveState("AltHold");
			}

		AltHold:
			#### E 1;
			#### E 1 {
				if (pressingAltFire()) {
					return ResolveState("AltHold");
				}
				return ResolveState(NULL);
			}
			#### D 2;
			#### C 2;
			#### A 0 {
				return ResolveState("Ready");
			}

	}

}