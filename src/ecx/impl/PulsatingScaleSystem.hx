package impl;

class PulsatingScaleSystem extends System {
	var nodes: Family<Object3D, PulsatingScale>;
	var _o3d: Wire<Object3D>;
	var _pscale: Wire<PulsatingScale>;
	var _colliding: Wire<Colliding>;
	var _recovering: Wire<Recovering>;
	var ts: Wire<TimeSystem>;

	public function new() {
	}

	override function update() {
		final time = ts.time;

		for (node in nodes) {
			final o = _o3d.get(node).object;

			var mul = 0.8;

			if (_colliding.has(node)) {
				mul = 2;
			} else if (_recovering.has(node)) {
				mul = 1.2;
			}

			final offset = _pscale.get(node).offset;
			final sca = mul * (Math.cos(time + offset) / 2 + 1) + 0.2;
			o.scaling.x = sca;
			o.scaling.y = sca;
			o.scaling.z = sca;
		}
	}
}
