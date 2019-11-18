package;

import exp.ecs.*;
import exp.ecs.node.*;
import exp.ecs.entity.*;
import exp.ecs.system.*;
import exp.ecs.event.*;
import component.*;
import haxe.Timer;

using tink.CoreApi;

class Playground {
	static function main() {
		var engine = new Engine();
		var entity = new Entity();
		entity.add(new Velocity(1, 0));
		entity.add(new Position(0, 0));
		
		engine.entities.add(entity);
		engine.systems.add(new MovementSystem());
		engine.systems.add(new RenderSystem());
		engine.systems.add(new CustomSystem());
		engine.systems.add(new CollisionSystem({factory: Collsion}));
		
		new Timer(16).run = function() engine.update(16 / 1000);
	}
}

enum Event {
	Collsion(data:{entites:Pair<Entity, Entity>});
}

typedef MovementNode = Node<Position, Velocity>;

class MovementSystem<Event> extends System<Event> {
	@:nodes var nodes:Node<Position, Velocity>;
	
	override function update(dt:Float) {
		for(node in nodes) {
			node.position.x += node.velocity.x * dt;
			node.position.y += node.velocity.y * dt;
		}
	}
}

class RenderSystem<Event> extends System<Event> {
	@:nodes var nodes:Node<Position>;
	
	override function update(dt:Float) {
		for(node in nodes) {
			trace('${node.entity} @ ${node.position.x}, ${node.position.y}');
		}
	}
}

class CollisionSystem<Event> extends System<Event> {
	@:nodes var nodes:Node<Position>;
	
	var factory:EventFactory<Event, {entites:Pair<Entity, Entity>}>;
	
	public function new(options) {
		super();
		factory = options.factory;
	}
	
	override function update(dt:Float) {
		// when two entities collide:
		engine.events.immediate(factory({entites: new Pair(null, null)}));
	}
}

class DamageSystem<Event> extends System<Event> {
	
	var selector:EventSelector<Event, {entites:Pair<Entity, Entity>}>;
	var binding:CallbackLink;
	
	public function new(options) {
		super();
		selector = options.selector;
	}
	
	override function onAdded(engine:Engine<Event>) {
		super.onAdded(engine);
		binding = engine.events.select(selector).handle(data -> $type(data));
	}
	
	override function onRemoved(engine:Engine<Event>) {
		super.onRemoved(engine);
		binding.dissolve();
	}
}

class CustomSystem<Event> extends System<Event> {
	var nodes:NodeList<CustomNode>;
	
	override function update(dt:Float) {
		for(node in nodes) {
			$type(node); // CustomNode
			trace(node.entity.get(Position));
		}
	}
	
	override function onAdded(engine) {
		super.onAdded(engine);
		nodes = engine.getNodeList(CustomNode, engine -> new TrackingNodeList(engine, CustomNode.new, entity -> entity.has(Position)));
	}
	
	override function onRemoved(engine) {
		super.onRemoved(engine);
		nodes = null;
	}
}

class CustomNode extends NodeBase {
	public function new(entity) {
		this.entity = entity;
	}
}
