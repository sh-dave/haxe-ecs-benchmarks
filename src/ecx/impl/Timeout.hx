package impl;

class Timeout extends AutoComp<TimeoutData> {}

private class TimeoutData {
	public var timer = 0.0;
	public var addComponents: Array<ComponentKind> = [];
	public var removeComponents: Array<ComponentKind> = [];

	public function new() {
	}
}
