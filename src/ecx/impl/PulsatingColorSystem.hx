package impl;

class PulsatingColorSystem extends System {
	var objects: Family<PulsatingColor, Object3D>;
	var _colliding: Wire<Colliding>;
	var _o3d: Wire<Object3D>;
	var _pcolor: Wire<PulsatingColor>;
	var _recovering: Wire<Recovering>;
	var _timeout: Wire<Timeout>;

	var ts: Wire<TimeSystem>;

	public function new() {
	}

	override function update() {
		final time = ts.time;

		for (e in objects) {
			final o = _o3d.get(e).object;

			if (_colliding.has(e)) {
				// o.color = Color.fromFloats(1, 1, 0, 1);
				o.color.r = 1;
				o.color.g = 1;
			} else if (_recovering.has(e)) {
				final col = 0.3 + _timeout.get(e).timer / C.TIMER_TIME;
				// o.color = Color.fromFloats(col, col, 0, 1);
				o.color.r = col;
				o.color.g = col;
			} else {
				final r = Math.sin((time * 1000) / 500 + _pcolor.get(e).offset * 12) / 2 + 0.5;
				// o.color = Color.fromFloats(r, 0, 0, 1);
				o.color.r = r;
				o.color.g = 0;
			}
		}
	}
}
