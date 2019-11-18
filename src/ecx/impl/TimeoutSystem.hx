package impl;

class TimeoutSystem extends System {
	var nodes: Family<Timeout>;
	var _timeout: Wire<Timeout>;
	var _recovering: Wire<Recovering>;
	var ts: Wire<TimeSystem>;

	public function new() {
	}

	override function update() {
		for (node in nodes) {
			final timeout = _timeout.get(node);
			timeout.timer -= ts.delta;

			if (timeout.timer < 0) {
				timeout.timer = 0;

				// for (ac in timeout.addComponents) {
				// }

				for (rc in timeout.removeComponents) {
					switch rc {
						case Recovering:
							_recovering.destroy(node);
							world.commit(node);
					}
				}

				_timeout.destroy(node);
				world.commit(node);
			}
		}
	}
}
