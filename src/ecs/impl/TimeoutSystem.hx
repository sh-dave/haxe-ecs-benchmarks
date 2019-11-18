package impl;

class TimeoutSystem extends System<BallsEvent> {
	@:nodes var nodes: Node<Timeout>;

	override function update( dt: Float ) {
		for (node in nodes) {
			final timeout = node.timeout;
			timeout.timer -= dt;

			if (timeout.timer < 0) {
				timeout.timer = 0;

				// for (ac in timeout.addComponents) {
				// }

				for (rc in timeout.removeComponents) {
					switch rc {
						case Recovering:
							node.entity.remove(Recovering);
					}
				}

				node.entity.remove(Timeout);
			}
		}
	}
}
