package expx.ecs.state;

import expx.fsm.State;
import expx.ecs.component.*;
import expx.ecs.entity.*;

class EntityState<T> extends BasicState<T> {
	var entity:Entity;
	var components:Array<Component>;
	public function new(key, next, entity, components) {
		super(key, next);
		this.entity = entity;
		this.components = components;
	}

	override function onActivate() {
		for(component in components) entity.add(component);
	}

	override function onDeactivate() {
		for(component in components) entity.remove(component);
	}
}