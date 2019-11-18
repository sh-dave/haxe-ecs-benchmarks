package expx.ecs.state;

import expx.fsm.State;
import expx.ecs.system.*;

class EngineState<T, Event> extends BasicState<T> {
	var engine:Engine<Event>;
	var infos:Array<SystemInfo<Event>>;

	public function new(key, next, engine, infos) {
		super(key, next);
		this.engine = engine;
		this.infos = infos;
	}

	override function onActivate() {
		for(info in infos) engine.systems.addBetween(info.before, info.after, info.system, info.id);
	}

	override function onDeactivate() {
		for(info in infos) engine.systems.remove(info.system);
	}
}

typedef SystemInfo<Event> = {system:System<Event>, ?before:SystemId, ?after:SystemId, ?id:SystemId}
