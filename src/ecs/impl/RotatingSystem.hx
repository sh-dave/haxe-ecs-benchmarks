package impl;

class RotatingSystem extends System<BallsEvent> {
	@:nodes var nodes: Node<Rotating, Object3D>;

	override function update( dt: Float ) {
		for (node in nodes) {
			final o = node.object3D.object;
			final rot = node.rotating;
			final speed = rot.rotatingSpeed;

			o.rotation.x += speed * dt;
			o.rotation.y += speed * dt * 2;
			o.rotation.z += speed * dt * 3;
		}
	}
}
