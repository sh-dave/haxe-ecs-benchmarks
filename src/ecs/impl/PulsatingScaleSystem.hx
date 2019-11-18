package impl;

class PulsatingScaleSystem extends System<BallsEvent> {
	@:nodes var nodes: Node<Object3D, PulsatingScale>;
	var time = 0.0;

	override function update( dt: Float ) {
		time += dt;

		for (node in nodes) {
			final o = node.object3D.object;

			var mul = 0.8;

			if (node.entity.has(Colliding)) {
				mul = 2;
			} else if (node.entity.has(Recovering)) {
				mul = 1.2;
			}

			final offset = node.pulsatingScale.offset;
			final sca = mul * (Math.cos(time + offset) / 2 + 1) + 0.2;
			o.scaling.x = sca;
			o.scaling.y = sca;
			o.scaling.z = sca;
		}
	}
}
