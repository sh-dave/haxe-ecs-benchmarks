package impl;

class ColliderSystem extends System<BallsEvent> {
	@:nodes var boxes: Node<Collisionable, Object3D>;
	@:nodes var balls: Node<Collider, Object3D>;

	override function update( dt: Float ) {
		for (ballNode in balls) {
			final oBall = ballNode.object3D.object;

			for (boxNode in boxes) {
				final oBox = boxNode.object3D.object;
				final prevColliding = boxNode.entity.has(Colliding);

				if (false) { // TODO (DK) (boundingSphereIntersects)
					if (!prevColliding) {
						boxNode.entity.add(new Colliding());
					}
				} else {
					if (prevColliding) {
						boxNode.entity.remove(Colliding);
						boxNode.entity.add(new Recovering());
						boxNode.entity.add(new Timeout(C.TIMER_TIME, null, [Recovering]));
					}
				}
			}
		}
	}
}
