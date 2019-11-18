package impl;

class TimeSystem extends System {
	public var delta(default, null) = 0.0;
	public var time(default, null) = 0.0;

	var lastTime = 0.0;

	public function new() {
	}

	override function initialize() {
		time = lastTime = kha.Scheduler.time();
	}

	override function update() {
		time = kha.Scheduler.time();
		delta = time - lastTime;
		lastTime = time;
	}
}
