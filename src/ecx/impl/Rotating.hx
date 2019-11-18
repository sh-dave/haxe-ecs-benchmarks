package impl;

class Rotating extends AutoComp<RotatingData> {}

private class RotatingData {
	public var enabled = true;
	public var rotatingSpeed = 0.0;
	public var decreasingSpeed = 0.001;

	public function new() {
	}
}
