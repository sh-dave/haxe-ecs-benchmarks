package impl;

class RotatingSystem extends System {
	var objects: Family<Rotating, Object3D>;
	var _rotating: Wire<Rotating>;
	var _o3d: Wire<Object3D>;
	var ts: Wire<TimeSystem>;

	public function new() {
	}

	override function update() {
		final delta = ts.delta;

		for (e in objects) {
			final speed = _rotating.get(e).rotatingSpeed;
			final o = _o3d.get(e).object;

			o.rotation.x += speed * delta;
			o.rotation.y += speed * delta * 2;
			o.rotation.z += speed * delta * 3;
		}
	}
}
