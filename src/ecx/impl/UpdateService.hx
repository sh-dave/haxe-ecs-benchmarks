package impl;

import ecx.common.systems.SystemRunner;

typedef UpdateServiceOpts = {
	frequency: Float,
}

class UpdateService extends ecx.Service {
	var runner: Wire<SystemRunner>;
	var frequency: Float;

	public function new( ?opts ) {
		this.frequency = opts != null ? opts.frequency : 1 / 60;
	}

	override function initialize() {
		kha.Scheduler.addTimeTask(function() {
			final updateStartTime = kha.Scheduler.realTime();
			runner.updateFrame();
			final updateEndTime = kha.Scheduler.realTime();
			final tickDuration = updateEndTime - updateStartTime;
			trace('tick: $tickDuration');
		}, 0, frequency);
	}
}
