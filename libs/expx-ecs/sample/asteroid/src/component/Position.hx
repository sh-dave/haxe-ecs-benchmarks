package component;

import exp.ecs.component.*;
import util.*;

class Position extends Component {
	public var position:Point;
	public var rotation:Float;
	
	public function new(x, y, r) {
		position = new Point(x, y);
		rotation = r;
	}
}