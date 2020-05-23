
class Offset : Actor {
	property WeaponClass: weaponClass;
	property WeaponOverlay: weaponOverlay;
	property OffX: offx;
	property OffY: offy;
	string weaponClass;
	string weaponOverlay;
	int offx;
	int offy;
}

class BarrelOffset : Offset {}
class MiscOffset : Offset {}
class ScopeOffset : Offset {}

class AttachmentManager : EventHandler {

	Array<Class<BaseBarrelAttachment> > barrelAttachments;
	Array<Class<BaseMiscAttachment> > miscAttachments;
	Array<Class<BaseScopeAttachment> > scopeAttachments;

	Array<Class<BarrelOffset> > barrelOffsets;
	Array<Class<ScopeOffset> > scopeOffsets;
	Array<Class<MiscOffset> > miscOffsets;

	Vector2 origin;

	override void OnRegister() {

		origin = (0, 0);

		// Loop once over actor classes to find Attachment classes
		int count = AllClasses.Size();
		Class<BaseBarrelAttachment> isUsed = null;
		for (int i = 0; i < count; i++) {

			let next = AllClasses[i];
			if (!(next is "BaseAttachment")) {
				if (next is "BarrelOffset") {
					let barrelOffRef = (Class<BarrelOffset>)(next);
					barrelOffsets.push(barrelOffRef);
				}
				else if (next is "ScopeOffset") {
					let scopeOffRef = (Class<ScopeOffset>)(next);
					scopeOffsets.push(scopeOffRef);
				}
				else if (next is "MiscOffset") {
					let miscOffRef = (Class<MiscOffset>)(next);
					miscOffsets.push(miscOffRef);
				}
				continue;
			}

			let serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
			if (serialId > 0) {
				if (next is "BaseBarrelAttachment") {
					let barrelref = (Class<BaseBarrelAttachment>)(next);
					if (getBarrelClass(serialId)) {
						// Crashes on death
						//console.printf("Failed to register attachment %s. SerialID for barrel already in use by.", next.getClassName(), isUsed.getClassName());
					}
					else { 
						barrelAttachments.push(barrelref);
					}
				}
				else if (next is "BaseMiscAttachment") {
					let miscRef = (Class<BaseMiscAttachment>)(next);
					if (getMiscClass(serialId)) {

					}
					else {
						miscAttachments.push(miscRef);
					}
					// todo
				}
				else if (next is "BaseScopeAttachment") {
					let scopeRef = (Class<BaseScopeAttachment>)(next);
					if (getScopeClass(serialId)) {
						// Crashes on death
						//console.printf("Failed to register attachment %s. SerialID for scope already in use by.", next.getClassName(), isUsed.getClassName());
					}
					else { 
						scopeAttachments.push(scopeRef);
					}
				}
			}
		}

	}

	int scopeOffsetIndex(BHDWeapon weapon, Class<BaseScopeAttachment> scopecls) {
		int count = scopeOffsets.size();
		for (int i = 0; i < count; i++) {
			let next = scopeOffsets[i];
			let gname = GetDefaultByType((Class<Offset>)(next)).weaponClass;
			let aname = GetDefaultByType((Class<Offset>)(next)).weaponOverlay;
			if (gname == weapon.getClassName() && aname == scopecls.getClassName()) {
				return i;
			}
		}
		return -1;
	}

	Vector2 getScopeOffset(int i) {
		let next = scopeOffsets[i];
		let x = GetDefaultByType((Class<Offset>)(next)).offx;
		let y = GetDefaultByType((Class<Offset>)(next)).offy;
		return (x, y);
	}



	int miscOffsetIndex(BHDWeapon weapon, Class<BaseMiscAttachment> scopecls) {
		int count = miscOffsets.size();
		for (int i = 0; i < count; i++) {
			let next = miscOffsets[i];
			let gname = GetDefaultByType((Class<Offset>)(next)).weaponClass;
			let aname = GetDefaultByType((Class<Offset>)(next)).weaponOverlay;
			if (gname == weapon.getClassName() && aname == scopecls.getClassName()) {
				return i;
			}
		}
		return -1;
	}

	Vector2 getMiscOffset(int i) {
		let next = miscOffsets[i];
		let x = GetDefaultByType((Class<Offset>)(next)).offx;
		let y = GetDefaultByType((Class<Offset>)(next)).offy;
		return (x, y);
	}









	int barrelOffsetIndex(BHDWeapon weapon, Class<BaseBarrelAttachment> barrelcls) {
		int count = barrelOffsets.size();
		for (int i = 0; i < count; i++) {
			let next = barrelOffsets[i];
			let gunName = GetDefaultByType((Class<Offset>)(next)).weaponClass;
			let scopeName = GetDefaultByType((Class<Offset>)(next)).weaponOverlay;
			if (gunName == weapon.getClassName() && scopeName == barrelcls.getClassName()) {
				return i;
			}
		}
		return -1;
	}

	Vector2 getBarrelOffset(int i) {
		let next = barrelOffsets[i];
		let x = GetDefaultByType((Class<Offset>)(next)).offx;
		let y = GetDefaultByType((Class<Offset>)(next)).offy;
		return (x, y);
	}





	Class<BaseMiscAttachment> getMiscClass (int serialId) {
		int count = miscAttachments.Size();
		for (int i = 0; i < count; i++) {
			let next = miscAttachments[i];
			if (next) {
				let n_serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
				if (n_serialId == serialId) {
					Class<BaseMiscAttachment> cast = (Class<BaseMiscAttachment>)(next);
					return cast;
				}
			}
		}
		return null;
	}

	Class<BaseScopeAttachment> getScopeClass (int serialId) {
		int count = scopeAttachments.Size();
		for (int i = 0; i < count; i++) {
			let next = scopeAttachments[i];
			if (next) {
				let n_serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
				if (n_serialId == serialId) {
					Class<BaseScopeAttachment> cast = (Class<BaseScopeAttachment>)(next);
					return cast;
				}
			}
		}
		return null;
	}

	Class<BaseBarrelAttachment> getBarrelClass (int serialId) {
		int count = barrelAttachments.Size();
		for (int i = 0; i < count; i++) {
			let next = barrelAttachments[i];
			if (next) {
				let n_serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
				if (n_serialId == serialId) {
					Class<BaseBarrelAttachment> cast = (Class<BaseBarrelAttachment>)(next);
					return cast;
				}
			}
		}
		return null;
	}
	
}