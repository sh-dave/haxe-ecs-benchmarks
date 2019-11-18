package impl;

class ColliderSystem extends System {
	var boxes: Family<Collisionable, Object3D>;
	var balls: Family<Collider, Object3D>;
	var _colliding: Wire<Colliding>;
	var _recovering: Wire<Recovering>;
	var _timeout: Wire<Timeout>;
	var _o3d: Wire<Object3D>;

	public function new() {
	}

	inline function intersect( sx: Float, sy: Float, sz: Float, sr: Float, ox: Float, oy: Float, oz: Float, or: Float ) {
		final distance = //Math.sqrt(
			(sx - ox) * (sx - ox) +
			(sy - oy) * (sy - oy) +
			(sz - oz) * (sz - oz)
			;
		//);

		return distance * distance < sr * sr + or * or;
	}

	override function update() {
		for (ballNode in balls) {
			final oBall = _o3d.get(ballNode).object;
			final mBall = oBall.m;

			for (boxNode in boxes) {
				final oBox = _o3d.get(boxNode).object;
				final prevColliding = _colliding.has(boxNode);
				final colliding = intersect(
					// oBall.position.x, oBall.position.y, oBall.position.z, 0.2,
					mBall._30, mBall._31, mBall._32, 1,
					oBox.position.x, oBox.position.y, oBox.position.z, 0.2
				);

				if (colliding) {
					if (!prevColliding) {
						_colliding.create(boxNode);
						world.commit(boxNode);
					}
				} else {
					if (prevColliding) {
						_colliding.destroy(boxNode);
						_recovering.create(boxNode);
						final timeout = _timeout.create(boxNode);
						timeout.timer = C.TIMER_TIME;
						timeout.removeComponents = [Recovering];
						world.commit(boxNode);
					}
				}
			}
		}
	}
}
