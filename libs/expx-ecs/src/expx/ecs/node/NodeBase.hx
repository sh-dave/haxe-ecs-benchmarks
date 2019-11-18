package expx.ecs.node;

import expx.ecs.entity.*;

class NodeBase {
	public var entity(default, null):Entity;

	var name:String = 'NodeBase';

	public function destroy() {
		entity = null;
	}

	public function toString() {
		return '$name($entity)';
	}
}