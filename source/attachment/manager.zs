
class AttachmentManager : EventHandler {

	Array<Class<BaseBarrelAttachment> > barrelAttachments;
	Array<Class<BaseMiscAttachment> > miscAttachments;
	Array<Class<BaseScopeAttachment> > scopeAttachments;

	override void OnRegister() {
		int count = AllActorClasses.Size();
		Class<BaseBarrelAttachment> isUsed = null;
		for (int i = 0; i < count; i++) {
			let next = AllActorClasses[i];
			if (!(next is "BaseAttachment")) {
				continue;
			}

			let serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
			if (serialId > 0) {
				if (next is "BaseBarrelAttachment") {
					let barrelref = (Class<BaseBarrelAttachment>)(next);
					if (getBarrelClass(serialId)) {
						console.printf("Failed to register attachment %s. SerialID for barrel already in use by.", next.getClassName(), isUsed.getClassName());
					}
					else { 
						barrelAttachments.push(barrelref);
					}
				}
				else if (next is "BaseMiscAttachment") {
					// todo
				}
				else if (next is "BaseScopeAttachment") {
					let scopeRef = (Class<BaseScopeAttachment>)(next);
					if (getScopeClass(serialId)) {
						console.printf("Failed to register attachment %s. SerialID for scope already in use by.", next.getClassName(), isUsed.getClassName());
					}
					else { 
						scopeAttachments.push(scopeRef);
					}
				}
			}
		}
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