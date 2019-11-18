package impl;

class MovingSystem extends System<BallsEvent> {
	@:nodes var nodes: Node<Moving, Object3D>;
	var time = 0.0;

	override function update( dt: Float ) {
		time += dt;

		for (node in nodes) {
			final o = node.object3D.object;
			final offset = node.moving.offset;
			final radius = 5;
			final maxRadius = 5;
			o.position.z = Math.cos(time + 3 * offset) * maxRadius + radius;
		}
	}
}
