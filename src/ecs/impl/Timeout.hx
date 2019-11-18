package impl;

class Timeout extends Component {
	public var timer = 0.0;
	public var addComponents: Array<ComponentKind> = [];
	public var removeComponents: Array<ComponentKind> = [];

	public function new( timer, ?add, ?remove ) {
		this.timer = timer;
		this.addComponents = add != null ? add : [];
		this.removeComponents = remove != null ? remove : [];
	}
}
