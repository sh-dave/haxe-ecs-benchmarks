package impl;

class PulsatingColorSystem extends System<BallsEvent> {
	@:nodes var nodes: Node<PulsatingColor, Object3D>;
	var time = 0.0;

	override function update( dt: Float ) {
		time += dt;

		for (node in nodes) {
			final o = node.object3D.object;

			if (node.entity.has(Colliding)) {
				// o.color = Color.fromFloats(1, 1, 0, 1);
				o.color.r = 1;
				o.color.g = 1;
			} else if (node.entity.has(Recovering)) {
				final timeout = node.entity.get(Timeout);
				final col = 0.3 + timeout.timer / C.TIMER_TIME;
				// o.color = Color.fromFloats(col, col, 0, 1);
				o.color.r = col;
				o.color.g = col;
			} else {
				final r = Math.sin((time * 1000) / 500 + node.pulsatingColor.offset * 12) / 2 + 0.5;
				// o.color = Color.fromFloats(r, 0, 0, 1);
				o.color.r = r;
				o.color.g = 0;
			}
		}
	}
}
