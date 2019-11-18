package impl;

class Rotating extends Component {
	public var enabled = true;
	public var rotatingSpeed: Float;
	public var decreasingSpeed = 0.001;

	public function new( speed ) {
		this.rotatingSpeed = speed;
	}
}
