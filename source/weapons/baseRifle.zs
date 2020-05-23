
class BaseStandardRifle : BHDWeapon {}

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