package impl;

class ColliderSystem extends System<BallsEvent> {
	@:nodes var boxes: Node<Collisionable, Object3D>;
	@:nodes var balls: Node<Collider, Object3D>;

	inline function intersect( sx: Float, sy: Float, sz: Float, sr: Float, ox: Float, oy: Float, oz: Float, or: Float ) {
		final distance = //Math.sqrt(
			(sx - ox) * (sx - ox) +
			(sy - oy) * (sy - oy) +
			(sz - oz) * (sz - oz)
			;
		//);

		return distance * distance < sr * sr + or * or;
	}

	override function update( dt: Float ) {
		for (ballNode in balls) {
			final oBall = ballNode.object3D.object;
			final mBall = oBall.m;

			for (boxNode in boxes) {
				final oBox = boxNode.object3D.object;
				final prevColliding = boxNode.entity.has(Colliding);
				final colliding = intersect(
					// oBall.position.x, oBall.position.y, oBall.position.z, 0.2,
					mBall._30, mBall._31, mBall._32, 1,
					oBox.position.x, oBox.position.y, oBox.position.z, 0.2
				);

				if (colliding) {
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
