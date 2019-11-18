package impl;

class MovingSystem extends System {
	var nodes: Family<Moving, Object3D>;
	var _moving: Wire<Moving>;
	var _o3d: Wire<Object3D>;
	var ts: Wire<TimeSystem>;

	public function new() {
	}

	override function update() {
		final time = ts.time;

		for (node in nodes) {
			final o = _o3d.get(node).object;
			final offset = _moving.get(node).offset;
			final radius = 5;
			final maxRadius = 5;
			o.position.z = Math.cos(time + 3 * offset) * maxRadius + radius;
		}
	}
}
